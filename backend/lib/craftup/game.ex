defmodule Craftup.Game do
  import Ecto.Query

  def find_item(%{name: name}) do
    Craftup.Game.Item
    |> where([i], ilike(i.name, ^"#{name}%"))
    |> Ecto.Query.limit(20)
    |> Craftup.Repo.all()
  end

  def data() do
    Dataloader.Ecto.new(Craftup.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
