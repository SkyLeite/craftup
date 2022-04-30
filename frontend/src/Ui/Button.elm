module Ui.Button exposing
    ( ButtonColor(..)
    , ButtonVariant(..)
    , init
    , view
    , withAttribute
    , withColor
    , withDisabled
    , withIcon
    , withVariant
    )

import Html exposing (Attribute, Html, button, div, span, text)
import Html.Attributes exposing (class, classList)
import Icons exposing (Icon)


type alias Options msg =
    { attributes : List (Attribute msg)
    , text : String
    , icon : Maybe (Icon msg)
    , disabled : Bool
    , color : ButtonColor
    , variant : ButtonVariant
    }


type ButtonColor
    = Green
    | Red


type ButtonVariant
    = Normal
    | Condensed


init : String -> Options msg
init text =
    { attributes = [], text = text, icon = Nothing, disabled = False, color = Green, variant = Normal }


withAttribute : Attribute msg -> Options msg -> Options msg
withAttribute attribute options =
    { options | attributes = attribute :: options.attributes }


withIcon : Icon msg -> Options msg -> Options msg
withIcon icon options =
    { options | icon = Just icon }


withDisabled : Bool -> Options msg -> Options msg
withDisabled disabled options =
    { options | disabled = disabled }


withColor : ButtonColor -> Options msg -> Options msg
withColor color options =
    { options | color = color }


withVariant : ButtonVariant -> Options msg -> Options msg
withVariant variant options =
    { options | variant = variant }


view : Options msg -> Html msg
view options =
    let
        colorClasses =
            case options.color of
                Green ->
                    [ class "bg-green-500" ]

                Red ->
                    [ class "bg-red-500" ]

        variantClasses =
            case options.variant of
                Normal ->
                    [ class "" ]

                Condensed ->
                    [ class "h-7" ]

        classes =
            "flex items-center justify-center p-2 font-semibold text-center text-white rounded shadow-md"

        icon =
            options.icon
                |> Maybe.map (\x -> span [ class "text-white", classList [ ( "mr-2", options.text /= "" ) ] ] [ x ])
                |> Maybe.withDefault (div [] [])
    in
    button
        (class classes :: options.attributes ++ variantClasses ++ colorClasses)
        [ icon
        , text options.text
        ]
