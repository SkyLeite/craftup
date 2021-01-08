defmodule Craftup.Factory do
  alias Craftup.Repo

  # Factories

  def build(:user) do
    %Craftup.Account.User{
      email: "test@email.com#{System.unique_integer([:positive])}",
      password: Argon2.hash_pwd_salt("12345")
    }
  end

  def build(:list) do
    %Craftup.Account.List{
      title: "some title",
      user: build(:user)
    }
  end

  def build(:item) do
    %Craftup.Game.Item{
      id: System.unique_integer([:positive]),
      name: "Some item",
      description: "Some description",
      icon: "Some icon",
      stack_size: 99,
      plural: "Some items",
      singular: "Some item",
      patch: 1,
      level: 45
    }
  end

  def build(:recipe) do
    %Craftup.Game.Recipe{
      id: System.unique_integer([:positive]),
      can_hq: true,
      can_quick_synth: true,
      is_specialization_required: false,
      patch_number: 1,
      required_control: 1,
      required_craftsmanship: 1,
      resulting_item_quantity: 1,
      difficulty_factor: 1,
      durability_factor: 1,
      quality_factor: 1,
      recipe_level: build(:recipe_level)
    }
  end

  def build(:recipe_level) do
    %Craftup.Game.RecipeLevel{
      class_job_level: 1,
      difficulty: 1,
      durability: 1,
      quality: 1,
      stars: 1,
      suggested_control: 1,
      suggested_craftsmanship: 1
    }
  end

  def build(:item_with_recipe) do
    build(:item, recipe: build(:recipe))
  end

  def build(:list_item) do
    %Craftup.Account.ListItem{
      is_hq: false,
      is_result: false,
      quantity: 0,
      necessary_quantity: 1,
      item: build(:item_with_recipe)
    }
  end

  def build(:list_with_items) do
    build(:list,
      items: [
        build(:list_item, is_result: true),
        build(:list_item),
        build(:list_item)
      ]
    )
  end

  def build(:recipe_ingredient) do
    %Craftup.Game.RecipeIngredient{
      quantity: 1
    }
  end

  def build(:user_with_list) do
    build(:user, list: build(:list_with_items))
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
