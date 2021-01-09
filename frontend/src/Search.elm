module Search exposing (view)

import App exposing (Msg(..))
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder)


view : App.Model -> Html App.Msg
view model =
    div
        [ class "w-screen h-screen left-0 top-0 fixed z-50 bg-black bg-opacity-25 flex items-center flex-col p-4 pb-48"
        , classList [ ( "hidden", not model.searchModalOpen ) ]
        ]
        [ div
            [ class "w-full max-w-2xl p-4 bg-white h-4/5 rounded shadow-lg h-full"
            , Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( NoOp, True ))
            ]
            [ button [] [ text "hi everyone!" ] ]
        ]
