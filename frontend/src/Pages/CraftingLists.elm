module Pages.CraftingLists exposing (view)

import DataTypes.CraftingList exposing (CraftingList)
import DataTypes.User exposing (User)
import Html exposing (Html, a, button, div, input, span, text)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route exposing (Route)
import Session exposing (SessionStatus(..))
import Svg.Attributes
import Utils
import Zondicons


view : Model -> Html Msg
view model =
    case model.session of
        LoggedIn user ->
            div [ class "pt-8 px-7 xs:px-8 space-y-4" ]
                [ tableHeader
                , tableBody user.lists model.listFilter
                ]

        Guest ->
            div [] []


tableHeader : Html Msg
tableHeader =
    div [ class "flex w-full" ] [ searchInput, actions ]


actions : Html Msg
actions =
    div [ class "flex ml-auto space-x-2" ]
        [ a
            [ class "flex rounded text-center font-semibold bg-green-500 hover:bg-green-400 transition text-white p-2 shadow-md cursor-pointer"
            , Route.href Route.NewCraftingList
            ]
            [ Zondicons.listAdd [ Svg.Attributes.class "w-5 mr-2" ], text "New list" ]
        ]


searchInput : Html Msg
searchInput =
    input
        [ type_ "text"
        , class "border rounded pl-2"
        , placeholder "Filter"
        , onInput EnteredListFilter
        ]
        []


tableBody : List CraftingList -> String -> Html Msg
tableBody lists filter =
    div [ class "w-full rounded border p-4 space-y-5" ]
        (lists
            |> List.filter
                (\l ->
                    l.title
                        |> Utils.toLowerContains filter
                )
            |> List.map singleList
        )


singleList : CraftingList -> Html Msg
singleList list =
    div [ class "crafting-list-list-item h-16 rounded px-4 py-2 cursor-pointer hover:bg-green-100" ]
        [ Zondicons.list [ Svg.Attributes.class "self-center icon w-4 mr-2" ]
        , span [ class "title font-bold text-lg" ] [ text list.title ]
        , span [ class "progress flex text-gray-400 text-sm" ]
            [ Zondicons.checkmarkOutline [ Svg.Attributes.class "w-3 mr-1" ]
            , text "0/1"
            ]
        ]
