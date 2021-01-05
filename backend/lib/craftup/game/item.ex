defmodule Craftup.Game.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :description, :string
    field :icon, :string
    field :stack_size, :integer
    field :plural, :string
    field :singular, :string
    field :patch, :integer
    field :level, :integer

    has_one :recipe, Craftup.Game.Recipe
    has_many :ingredient_recipes, Craftup.Game.RecipeIngredient

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :icon, :stack_size, :plural, :singular, :patch, :level])
    |> validate_required([
      :name,
      :description,
      :icon,
      :stack_size,
      :plural,
      :singular,
      :patch,
      :level
    ])
  end
end
