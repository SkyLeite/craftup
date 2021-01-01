defmodule Craftup.Account.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :is_hq, :boolean, default: false
    field :is_result, :boolean
    field :quantity, :integer
    field :necessary_quantity, :integer

    belongs_to :list, Craftup.Account.List

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:quantity, :is_hq, :is_result])
    |> validate_required([:quantity, :is_hq, :is_result])
  end
end
