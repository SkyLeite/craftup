defmodule CraftupWeb.ResolversTest.Game do
  use Craftup.DataCase

  alias CraftupWeb.Resolvers

  describe "items" do
    alias Craftup.Game

    @valid_attrs %{
      name: "Aetherial Something",
      description: "Used for crafting",
      icon: "some icon",
      stack_size: 99,
      plural: "As",
      singular: "A",
      patch: 1,
      level: 1
    }
    @update_attrs %{
      name: "Aetherial Something",
      description: "Used for crafting",
      icon: "some icon",
      stack_size: 99,
      plural: "As",
      singular: "A",
      patch: 1,
      level: 1
    }
    @invalid_attrs %{
      name: nil,
      description: nil,
      icon: nil,
      stack_size: nil,
      plural: nil,
      singular: nil,
      patch: nil,
      level: nil
    }

    def item_fixture(attrs \\ %{}) do
      new_attrs = attrs |> Enum.into(@valid_attrs)

      {:ok, item} = struct!(Craftup.Game.Item, new_attrs) |> Repo.insert()

      item
    end

    test "find_item/1 returns items filtered by name" do
      items = [
        item_fixture(),
        item_fixture(%{name: "asdf"}),
        item_fixture(%{name: "something lol"}),
        item_fixture(%{name: "some_item3"})
      ]

      assert Game.find_item(%{name: "some"}) == [Enum.at(items, 2), Enum.at(items, 3)]
    end
  end
end
