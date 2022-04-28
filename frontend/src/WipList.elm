module WipList exposing (..)

import DataTypes.CraftingList exposing (WipList)
import DataTypes.Item exposing (Item)
import DataTypes.ListItem exposing (WipListItem)
import Html exposing (Html, button, div, img, li, span, text, ul)
import Html.Attributes exposing (class, classList, src)
import Icons
import Msg exposing (Msg(..))
import Pages.Item exposing (iconUrl)
import Ui.Button
import Ui.Quantity
import Utils exposing (onClick)


initCraftingList : Item -> WipList
initCraftingList item =
    { title = Nothing
    , items = [ initListItem item ]
    }


initListItem : Item -> WipListItem
initListItem item =
    { item = item, necessaryQuantity = 1 }


listItemByItemName : String -> WipList -> Maybe WipListItem
listItemByItemName name wipList =
    wipList.items
        |> List.filter (\i -> i.item.name == name)
        |> List.head


updateQuantity : (Int -> Int) -> String -> WipList -> WipList
updateQuantity f name ({ items } as list) =
    let
        updateWipListItem ({ item, necessaryQuantity } as wipListItem) =
            if item.name == name then
                { wipListItem | necessaryQuantity = f necessaryQuantity }

            else
                wipListItem
    in
    { list | items = items |> List.map updateWipListItem }


increaseListItem : String -> WipList -> WipList
increaseListItem =
    updateQuantity (\x -> x + 1)


decreaseListItem : String -> WipList -> WipList
decreaseListItem =
    updateQuantity (\x -> x - 1)


addItem : Maybe WipList -> Item -> WipList
addItem list item =
    let
        foundItem =
            list
                |> Maybe.andThen (listItemByItemName item.name)

        updateItem : WipListItem -> WipListItem
        updateItem i =
            foundItem
                |> Maybe.map
                    (\f ->
                        if i.item.name == f.item.name then
                            { f | necessaryQuantity = f.necessaryQuantity + 1 }

                        else
                            i
                    )
                |> Maybe.withDefault i
    in
    list
        |> Maybe.map
            (\x ->
                case foundItem of
                    Just _ ->
                        { x | items = x.items |> List.map updateItem }

                    Nothing ->
                        { x | items = initListItem item :: x.items }
            )
        |> Maybe.withDefault (initCraftingList item)


removeItem : WipList -> String -> Maybe WipList
removeItem list itemName =
    let
        newItems =
            list.items |> List.filter (\listItem -> listItem.item.name /= itemName)
    in
    if List.length newItems > 0 then
        Just { list | items = newItems }

    else
        Nothing


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
        [ ul [ class "divide-solid divide-y max-h-96 overflow-auto" ] (list.items |> List.map listItemView) ]



-- TODO: Continue adding functionality here


listItemView : WipListItem -> Html Msg
listItemView listItem =
    li
        [ class "flex items-center py-2" ]
        [ img [ class "w-8 mr-2", listItem.item.icon |> iconUrl |> src ] []
        , div [ class "flex items-center justify-between w-full" ]
            [ span [] [ text listItem.item.name ]
            , div [ class "flex items-center h-7" ]
                [ Ui.Quantity.init listItem.necessaryQuantity
                    ( IncreaseWipItemQuantity listItem.item.name
                    , DecreaseWipItemQuantity listItem.item.name
                    )
                    |> Ui.Quantity.withMin 1
                    |> Ui.Quantity.view
                , Ui.Button.init ""
                    |> Ui.Button.withAttribute (class "ml-1 h-full")
                    |> Ui.Button.withAttribute (onClick (RemoveItemFromWipList listItem.item.name))
                    |> Ui.Button.withIcon (Icons.delete Nothing)
                    |> Ui.Button.view
                ]
            ]
        ]
