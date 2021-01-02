defmodule CraftupWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :recipe_ingredient do
    field :quantity, non_null(:integer)
    field :item, :item
  end

  object :recipe do
    field :can_hq, non_null(:boolean)
    field :can_quick_synth, non_null(:boolean)
    field :difficulty, non_null(:integer)
    field :durability, non_null(:integer)
    field :is_specialization_required, non_null(:boolean)
    field :patch_number, non_null(:integer)
    field :quality, non_null(:integer)
    field :required_control, non_null(:integer)
    field :required_craftsmanship, non_null(:integer)
    field :stars, non_null(:integer)

    field :ingredients, non_null(list_of(:recipe_ingredient)), resolve: dataloader(Game)
  end

  object :item do
    field :id, :id
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :icon, non_null(:string)
    field :stack_size, non_null(:integer)
    field :plural, non_null(:string)
    field :singular, non_null(:string)
    field :patch, non_null(:integer)
    field :level, non_null(:integer)

    field :recipe, :recipe
  end
end
