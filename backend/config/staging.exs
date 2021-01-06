use Mix.Config

# Configure your database
config :craftup, Craftup.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :craftup, CraftupWeb.Endpoint,
  url: [
    host: "craftup-api.herokuapp.com",
    port: 80
  ],
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000")
  ],
  debug_errors: true,
  secret_key_base: secret_key_base

config :joken, default_signer: "###craftuptestsigner###"

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 10

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
