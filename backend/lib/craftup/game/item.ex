defmodule Craftup.Game.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
