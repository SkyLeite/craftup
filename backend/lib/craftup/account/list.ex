defmodule Craftup.Account.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :title, :string

    has_many :items, Craftup.Account.ListItem

    belongs_to :user, Craftup.Account.User

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
