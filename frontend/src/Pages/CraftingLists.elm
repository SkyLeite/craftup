module Pages.CraftingLists exposing (view)

import App exposing (Model, Msg(..))
import Components
import Html exposing (Html, div)
import Html.Attributes exposing (class)


view : Model -> Html Msg
view model =
    div [ class "craftingListView" ]
        [ Components.searchInput (\s -> NoOp)
        , div [ class "lists" ] []
        , div [ class "main" ] []
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
