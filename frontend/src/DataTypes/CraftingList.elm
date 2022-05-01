module DataTypes.CraftingList exposing (CraftingList, WipList, craftingListSelectionSet, deleteCraftingListMutation)

import Api
import Api.Mutation
import Api.Object
import Api.Object.List
import Api.Scalar
import Api.ScalarCodecs
import CustomScalarCodecs exposing (Id)
import DataTypes.ListItem exposing (ListItem, WipListItem, listItemSelectionSet)
import Graphql.Http exposing (Error)
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


deleteCraftingListMutation : CustomScalarCodecs.Id -> (Result (Error CraftingList) CraftingList -> msg) -> Cmd msg
deleteCraftingListMutation id =
    Api.makeMutation (Api.Mutation.deleteList { id = id } craftingListSelectionSet)
