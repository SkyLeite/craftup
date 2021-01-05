defmodule Craftup.Account do
  import Ecto.Query

  alias Craftup.{Account.User, Repo}

  def register(%{input: attrs}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def login(%{input: %{email: email, password: password}}) do
    with user <- User |> where([i], i.email == ^email) |> Repo.one(),
         true <- User.verify_password(user, password) do
      claims = %{"user_id" => user.id}
      {:ok, %{token: CraftupWeb.Token.generate_and_sign!(claims)}}
    else
      false -> {:error, "Incorrect password"}
      nil -> {:error, "No user found"}
      {:error, err} -> {:error, err}
    end
  end
end
