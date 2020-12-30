defmodule CraftupWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  object :item do
    field :id, :id
  end
end
