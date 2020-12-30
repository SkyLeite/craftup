defmodule Craftup.Game do
  def list_items() do
    Craftup.Game.Item
    |> Craftup.Repo.all()
  end
end
