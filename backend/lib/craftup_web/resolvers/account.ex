defmodule CraftupWeb.Resolvers.Account do
  def register(_parent, args, _resolution) do
    Craftup.Account.register(args)
  end

  def login(_parents, args, _resolution) do
    Craftup.Account.login(args)
  end

  def me(_parents, _args, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
