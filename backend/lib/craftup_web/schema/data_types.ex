defmodule CraftupWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :recipe_ingredient do
    field :quantity, non_null(:integer)
    field :item, non_null(:item), resolve: dataloader(Craftup.Game)
  end

  object :recipe do
    field :can_hq, non_null(:boolean)
    field :can_quick_synth, non_null(:boolean)
    field :is_specialization_required, non_null(:boolean)
    field :patch_number, non_null(:integer)
    field :required_control, non_null(:integer)
    field :required_craftsmanship, non_null(:integer)

    field :ingredients, list_of(:recipe_ingredient), resolve: dataloader(Craftup.Game)
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

    field :recipe, :recipe, resolve: dataloader(Craftup.Game)
  end

  object :user do
    field :id, :id
    field :email, :string
  end

  input_object :register_input do
    field :email, :string
    field :password, :string
  end
end
