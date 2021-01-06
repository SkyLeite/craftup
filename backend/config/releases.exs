import Mix.Config

# Configure your database
config :craftup, Craftup.Repo,
  username: System.fetch_env!("PGUSER"),
  password: System.fetch_env!("PGPASSWORD"),
  database: System.fetch_env!("PGDATABASE"),
  hostname: System.fetch_env!("PGHOST"),
  port: System.fetch_env!("PGPORT") |> String.to_integer(),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :craftup, CraftupWeb.Endpoint,
  url: [port: System.fetch_env!("PORT")],
  cache_static_manifest: "priv/static/cache_manifest.json"
