defmodule CraftupWeb.Schema do
  use Absinthe.Schema

  import_types(CraftupWeb.Schema.DataTypes)

  alias CraftupWeb.Resolvers

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Craftup.Game, Craftup.Game.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get a list of items"
    field :items, non_null(list_of(non_null(:item))) do
      arg(:name, non_null(:string))
      resolve(&Resolvers.Game.find_item/3)
    end

    @desc "Gets the current logged in user"
    field :me, non_null(:user) do
      resolve(&Resolvers.Account.me/3)
    end
  end

  mutation do
    @desc "Register a user"
    field :register, non_null(:user) do
      arg(:input, non_null(:register_input))

      resolve(&Resolvers.Account.register/3)

      middleware(fn resolution, _ ->
        case resolution.value do
          %{id: id} ->
            Map.update!(
              resolution,
              :context,
              &Map.merge(&1, %{user: id})
            )

          _ ->
            resolution
        end
      end)
    end

    @desc "Login"
    field :login, non_null(:user) do
      arg(:input, non_null(:login_input))

      resolve(&Resolvers.Account.login/3)

      middleware(fn resolution, _ ->
        case resolution.value do
          %{id: id} ->
            Map.update!(
              resolution,
              :context,
              &Map.merge(&1, %{user: id})
            )

          _ ->
            resolution
        end
      end)
    end

    @desc "Create a list"
    field :create_list, non_null(:list) do
      arg(:input, non_null(:create_list_input))

      resolve(&Resolvers.Account.create_list/3)
    end

    @desc "Update item in list"
    field :update_list_item, non_null(:list_item) do
      arg(:id, non_null(:id))
      arg(:input, non_null(:update_list_item_input))

      resolve(&Resolvers.Account.update_list_item/3)
    end

    @desc "Remove item from list"
    field :remove_list_item, non_null(:list) do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Account.delete_list_item/3)
    end
  end
end
