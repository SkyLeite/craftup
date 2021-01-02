defmodule Craftup.Game.RecipeIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipe_ingredients" do
    field :quantity, :integer

    belongs_to :item, Craftup.Game.Item
    belongs_to :recipe, Craftup.Game.Recipe

    timestamps()
  end

  @doc false
  def changeset(recipe_ingredient, attrs) do
    recipe_ingredient
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
