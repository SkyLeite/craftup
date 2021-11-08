module DataTypes.ListItem exposing (ListItem, WipListItem, listItemSelectionSet)

import Api.Object
import Api.Object.ListItem
import CustomScalarCodecs exposing (Id)
import DataTypes.Item exposing (itemSelectionSet)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias ListItem =
    { id : Id
    , item : DataTypes.Item.Item
    , necessaryQuantity : Int
    }


type alias WipListItem =
    { item : DataTypes.Item.Item
    , necessaryQuantity : Int
    }


listItemSelectionSet : SelectionSet ListItem Api.Object.ListItem
listItemSelectionSet =
    Graphql.SelectionSet.succeed ListItem
        |> with Api.Object.ListItem.id
        |> with (Api.Object.ListItem.item itemSelectionSet)
        |> with Api.Object.ListItem.necessaryQuantity
