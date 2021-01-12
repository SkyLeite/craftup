module Pages.Home exposing (view)

import Api exposing (makeRequest)
import App exposing (Msg(..))
import DataTypes.Item exposing (Item)
import Graphql.SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, div, img, input, p, span, text)
import Html.Attributes exposing (class, placeholder, src, style)
import Html.Events exposing (onInput)
import Maybe
import Svg.Attributes
import Zondicons


view : App.Model -> Html App.Msg
view model =
    div [ class "home-container" ]
        []


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

        i =
            items |> Maybe.withDefault []
    in
    div [ class "item-list", class isShown ]
        (i |> List.map itemListItem)


itemListItem : Item -> Html App.Msg
itemListItem item =
    div [ class "list-item-container" ]
        [ div [ class "icon" ]
            [ img [ src "https://xivapi.com/cj/1/gladiator.png" ] []
            ]
        , div [ class "item-name" ] [ text item.name ]
        , div [ class "item-stats" ] [ text "Lvl 80" ]
        , div [ class "actions" ] [ Zondicons.listAdd [ Svg.Attributes.class "icon" ] ]
        ]
