defmodule Craftup.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string

    has_many :lists, Craftup.Account.List

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        changeset |> put_change(:password, Argon2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end

  def verify_password(user, password) do
    Argon2.verify_pass(password, user.password)
  end
end
