module DataTypes.Recipe exposing (Recipe, recipeSelectionSet)

import Api.Object
import Api.Object.Recipe
import DataTypes.RecipeIngredient exposing (RecipeIngredient, recipeIngredientSelectionSet)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias Recipe =
    { canHq : Bool
    , ingredients : List RecipeIngredient
    }


recipeSelectionSet : SelectionSet Recipe Api.Object.Recipe
recipeSelectionSet =
    Graphql.SelectionSet.succeed Recipe
        |> with Api.Object.Recipe.canHq
        |> with (Api.Object.Recipe.ingredients recipeIngredientSelectionSet)
