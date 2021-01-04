defmodule Craftup.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :can_hq, :boolean, default: false, null: false
      add :can_quick_synth, :boolean, default: false, null: false
      add :difficulty, :integer, null: false
      add :durability, :integer, null: false
      add :stars, :integer, null: false
      add :required_control, :integer, null: false
      add :required_craftsmanship, :integer, null: false
      add :patch_number, :integer, null: false
      add :quality, :integer, null: false
      add :is_specialization_required, :boolean, default: false, null: false

      add :resulting_item_id, references(:items, on_delete: :delete_all), null: false

      add :inserted_at, :utc_datetime, default: fragment("NOW()")
      add :updated_at, :utc_datetime, default: fragment("NOW()")
    end

  end
end
