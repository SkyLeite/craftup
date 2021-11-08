module DataTypes.CraftingList exposing (CraftingList, WipList, craftingListSelectionSet)

import Api.Object
import Api.Object.List
import CustomScalarCodecs exposing (Id)
import DataTypes.ListItem exposing (ListItem, WipListItem, listItemSelectionSet)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias CraftingList =
    { id : Id
    , title : String
    , items : List ListItem
    }


type alias WipList =
    { title : Maybe String
    , items : List WipListItem
    }


craftingListSelectionSet : SelectionSet CraftingList Api.Object.List
craftingListSelectionSet =
    Graphql.SelectionSet.succeed CraftingList
        |> with Api.Object.List.id
        |> with Api.Object.List.title
        |> with (Api.Object.List.items listItemSelectionSet)
