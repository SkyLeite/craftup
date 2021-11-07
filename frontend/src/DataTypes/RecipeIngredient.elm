module DataTypes.RecipeIngredient exposing (RecipeIngredient, recipeIngredientSelectionSet)

import Api.Object
import Api.Object.RecipeIngredient
import DataTypes.RecipeItem exposing (RecipeItem, recipeItemSelectionSet)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias RecipeIngredient =
    { quantity : Int
    , item : RecipeItem
    }


recipeIngredientSelectionSet : SelectionSet RecipeIngredient Api.Object.RecipeIngredient
recipeIngredientSelectionSet =
    Graphql.SelectionSet.succeed RecipeIngredient
        |> with Api.Object.RecipeIngredient.quantity
        |> with (Api.Object.RecipeIngredient.item recipeItemSelectionSet)
