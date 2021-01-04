defmodule Craftup.Repo.Migrations.CreateRecipeIngredients do
  use Ecto.Migration

  def change do
    create table(:recipe_ingredients) do
      add :quantity, :integer, default: 1, null: false

      add :item_id, references(:items, on_delete: :delete_all), null: false
      add :recipe_id, references(:recipes, on_delete: :delete_all), null: false

      add :inserted_at, :utc_datetime, default: fragment("NOW()")
      add :updated_at, :utc_datetime, default: fragment("NOW()")
    end

    create index(:recipe_ingredients, [:item_id])
    create index(:recipe_ingredients, [:recipe_id])
  end
end
