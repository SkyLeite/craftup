defmodule Craftup.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :can_hq, :boolean, default: false, null: false
      add :can_quick_synth, :boolean, default: false, null: false
      add :difficulty, :integer
      add :durability, :integer
      add :stars, :integer
      add :required_control, :integer
      add :required_craftsmanship, :integer
      add :patch_number, :integer
      add :quality, :integer
      add :is_specialization_required, :boolean, default: false, null: false

      add :required_item_id, references(:items, on_delete: :delete_all), null: false
      add :resulting_item_id, references(:items, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
