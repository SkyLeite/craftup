defmodule CraftupWeb.Schema do
  use Absinthe.Schema

  import_types(CraftupWeb.Schema.DataTypes)

  alias CraftupWeb.Resolvers

  query do
    @desc "Get a list of items"
    field :items, list_of(:item) do
      arg(:name, non_null(:string))
      resolve(&Resolvers.Game.find_item/3)
    end
  end
end
