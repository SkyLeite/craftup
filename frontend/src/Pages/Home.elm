module Pages.Home exposing (view)

import Api.Interface
import Api.Object exposing (Item)
import Api.Object.Item
import Api.Query
import App exposing (Msg(..))
import Components
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, placeholder, style)
import Html.Events exposing (onInput)


type alias Item =
    { name : String
    }


view : App.Model -> Html App.Msg
view model =
    div [ class "home-container" ]
        [ Components.searchInput EnteredItemQuery
        , itemList model.itemQuery
        ]


itemList : Maybe String -> Html App.Msg
itemList items =
    let
        -- isShown =
        --     if items |> List.length |> (<) 0 then
        --         "unset"
        --     else
        --         "none"
        isShown =
            case items of
                Just "" ->
                    "hidden"

                Just a ->
                    ""

                Nothing ->
                    "hidden"
    in
    div [ class "item-list", class isShown ] [ text "hi" ]
