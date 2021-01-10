defmodule CraftupWeb.Router do
  use Phoenix.Router

  pipeline :graphql do
    plug CraftupWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CraftupWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}

    forward "/", Absinthe.Plug,
      schema: CraftupWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}
  end

  def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    if user = blueprint.execution.context[:user] do
      conn
      |> fetch_session()
      |> put_session(:user, user)
    else
      conn
    end
  end

  def absinthe_before_send(conn, _) do
    conn
  end
end
