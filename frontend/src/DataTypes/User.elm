module DataTypes.User exposing (User, meQuery, userSelectionSet)

import Api.Object
import Api.Object.User
import Api.Query
import CustomScalarCodecs exposing (Id)
import DataTypes.CraftingList exposing (CraftingList, craftingListSelectionSet)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias User =
    { id : Id
    , email : String
    , lists : List CraftingList
    }


meQuery : SelectionSet User RootQuery
meQuery =
    Api.Query.me userSelectionSet


userSelectionSet : SelectionSet User Api.Object.User
userSelectionSet =
    Graphql.SelectionSet.succeed User
        |> with Api.Object.User.id
        |> with Api.Object.User.email
        |> with (Api.Object.User.lists craftingListSelectionSet)
