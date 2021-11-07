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

    field :ingredients, non_null(list_of(non_null(:recipe_ingredient))), resolve: dataloader(Craftup.Game)
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

  object :list_item do
    field :id, :id
    field :is_hq, :string
    field :is_result, :string
    field :quantity, :integer
    field :necessary_quantity, :integer

    field :item, :item, resolve: dataloader(Craftup.Game)
  end

  object :list do
    field :id, non_null(:id)
    field :title, non_null(:string)

    field :items, non_null(list_of(:list_item)), resolve: dataloader(Craftup.Game)
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)

    field :lists, non_null(list_of(non_null(:list))), resolve: dataloader(Craftup.Game)
  end

  input_object :register_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  input_object :login_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  input_object :item_input do
    field :id, non_null(:id)
    field :quantity, non_null(:integer)
    field :is_hq, non_null(:boolean)
  end

  input_object :create_list_input do
    field :title, non_null(:string)
    field :items, non_null(list_of(:item_input))
  end

  input_object :update_list_item_input do
    field :is_hq, non_null(:boolean)
    field :quantity, non_null(:integer)
    field :necessary_quantity, non_null(:integer)
  end
end
