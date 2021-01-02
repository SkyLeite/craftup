defmodule CraftupWeb.Resolvers.Game do
  def find_item(_parent, args, _resolution) do
    {:ok, Craftup.Game.find_item(args)}
  end
end
