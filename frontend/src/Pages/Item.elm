module Pages.Item exposing (view)
import Model exposing (Model)
import Msg exposing (Msg)
import Html exposing (Html, div, text)

view : Model -> String -> Html Msg
view model id =
        div [] [ text id ]
