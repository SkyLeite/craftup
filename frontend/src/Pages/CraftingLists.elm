module Pages.CraftingLists exposing (view)

import App exposing (Model, Msg)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, placeholder)
import Svg.Attributes
import Zondicons


view : Model -> Html Msg
view model =
    div [ class "craftingListView" ]
        [ searchInput
        , div [ class "lists" ] []
        , div [ class "main" ] []
        ]


searchInput : Html msg
searchInput =
    div [ class "search input" ]
        [ Zondicons.search [ Svg.Attributes.class "icon" ]
        , input [ placeholder "Search..." ] []
        ]


craftingLists : Html Msg
craftingLists =
    div [ class "lists" ]
        []


craftingList : Html Msg
craftingList =
    div [] []


main : Html Msg
main =
    div [ class "main" ] []
