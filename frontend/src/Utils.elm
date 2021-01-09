module Utils exposing (modal, onClick)

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, class, property)
import Html.Events
import Json.Decode
import Json.Encode exposing (bool)


onClick : msg -> Html.Attribute msg
onClick msg =
    Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( msg, True ))


modal : Bool -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
modal isOpen attributes children =
    node "dialog"
        ([ attribute "open"
            (if isOpen then
                "true"

             else
                "false"
            )
         , class "mt-16 w-4/5 h-3/6 max-w-2xl"
         ]
            ++ attributes
        )
        children
