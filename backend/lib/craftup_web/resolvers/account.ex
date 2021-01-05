defmodule CraftupWeb.Resolvers.Account do
  def register(_parent, args, _resolution) do
    Craftup.Account.register(args)
  end
end
