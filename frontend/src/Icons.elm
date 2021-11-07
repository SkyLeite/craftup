module Icons exposing (Icon, addToList, loading)

import Html exposing (Html)
import Html.Attributes exposing (attribute, height, width)
import Svg exposing (g, path, svg)
import Svg.Attributes exposing (class, d, fill, id, viewBox)


type alias Icon msg =
    Html msg


defaultSize : Int
defaultSize =
    15


loading : Maybe Int -> Icon msg
loading size =
    let
        iconSize =
            size |> Maybe.withDefault defaultSize
    in
    svg
        [ class "animate-spin"
        , fill "currentColor"
        , viewBox "0 0 512 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        , width iconSize
        , height iconSize
        ]
        [ path [ d "M96 256c0-26.5-21.5-48-48-48S0 229.5 0 256s21.5 48 48 48S96 282.5 96 256zM108.9 60.89c-26.5 0-48.01 21.49-48.01 47.99S82.39 156.9 108.9 156.9s47.99-21.51 47.99-48.01S135.4 60.89 108.9 60.89zM108.9 355.1c-26.5 0-48.01 21.51-48.01 48.01S82.39 451.1 108.9 451.1s47.99-21.49 47.99-47.99S135.4 355.1 108.9 355.1zM256 416c-26.5 0-48 21.5-48 48S229.5 512 256 512s48-21.5 48-48S282.5 416 256 416zM464 208C437.5 208 416 229.5 416 256s21.5 48 48 48S512 282.5 512 256S490.5 208 464 208zM403.1 355.1c-26.5 0-47.99 21.51-47.99 48.01S376.6 451.1 403.1 451.1s48.01-21.49 48.01-47.99S429.6 355.1 403.1 355.1zM256 0C229.5 0 208 21.5 208 48S229.5 96 256 96s48-21.5 48-48S282.5 0 256 0z" ]
            []
        ]


addToList : Maybe Int -> Icon msg
addToList size =
    let
        iconSize =
            size |> Maybe.withDefault defaultSize
    in
    svg
        [ fill "currentColor"
        , viewBox "0 0 512 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        , width iconSize
        , height iconSize
        ]
        [ path [ d "M256 0C114.6 0 0 114.6 0 256s114.6 256 256 256C397.4 512 512 397.4 512 256S397.4 0 256 0zM352 280H280V352c0 13.2-10.8 24-23.1 24C242.8 376 232 365.2 232 352V280H160C146.8 280 136 269.2 136 256c0-13.2 10.8-24 24-24H232V160c0-13.2 10.8-24 24-24C269.2 136 280 146.8 280 160v72h72C365.2 232 376 242.8 376 256C376 269.2 365.2 280 352 280z" ]
            []
        ]
