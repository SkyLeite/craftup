defmodule Craftup.Repo.Migrations.ResultingItemIdToItemId do
  use Ecto.Migration

  def change do
    rename table(:recipes), :resulting_item_id, to: :item_id
  end
end
