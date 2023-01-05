module Ui.Quantity exposing (init, view, withAttribute, withDisabled, withMax, withMin)

import Html exposing (Attribute, Html, button, div, input, text)
import Html.Attributes exposing (attribute, class, classList, disabled, pattern, type_, value)
import Html.Events exposing (onClick)
import Maybe.Extra


type alias Options msg =
    { attributes : List (Attribute msg)
    , quantity : Int
    , disabled : Bool
    , onIncrease : msg
    , onDecrease : msg
    , min : Maybe Int
    , max : Maybe Int
    }


init : Int -> ( msg, msg ) -> Options msg
init quantity ( onIncrease, onDecrease ) =
    { attributes = []
    , quantity = quantity
    , disabled = False
    , onIncrease = onIncrease
    , onDecrease = onDecrease
    , min = Nothing
    , max = Nothing
    }


withAttribute : Attribute msg -> Options msg -> Options msg
withAttribute attribute options =
    { options | attributes = attribute :: options.attributes }


withDisabled : Bool -> Options msg -> Options msg
withDisabled disabled options =
    { options | disabled = disabled }


withMin : Int -> Options msg -> Options msg
withMin min options =
    { options | min = Just min }


withMax : Int -> Options msg -> Options msg
withMax max options =
    { options | max = Just max }


view : Options msg -> Html msg
view options =
    let
        classes =
            "w-12 border h-full text-center text-sm"

        buttonClasses =
            "flex items-center justify-center w-5 min-h-full h-full rounded bg-green-500 text-center text-white"
    in
    div [ class "flex items-center shadow-sm h-7" ]
        [ button
            [ class buttonClasses
            , class "border-l-0 rounded-r-none"
            , disabled (options.min |> Maybe.Extra.unwrap False (\min -> min == options.quantity))
            , onClick options.onDecrease
            ]
            [ text "-" ]
        , input
            ([ type_ "text"
             , attribute "inputmode" "numeric"
             , pattern "[0-9]*"
             , class classes
             , value (options.quantity |> String.fromInt)
             ]
                ++ options.attributes
            )
            []
        , button
            [ class buttonClasses
            , class "border-r-0 rounded-l-none"
            , disabled (options.max |> Maybe.Extra.unwrap False (\max -> max == options.quantity))
            , onClick options.onIncrease
            ]
            [ text "+" ]
        ]
