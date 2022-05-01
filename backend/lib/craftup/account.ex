defmodule Craftup.Account do
  import Ecto.Query

  alias Craftup.Repo
  alias Craftup.Account.{User, List, ListItem}
  alias Craftup.Game.{Item, Recipe}

  @item_ingredient_query """
  WITH RECURSIVE
      t (item_id, quantity, root) AS (
          SELECT item_id, CAST($2 AS integer), item_id FROM recipes

          UNION

          SELECT sub_ingredients.item_id, (sub_ingredients.quantity * t.quantity), root
          FROM t
          JOIN recipes ON (recipes.item_id = t.item_id)
          JOIN recipe_ingredients sub_ingredients ON (sub_ingredients.recipe_id = recipes.id)
      )
  SELECT item_id, name, quantity, root
  FROM t
  LEFT JOIN items ON (t.item_id = items.id)
  WHERE root = $1
  ORDER BY root, name;
  """

  def register(%{input: attrs}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def login(%{input: %{email: email, password: password}}) do
    with user <- User |> where([i], i.email == ^email) |> Repo.one(),
         true <- User.verify_password(user, password) do
      {:ok, user |> Map.delete(:password)}
    else
      false -> {:error, "Incorrect password"}
      nil -> {:error, "No user found"}
      {:error, err} -> {:error, err}
    end
  end

  defp get_item_ingredients(%{id: id, quantity: quantity}) do
    Repo
    |> Ecto.Adapters.SQL.query!(@item_ingredient_query, [
      String.to_integer(id),
      quantity
    ])
    |> Map.fetch!(:rows)
    |> Enum.map(fn [id, name, quantity, _root] ->
      %{id: id, name: name, quantity: quantity}
    end)
  end

  def create_list(user, %{input: %{title: title, items: item_inputs}}) do
    item_ids = item_inputs |> Enum.map(fn x -> String.to_integer(x.id) end)

    list_items =
      item_inputs
      |> Enum.map(&get_item_ingredients/1)
      |> Elixir.List.flatten()
      |> Enum.reduce(%{}, fn %{id: id, quantity: quantity} = elem, results ->
        Map.update(results, id, elem, fn %{quantity: old_quantity} = result ->
          Map.put(result, :quantity, old_quantity + quantity)
        end)
      end)
      |> Map.values()
      |> Enum.map(fn x ->
        is_result = Enum.member?(item_ids, x.id)

        is_hq =
          is_result &&
            item_inputs
            |> Enum.find(fn y -> x.id == String.to_integer(y.id) end)
            |> case do
              nil -> false
              i -> i |> Map.fetch!(:is_hq) |> Kernel.==(true)
            end

        %ListItem{}
        |> ListItem.changeset(%{
          is_hq: is_hq,
          is_result: is_result,
          quantity: 0,
          necessary_quantity: x.quantity,
          item_id: x.id
        })
      end)

    %List{}
    |> List.changeset(%{title: title})
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:items, list_items)
    |> Repo.insert()
  end

  def delete_list(user, list_id) do
    List
    |> Ecto.Query.where([l], l.id == ^list_id and l.user_id == ^user.id)
    |> Repo.one!()
    |> Repo.delete()
  end

  def update_list_item(user, id, args) do
    ListItem
    |> where([li], li.id == ^id)
    |> Repo.one!()
    |> ListItem.changeset(args, user.id)
    |> ListItem.validate_is_owner(user.id)
    |> Repo.update()
  end

  def delete_list_item(user, id) do
    ListItem
    |> where([li], li.id == ^id)
    |> Repo.one!()
    |> ListItem.changeset(%{})
    |> ListItem.validate_is_owner(user.id)
    |> Repo.delete()
  end
end
