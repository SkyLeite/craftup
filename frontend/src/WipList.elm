module WipList exposing (..)

import DataTypes.CraftingList exposing (WipList)
import DataTypes.Item exposing (Item)
import DataTypes.ListItem exposing (WipListItem)
import Html exposing (Html, div, li, text, ul)
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
    let
        opacityClass =
            if open then
                "opacity-100"

            else
                "opacity-0"
    in
    div
        [ class "absolute p-4 mb-2 bg-white border rounded shadow-md bottom-10 w-96 h-min-content transition-all duration-100"
        , class opacityClass
        , classList
            [ ( "invisible", not open )
            ]
        ]
        [ ul [] (list.items |> List.map listItemView) ]



-- TODO: Continue adding functionality here


listItemView : WipListItem -> Html Msg
listItemView listItem =
    li
        [ class "rounded" ]
        [ text listItem.item.name ]
