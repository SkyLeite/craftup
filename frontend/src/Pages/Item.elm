module Pages.Item exposing (view)

import DataTypes.Item exposing (Item)
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


view : Item -> Html Msg
view item =
    div [ class "flex" ]
        [ img [ item.icon |> iconUrl |> src ] []
        , span [] [ text item.name ]
        ]
