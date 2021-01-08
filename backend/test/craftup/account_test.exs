defmodule Craftup.Test.Account do
  use CraftupWeb.ConnCase

  alias Craftup.Factory

  describe "list_items" do
    alias Craftup.Account.ListItem

    @tag :wip
    test "create_list/2 correctly creates a list with an item's ingredients" do
      user = Factory.insert!(:user)
      result_item = Factory.insert!(:item)
      recipe1 = Factory.insert!(:recipe, item: result_item)

      ingredient_items = [Factory.insert!(:item), Factory.insert!(:item)]

      ingredients = [
        Factory.insert!(:recipe_ingredient,
          recipe: recipe1,
          item: ingredient_items |> Enum.fetch!(0)
        ),
        Factory.insert!(:recipe_ingredient,
          recipe: recipe1,
          item: ingredient_items |> Enum.fetch!(1),
          quantity: 2
        )
      ]

      # The extra item is the resulting one
      expected_item_count = length(ingredients) + 1

      {:ok, result} =
        Craftup.Account.create_list(
          user,
          %{
            input: %{
              title: "My list",
              items: [%{id: result_item.id |> Integer.to_string(), quantity: 1, is_hq: false}]
            }
          }
        )

      preloaded_result = result |> Craftup.Repo.preload(items: [:item])

      ingredient_with_differing_quantity =
        ingredients |> Enum.fetch!(1) |> Map.get(:item) |> Map.get(:id)

      # List should have 3 different items
      assert result.items |> length() |> Kernel.==(expected_item_count)

      # List should respect differing quantities
      assert preloaded_result.items
             |> Enum.find(fn x ->
               x.item.id == ingredient_with_differing_quantity
             end)
             |> Map.get(:necessary_quantity)
             |> Kernel.==(2)
    end

    test "create_list/2 correctly creates a list 2 result items" do
      user = Factory.insert!(:user)
      result_item = Factory.insert!(:item)
      result_item_2 = Factory.insert!(:item)
      recipe1 = Factory.insert!(:recipe, item: result_item)
      recipe2 = Factory.insert!(:recipe, item: result_item_2)

      ingredient_items = [Factory.insert!(:item), Factory.insert!(:item)]
      ingredient_items_2 = [Factory.insert!(:item), Factory.insert!(:item)]

      ingredients =
        ingredient_items
        |> Enum.map(fn x ->
          Factory.insert!(:recipe_ingredient,
            recipe: recipe1,
            item: x
          )
        end)

      ingredients_2 =
        ingredient_items_2
        |> Enum.map(fn x ->
          Factory.insert!(:recipe_ingredient,
            recipe: recipe2,
            item: x
          )
        end)

      expected_item_count = length(ingredients) + length(ingredients_2) + 2

      {:ok, result} =
        Craftup.Account.create_list(
          user,
          %{
            input: %{
              title: "My list",
              items: [
                %{id: result_item.id |> Integer.to_string(), quantity: 1, is_hq: false},
                %{id: result_item_2.id |> Integer.to_string(), quantity: 1, is_hq: false}
              ]
            }
          }
        )

      # List should have 6 different items
      assert result.items |> length() |> Kernel.==(expected_item_count)
    end

    test "update_list_item/3 updates a list item" do
      list = Factory.insert!(:list_with_items)

      first_item = list.items |> Enum.fetch!(0)
      new_quantity = first_item.quantity + 2

      {:ok, result} =
        Craftup.Account.update_list_item(
          list.user,
          first_item |> Map.get(:id),
          %{quantity: new_quantity}
        )

      assert result.quantity == new_quantity
    end

    test "update_list_item/3 refuses to update a list item the user doesn't own" do
      user = Factory.insert!(:user)
      list = Factory.insert!(:list_with_items)

      first_item = list.items |> Enum.fetch!(0)
      new_quantity = first_item.quantity + 2

      result =
        Craftup.Account.update_list_item(
          user,
          first_item |> Map.get(:id),
          %{quantity: new_quantity}
        )

      assert {:error, _} = result
    end

    test "delete_list_item/2 deletes a list item" do
      list = Factory.insert!(:list_with_items)

      first_item = list.items |> Enum.fetch!(0)

      result = Craftup.Account.delete_list_item(list.user, first_item.id)

      assert {:ok, _} = result
    end

    test "delete_list_item/2 refuses to delete an item the user doesn't own" do
      user = Factory.insert!(:user)
      list = Factory.insert!(:list_with_items)

      first_item = list.items |> Enum.fetch!(0)

      result = Craftup.Account.delete_list_item(user, first_item.id)

      assert {:error, _} = result
    end
  end
end
