module Pages.CraftingLists exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "craftingListView" ]
        []


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
