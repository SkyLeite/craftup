module WipList exposing (..)

import DataTypes.CraftingList exposing (WipList)
import DataTypes.Item exposing (Item)
import DataTypes.ListItem exposing (WipListItem)
import Html exposing (Html, div)
import Html.Attributes exposing (class, classList)
import Icons
import Msg exposing (Msg(..))
import Ui.Button
import Utils exposing (onClick)


initCraftingList : Item -> WipList
initCraftingList item =
    { title = Nothing
    , items = [ initListItem item ]
    }


initListItem : Item -> WipListItem
initListItem item =
    { item = item, necessaryQuantity = 0 }


addItem : Maybe WipList -> Item -> WipList
addItem list item =
    list
        |> Maybe.map (\x -> { x | items = initListItem item :: x.items })
        |> Maybe.withDefault (initCraftingList item)


view : Maybe WipList -> Bool -> Html Msg
view list open =
    case list of
        Just l ->
            div [ class "absolute bottom-12" ]
                [ listView l open
                , Ui.Button.init ""
                    |> Ui.Button.withIcon (Icons.listCheck (Just 22))
                    |> Ui.Button.withAttribute (class "h-10 w-14")
                    |> Ui.Button.withAttribute (onClick ToggleWipList)
                    |> Ui.Button.view
                ]

        Nothing ->
            div [] []


listView : WipList -> Bool -> Html Msg
listView list open =
    div
        [ class "mb-2 bg-white border rounded w-96 h-96"
        , classList [ ( "hidden", not open ) ]
        ]
        []
