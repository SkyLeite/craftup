defmodule Craftup.Game.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :icon, :string
    field :name, :string
    field :server, :string

    belongs_to :user, Craftup.Account.User

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :server, :icon])
    |> validate_required([:name, :server, :icon])
  end
end
