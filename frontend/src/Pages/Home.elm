module Pages.Home exposing (view)

import App exposing (Msg(..))
import Graphql.SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, placeholder, style)
import Html.Events exposing (onInput)
import Api exposing (makeRequest)
import Zondicons
import Svg.Attributes
import DataTypes.Item exposing (Item)
import Maybe
import Html exposing (span)
import Html exposing (p)


view : App.Model -> Html App.Msg
view model =
    div [ class "home-container" ]
        [ searchInput EnteredItemQuery
        , itemList model.foundItems
        ]

searchInput : (String -> App.Msg) -> Html App.Msg
searchInput msg =
    div [ class "search input" ]
        [ Zondicons.search [ Svg.Attributes.class "icon" ]
        , input [ placeholder "Search...", onInput msg ] []
        ]

itemList : Maybe (List Item) -> Html App.Msg
itemList items =
    let
        isShown =
            case items of
                Just [] ->
                    "hidden"

                Just _ ->
                    ""

                Nothing ->
                    "hidden"

        i = items |> Maybe.withDefault []
    in
    div [ class "item-list", class isShown ]
        (i |> List.map (\x -> p [] [ text x.name ]))
