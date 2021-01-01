defmodule Craftup.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :title, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
