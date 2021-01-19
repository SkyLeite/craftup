module Components exposing (searchInput)

import Html exposing (Html, div, input)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onInput)
import Msg exposing (Msg(..))
import Svg.Attributes
import Zondicons


searchInput : (String -> Msg) -> Html Msg
searchInput msg =
    div [ class "search input" ]
        [ Zondicons.search [ Svg.Attributes.class "icon" ]
        , input [ placeholder "Search...", onInput msg ] []
        ]
