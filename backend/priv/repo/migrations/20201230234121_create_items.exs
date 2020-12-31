defmodule Craftup.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :icon, :string
      add :stack_size, :integer
      add :plural, :string
      add :singular, :string
      add :patch, :integer
      add :level, :integer

      timestamps()
    end

  end
end
