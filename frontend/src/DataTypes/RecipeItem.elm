module DataTypes.RecipeItem exposing (RecipeItem, recipeItemSelectionSet)

import Api.Object
import Api.Object.Item
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias RecipeItem =
    { name : String
    , icon : String
    }


recipeItemSelectionSet : SelectionSet RecipeItem Api.Object.Item
recipeItemSelectionSet =
    Graphql.SelectionSet.succeed RecipeItem
        |> with Api.Object.Item.name
        |> with Api.Object.Item.icon
