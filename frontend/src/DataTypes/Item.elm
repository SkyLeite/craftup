module DataTypes.Item exposing (Item, itemSearchQuery, itemSelectionSet)

import Api.Object.Item
import Api.Query
import Graphql.SelectionSet exposing (SelectionSet)
import Api.Object
import Graphql.Operation exposing (RootQuery)

type alias Item =
    { name : String
    }

itemSearchQuery : String -> SelectionSet (List Item) RootQuery
itemSearchQuery name =
    Api.Query.items { name = name } itemSelectionSet

itemSelectionSet : SelectionSet Item Api.Object.Item
itemSelectionSet =
    Graphql.SelectionSet.map Item Api.Object.Item.name
