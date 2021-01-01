defmodule Craftup.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :icon, :string, null: false
      add :stack_size, :integer, null: false
      add :plural, :string, null: false
      add :singular, :string, null: false
      add :patch, :integer, null: false
      add :level, :integer, null: false

      timestamps()
    end

  end
end
