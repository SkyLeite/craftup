defmodule CraftupWeb.Router do
  use Phoenix.Router

  pipeline :graphql do
    plug CraftupWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: CraftupWeb.Schema

    forward "/", Absinthe.Plug, schema: CraftupWeb.Schema
  end
end
