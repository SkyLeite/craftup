defmodule Craftup.Account.ListItem do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "list_items" do
    field :is_hq, :boolean, default: false
    field :is_result, :boolean
    field :quantity, :integer
    field :necessary_quantity, :integer

    belongs_to :item, Craftup.Game.Item
    belongs_to :list, Craftup.Account.List

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs, user_id \\ nil) do
    list_item
    |> cast(attrs, [:necessary_quantity, :quantity, :is_hq, :is_result, :item_id])
    |> validate_required([:necessary_quantity, :quantity, :is_hq, :is_result])
    |> validate_updatable()
    |> validate_is_owner(user_id)
  end

  def validate_updatable(changeset) do
    validate_change(changeset, :necessary_quantity, fn :necessary_quantity, _necessary_quantity ->
      if !changeset.data.is_result do
        [necessary_quantity: "cannot be updated because item is not result"]
      else
        []
      end
    end)
  end

  def validate_is_owner(changeset, id) when not is_nil(id) do
    item_owner =
      from(u in Craftup.Account.User,
        join: l in Craftup.Account.List,
        on: l.user_id == u.id,
        join: li in Craftup.Account.ListItem,
        on: li.list_id == l.id,
        where: li.id == ^changeset.data.id
      )
      |> Craftup.Repo.one!()

    case item_owner.id == id do
      true -> changeset
      false -> changeset |> add_error(:id, "user does not own list")
    end
  end

  def validate_is_owner(_changeset, id) when is_nil(id), do: []
end
