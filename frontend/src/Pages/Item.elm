module Pages.Item exposing (view)

import Html exposing (Html, div, img, span, text)
import Html.Attributes exposing (class, src)
import Model exposing (Model)
import Msg exposing (Msg)


iconUrl : String -> String
iconUrl id =
    let
        folder =
            id |> String.left 2 |> (\x -> "0" ++ x ++ "000")

        file =
            "0" ++ id
    in
    "https://xivapi.com/i/" ++ folder ++ "/" ++ file ++ ".png"


view : Model -> String -> Html Msg
view model name =
    div [ class "flex" ]
        [ img [ model.foundItem |> Maybe.map .icon |> Maybe.map iconUrl |> Maybe.withDefault "" |> src ] []
        , span [] [ model.foundItem |> Maybe.map .name |> Maybe.withDefault "Not found" |> text ]
        ]
