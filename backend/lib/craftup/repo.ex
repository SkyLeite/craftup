defmodule Craftup.Repo do
  use Ecto.Repo,
    otp_app: :craftup,
    adapter: Ecto.Adapters.Postgres
end
