module Ui.Button exposing (init, view, withAttribute, withIcon)

import Html exposing (Attribute, Html, button, div, span, text)
import Html.Attributes exposing (class)
import Icons exposing (Icon)


type alias Options msg =
    { attributes : List (Attribute msg), text : String, icon : Maybe (Icon msg) }


init : String -> Options msg
init text =
    { attributes = [], text = text, icon = Nothing }


withAttribute : Attribute msg -> Options msg -> Options msg
withAttribute attribute options =
    { options | attributes = attribute :: options.attributes }


withIcon : Icon msg -> Options msg -> Options msg
withIcon icon options =
    { options | icon = Just icon }


view : Options msg -> Html msg
view options =
    let
        classes =
            "flex items-center justify-center p-2 font-semibold text-center text-white bg-green-500 rounded shadow-md"

        icon =
            options.icon
                |> Maybe.map (\x -> span [ class "mr-2 text-white" ] [ x ])
                |> Maybe.withDefault (div [] [])
    in
    button
        (class classes :: options.attributes)
        [ icon
        , text options.text
        ]
