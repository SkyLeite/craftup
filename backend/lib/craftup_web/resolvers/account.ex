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

  def create_list(_parents, args, %{context: %{current_user: user}}) do
    Craftup.Account.create_list(user, args)
  end

  def update_list_item(_parents, %{id: id, input: input}, %{context: %{current_user: user}}) do
    Craftup.Account.update_list_item(user, id, input)
  end
end
