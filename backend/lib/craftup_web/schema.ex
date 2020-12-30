defmodule CraftupWeb.Schema do
  use Absinthe.Schema

  import_types(CraftupWeb.Schema.DataTypes)

  alias CraftupWeb.Resolvers

  query do
    @desc "Get a list of items"
    field :items, list_of(:item) do
      resolve(&Resolvers.Game.list_items/3)
    end
  end
end
