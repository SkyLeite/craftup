module Footer exposing (view)

import Html exposing (Html, a, div, li, span, text, ul)
import Html.Attributes exposing (class, classList)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route exposing (Route, href)


view : Model -> Html Msg
view model =
    let
        currentRoute =
            model.route |> Maybe.withDefault Route.Home
    in
    div [ class "sticky bottom-0 border-t-2 h-12 bg-white" ]
        [ ul [ class "flex h-full w-full justify-center items-center" ]
            [ pageButton "Home" Route.Home currentRoute
            , pageButton "Lists" Route.CraftingLists currentRoute
            , pageButton "Alerts" (Route.CraftingList "1") currentRoute
            ]
        ]


pageButton : String -> Route -> Route -> Html Msg
pageButton name route activeRoute =
    let
        isActive =
            if route == activeRoute then
                True

            else
                False
    in
    li
        [ class "h-full w-20 border-b-4 mx-2"
        , classList [ ( "border-green-400", isActive ) ]
        ]
        [ a
            [ href route
            , class "h-full w-full inline-block flex items-center justify-center"
            ]
            [ span [] [ text name ] ]
        ]
