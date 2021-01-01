defmodule Craftup.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string, null: false
      add :server, :string, null: false
      add :icon, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
