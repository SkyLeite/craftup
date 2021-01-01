defmodule Craftup.Repo.Migrations.CreateListItems do
  use Ecto.Migration

  def change do
    create table(:list_items) do
      add :is_hq, :boolean, default: false, null: false
      add :is_result, :boolean, null: false
      add :quantity, :integer, default: 0, null: false
      add :necessary_quantity, :integer, null: false

      add :list_id, references(:lists, on_delete: :delete_all), null: false
      add :item_id, references(:items, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
