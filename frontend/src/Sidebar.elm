module Sidebar exposing (view)

import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class)
import Route
import Svg
import Svg.Attributes
import Update exposing (Msg(..))
import Zondicons


view : { a | route : Maybe Route.Route } -> Html Msg
view model =
    div
        [ class "sidebar" ]
        [ sidebarEntry model { to = Route.Home, icon = Zondicons.home, title = "Home" }
        , sidebarEntry model { to = Route.CraftingLists, icon = Zondicons.list, title = "Lists" }
        ]


type alias SidebarEntryOptions =
    { to : Route.Route
    , icon : List (Svg.Attribute Msg) -> Html Msg
    , title : String
    }


sidebarEntry : { a | route : Maybe Route.Route } -> SidebarEntryOptions -> Html Msg
sidebarEntry model { to, icon, title } =
    let
        isActive =
            case model.route of
                Just r ->
                    r == to

                Nothing ->
                    False
    in
    a
        [ class
            (if isActive then
                "active"

             else
                ""
            )
        , Route.href to
        ]
        [ icon
            [ Svg.Attributes.class
                (if isActive then
                    "icon active"

                 else
                    "icon"
                )
            ]
        , text title
        ]
