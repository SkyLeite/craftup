defmodule Craftup.Account do
  alias Craftup.{Account.User, Repo}

  def get_user() do
  end

  def register(%{input: attrs}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
