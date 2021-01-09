module Utils exposing (onClick)
import Html
import Html.Events
import Json.Decode

onClick : msg -> Html.Attribute msg
onClick msg =
    Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( msg, True ))
