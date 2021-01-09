module Navbar exposing (view)

import App exposing (Msg(..))
import Html exposing (Html, a, div, form, img, input, span, text)
import Html.Attributes exposing (class, classList, src)
import Utils exposing (onClick)
import Html.Events exposing (onInput)
import Route
import Svg.Attributes
import Zondicons


view : App.Model -> Html App.Msg
view model =
    div [ class "sticky flex items-center border-b-2 space-x-2 p-4" ]
        [ logo
        , searchInput model
        , userArea model
        ]


logo : Html msg
logo =
    div [ class "" ]
        [ a
            [ Route.href Route.Home
            , class "flex items-center space-x-4"
            ]
            [ img
                [ src "http://garlandtools.org/files/icons/action/1668.png"
                , class "rounded h-10"
                ]
                []
            , span [ class "text-xl hidden sm:block" ] [ text "Manipulation.app" ]
            ]
        ]


searchInput : App.Model -> Html App.Msg
searchInput model =
    div
        [ class
            "relative flex-auto flex h-10 items-center justify-start text-gray-600 font-medium "
        ]
        [ Zondicons.search [ Svg.Attributes.class "text-gray-400 w-4 absolute ml-2" ]
        , input
            [ class "border w-full h-full pl-8 rounded"
            , onInput EnteredSearchQuery
            , onClick (if model.searchQuery /= Just "" then OpenSearchResults else NoOp)
            ]
            []
        , searchResults model
        ]


userArea : App.Model -> Html App.Msg
userArea model =
    let
        imgUrl =
            "https://img2.finalfantasyxiv.com/f/c1006670e130fe1ec501ae70fff2fcdc_96ab1df8877c1f8ba6a89a39cccfd437fc0_96x96.jpg?1610153005"
    in
    div [ class "flex items-center space-x-4" ]
        [ img
            [ src imgUrl
            , class "rounded h-10"
            ]
            []
        , span [ class "hidden sm:block" ] [ text "Nayeon Im" ]
        ]


searchResults : App.Model -> Html App.Msg
searchResults model =
    let
        isShown =
            case (model.searchQuery, model.searchResultsOpen) of
                (Nothing, _) ->
                    False

                (Just _, True) ->
                    True

                _ -> False

        opacityClass =
            if isShown then
                "opacity-100"

            else
                "opacity-0"
    in
    div
        [ class "absolute mt-48 h-40 w-full z-50 bg-white rounded-b border transition-all"
        , classList [ ( "invisible", not isShown ), ( opacityClass, True ) ]
        ]
        [ text "hi" ]
