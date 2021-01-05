defmodule CraftupWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query

  alias Craftup.{Repo, Account.User}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         current_user <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    {:ok, claims} = CraftupWeb.Token.verify_and_validate(token)
    user_id = claims |> Map.fetch!("user_id")

    User |> where([u], u.id == ^user_id) |> Repo.one()
  end
end
