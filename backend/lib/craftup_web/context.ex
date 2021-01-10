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
    conn
    |> fetch_session()
    |> get_session()
    |> Map.get("user")
    |> authorize()
    |> build_context_object()
  end

  defp build_context_object(user) do
    case user do
       nil -> nil,
       user -> %{current_user: user}
    end
  end

  defp authorize(user_id) when is_nil(user_id) do
    nil
  end

  defp authorize(user_id) when not is_nil(user_id) do
    User |> where([u], u.id == ^user_id) |> Repo.one()
  end
end
