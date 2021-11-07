module DataTypes.Item exposing (Item, itemQuery, itemSearchQuery, itemSelectionSet)

import Api.Object
import Api.Object.Item
import Api.Query
import DataTypes.Recipe exposing (Recipe, recipeSelectionSet)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias Item =
    { name : String
    , icon : String
    , recipe : Maybe Recipe
    }


itemSearchQuery : String -> SelectionSet (List Item) RootQuery
itemSearchQuery name =
    Api.Query.items { name = name } itemSelectionSet


itemQuery : String -> SelectionSet (Maybe Item) RootQuery
itemQuery name =
    Api.Query.item { name = name } itemSelectionSet


itemSelectionSet : SelectionSet Item Api.Object.Item
itemSelectionSet =
    Graphql.SelectionSet.succeed Item
        |> with Api.Object.Item.name
        |> with Api.Object.Item.icon
        |> with (Api.Object.Item.recipe recipeSelectionSet)
