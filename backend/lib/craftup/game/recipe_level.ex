defmodule Craftup.Game.RecipeLevel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipe_levels" do
    field :class_job_level, :integer
    field :difficulty, :integer
    field :durability, :integer
    field :quality, :integer
    field :stars, :integer
    field :suggested_control, :integer
    field :suggested_craftsmanship, :integer

    timestamps()
  end

  @doc false
  def changeset(recipe_level, attrs) do
    recipe_level
    |> cast(attrs, [
      :class_job_level,
      :stars,
      :suggested_craftsmanship,
      :suggested_control,
      :difficulty,
      :quality,
      :durability
    ])
    |> validate_required([
      :class_job_level,
      :stars,
      :suggested_craftsmanship,
      :suggested_control,
      :difficulty,
      :quality,
      :durability
    ])
  end
end
