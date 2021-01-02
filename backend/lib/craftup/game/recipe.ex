defmodule Craftup.Game.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :can_hq, :boolean, default: false
    field :can_quick_synth, :boolean, default: false
    field :difficulty, :integer
    field :durability, :integer
    field :is_specialization_required, :boolean, default: false
    field :patch_number, :integer
    field :quality, :integer
    field :required_control, :integer
    field :required_craftsmanship, :integer
    field :stars, :integer

    belongs_to :resulting_item, Craftup.Game.Item
    has_many :required_item, Craftup.Game.RecipeItem

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [
      :can_hq,
      :can_quick_synth,
      :difficulty,
      :durability,
      :stars,
      :required_control,
      :required_craftsmanship,
      :patch_number,
      :quality,
      :is_specialization_required
    ])
    |> validate_required([
      :can_hq,
      :can_quick_synth,
      :difficulty,
      :durability,
      :stars,
      :required_control,
      :required_craftsmanship,
      :patch_number,
      :quality,
      :is_specialization_required
    ])
  end
end
