defmodule CraftupWeb.Resolvers.Account do
  def register(_parent, args, _resolution) do
    Craftup.Account.register(args)
  end

  def login(_parents, args, _resolution) do
    Craftup.Account.login(args)
  end
end
