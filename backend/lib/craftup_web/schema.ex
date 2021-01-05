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
    field :items, list_of(:item) do
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
    field :register, :user do
      arg(:input, non_null(:register_input))

      resolve(&Resolvers.Account.register/3)
    end

    @desc "Login"
    field :login, :token_payload do
      arg(:input, non_null(:login_input))

      resolve(&Resolvers.Account.login/3)
    end
  end
end
