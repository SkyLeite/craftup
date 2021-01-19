module Pages.Home exposing (view)

import Html exposing (Html, div, h1, h2, li, p, text, ul)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "p-8 space-y-4" ]
        [ h1 [ class "font-semibold text-xl" ] [ text "Welcome to Manipulation!" ]
        , p [] [ text """
                         Manipulation aims to make your crafting experience in Eorzea butter smooth.
                         Using modern web development techniques, we can help you along in the entire process
                          of growing your fortune in Final Fantasy XIV with no fuss or complications.
                         """ ]
        , h2 [ class "font-semibold text-lg" ] [ text "Here's how:" ]
        , ul [ class "list-disc list-inside space-y-4" ]
            [ li [ class "text-lg bg-green-50 rounded px-4 py-2" ]
                [ text "Lists"
                , p [ class "text-base" ] [ text "Create a list to streamline the process of making one (or more!) items. Share it with your friends, your free company, or even on Twitter." ]
                ]
            , li [ class "text-lg text-lg bg-green-50 rounded px-4 py-2" ]
                [ text "Alerts"
                , p [ class "text-base" ] [ text "Never miss a node again! With alerts, you can get notified right when an item you need is about to spawn." ]
                ]
            ]
        ]
