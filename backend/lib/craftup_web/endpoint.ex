defmodule CraftupWeb.Endpoint do
  require Plug.Router

  use Phoenix.Endpoint, otp_app: :craftup

  plug Corsica,
    max_age: 600,
    origins: "*",
    allow_headers: ["content-type"],
    log: [rejected: :error, invalid: :warn, accepted: :debug]

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_craftup_key",
    signing_salt: "Z7h4pOnW"
  ]

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  plug CraftupWeb.Router
end
