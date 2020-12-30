# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :craftup,
  ecto_repos: [Craftup.Repo]

# Configures the endpoint
config :craftup, CraftupWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "scPP/oqA08vvN7rV3kT7FIoeLODm+3BAdp2EBndYadJlg708jW157Lqpn0efK8U5",
  render_errors: [view: CraftupWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Craftup.PubSub,
  live_view: [signing_salt: "1wFRPHQ4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
