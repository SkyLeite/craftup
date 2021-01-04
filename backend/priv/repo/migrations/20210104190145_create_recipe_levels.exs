defmodule Craftup.Repo.Migrations.CreateRecipeLevels do
  use Ecto.Migration

  def change do
    create table(:recipe_levels) do
      add :class_job_level, :integer
      add :stars, :integer
      add :suggested_craftsmanship, :integer
      add :suggested_control, :integer
      add :difficulty, :integer
      add :quality, :integer
      add :durability, :integer

      add :inserted_at, :utc_datetime, default: fragment("NOW()")
      add :updated_at, :utc_datetime, default: fragment("NOW()")
    end

    alter table(:recipes) do
      add :recipe_level_id, references(:recipe_levels, on_delete: :delete_all), null: false
      add :resulting_item_quantity, :integer, null: false
      remove :stars, :integer
    end

    rename table(:recipes), :difficulty, to: :difficulty_factor
    rename table(:recipes), :quality, to: :quality_factor
    rename table(:recipes), :durability, to: :durability_factor
  end
end
