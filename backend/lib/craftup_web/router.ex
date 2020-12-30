defmodule CraftupWeb.Router do
  use Phoenix.Router

  forward "/graphiql",
          Absinthe.Plug.GraphiQL,
          schema: CraftupWeb.Schema

  forward "/", Absinthe.Plug, schema: CraftupWeb.Schema
end
