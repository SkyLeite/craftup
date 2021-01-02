defmodule Craftup.Game do
  import Ecto.Query

  def find_item(%{name: name}) do
    Craftup.Game.Item
    |> where([i], ilike(i.name, ^"#{name}%"))
    |> Ecto.Query.limit(20)
    |> Craftup.Repo.all()
  end
end
