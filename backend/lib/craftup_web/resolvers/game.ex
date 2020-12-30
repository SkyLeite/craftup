defmodule CraftupWeb.Resolvers.Game do
  def list_items(_parent, _args, _resolution) do
    {:ok, Craftup.Game.list_items()}
  end
end
