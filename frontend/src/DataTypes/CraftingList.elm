module DataTypes.CraftingList exposing (CraftingList, craftingListSelectionSet)

import Api.Object
import Api.Object.List
import CustomScalarCodecs exposing (Id)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias CraftingList =
    { id : Id
    , title : String
    }


craftingListSelectionSet : SelectionSet CraftingList Api.Object.List
craftingListSelectionSet =
    Graphql.SelectionSet.succeed CraftingList
        |> with Api.Object.List.id
        |> with Api.Object.List.title
