defmodule CraftupWeb.Resolvers.Game do
  def find_item(_parent, args, _resolution) do
    {:ok, Craftup.Game.find_item(args)}
  end

  def get_item(_parent, args, _resolution) do
    {:ok, Craftup.Game.get_item(args)}
  end
end
