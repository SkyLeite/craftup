module Ui.Input exposing (init, view, withAttribute, withDisabled, withIcon)

import Html exposing (Attribute, Html, button, div, input, span, text)
import Html.Attributes exposing (class, classList, type_, value)
import Icons exposing (Icon)


type alias Options msg =
    { attributes : List (Attribute msg)
    , value : String
    , icon : Maybe (Icon msg)
    , disabled : Bool
    }


init : String -> Options msg
init value =
    { attributes = [], value = value, icon = Nothing, disabled = False }


withAttribute : Attribute msg -> Options msg -> Options msg
withAttribute attribute options =
    { options | attributes = attribute :: options.attributes }


withIcon : Icon msg -> Options msg -> Options msg
withIcon icon options =
    { options | icon = Just icon }


withDisabled : Bool -> Options msg -> Options msg
withDisabled disabled options =
    { options | disabled = disabled }


view : Options msg -> Html msg
view options =
    let
        icon =
            options.icon
                |> Maybe.map (\x -> span [ class "p-1 bg-gray-500 rounded-full text-white mr-2" ] [ x ])
                |> Maybe.withDefault (div [] [])
    in
    div [ class "flex items-center" ]
        [ icon
        , input
            ([ type_ "text"
             , value options.value
             , class "rounded border px-1"
             ]
                ++ options.attributes
            )
            []
        ]
