module Icons exposing (Icon, addToList, listCheck, loading, minus, plus)

import Html exposing (Html)
import Html.Attributes exposing (attribute, height, width)
import Svg exposing (g, path, svg)
import Svg.Attributes exposing (class, d, fill, id, viewBox)


type alias Icon msg =
    Html msg


defaultSize : Int
defaultSize =
    15


iconSize : Maybe Int -> Int
iconSize =
    Maybe.withDefault defaultSize


loading : Maybe Int -> Icon msg
loading size =
    svg
        [ class "animate-spin"
        , fill "currentColor"
        , viewBox "0 0 512 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        , width (iconSize size)
        , height (iconSize size)
        ]
        [ path [ d "M96 256c0-26.5-21.5-48-48-48S0 229.5 0 256s21.5 48 48 48S96 282.5 96 256zM108.9 60.89c-26.5 0-48.01 21.49-48.01 47.99S82.39 156.9 108.9 156.9s47.99-21.51 47.99-48.01S135.4 60.89 108.9 60.89zM108.9 355.1c-26.5 0-48.01 21.51-48.01 48.01S82.39 451.1 108.9 451.1s47.99-21.49 47.99-47.99S135.4 355.1 108.9 355.1zM256 416c-26.5 0-48 21.5-48 48S229.5 512 256 512s48-21.5 48-48S282.5 416 256 416zM464 208C437.5 208 416 229.5 416 256s21.5 48 48 48S512 282.5 512 256S490.5 208 464 208zM403.1 355.1c-26.5 0-47.99 21.51-47.99 48.01S376.6 451.1 403.1 451.1s48.01-21.49 48.01-47.99S429.6 355.1 403.1 355.1zM256 0C229.5 0 208 21.5 208 48S229.5 96 256 96s48-21.5 48-48S282.5 0 256 0z" ]
            []
        ]


addToList : Maybe Int -> Icon msg
addToList size =
    svg
        [ viewBox "0 0 21 21"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        , width (Maybe.withDefault 21 size)
        , height (Maybe.withDefault 21 size)
        ]
        [ g [ fill "none", attribute "fill-rule" "evenodd", attribute "stroke" "currentColor", attribute "stroke-linecap" "round", attribute "stroke-linejoin" "round", attribute "transform" "translate(4 6)" ]
            [ path [ d "m.5.5h12" ]
                []
            , path [ d "m.5 4.5h12" ]
                []
            , path [ d "m.5 8.5h7" ]
                []
            , path [ d "m9.5 8.5h4zm2 2v-4z" ]
                []
            ]
        ]


listCheck : Maybe Int -> Icon msg
listCheck size =
    svg
        [ fill "currentColor"
        , viewBox "0 0 512 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        , width (iconSize size)
        , height (iconSize size)
        ]
        [ path [ d "M118.2 199.9L63.09 261.1l-22.12-22.11c-9.375-9.375-24.56-9.375-33.94 0s-9.375 24.56 0 33.94l40 40C51.53 317.5 57.66 320 63.1 320c.2187 0 .4065 0 .6253-.0156c6.594-.1719 12.81-3.031 17.22-7.922l72-80c8.875-9.859 8.062-25.03-1.781-33.91C142.2 189.3 127.1 190.1 118.2 199.9zM118.2 39.94L63.09 101.1l-22.12-22.11c-9.375-9.375-24.56-9.375-33.94 0s-9.375 24.56 0 33.94l40 40C51.53 157.5 57.66 160 63.1 160c.2187 0 .4065 0 .6253-.0156c6.594-.1719 12.81-3.031 17.22-7.922l72-80c8.875-9.859 8.062-25.03-1.781-33.91C142.2 29.31 127.1 30.09 118.2 39.94zM48 367.1c-26.51 0-48 21.49-48 48c0 26.51 21.49 48 48 48s48-21.49 48-48C96 389.5 74.51 367.1 48 367.1zM256 128h224c17.67 0 32-14.33 32-32s-14.33-32-32-32h-224C238.3 64 224 78.33 224 96S238.3 128 256 128zM480 224h-224C238.3 224 224 238.3 224 256s14.33 32 32 32h224c17.67 0 32-14.33 32-32S497.7 224 480 224zM480 384H192c-17.67 0-32 14.33-32 32s14.33 32 32 32h288c17.67 0 32-14.33 32-32S497.7 384 480 384z" ]
            []
        ]


plus : Maybe Int -> Icon msg
plus size =
    svg
        [ width (iconSize size)
        , height (iconSize size)
        , attribute "aria-hidden" "true"
        , class "svg-inline--fa fa-plus"
        , attribute "data-icon" "plus"
        , attribute "data-prefix" "fas"
        , attribute "focusable" "false"
        , attribute "role" "img"
        , viewBox "0 0 448 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        ]
        [ path [ d "M432 256c0 17.69-14.33 32.01-32 32.01H256v144c0 17.69-14.33 31.99-32 31.99s-32-14.3-32-31.99v-144H48c-17.67 0-32-14.32-32-32.01s14.33-31.99 32-31.99H192v-144c0-17.69 14.33-32.01 32-32.01s32 14.32 32 32.01v144h144C417.7 224 432 238.3 432 256z", fill "currentColor" ]
            []
        ]


minus : Maybe Int -> Icon msg
minus size =
    svg
        [ width (iconSize size)
        , height (iconSize size)
        , attribute "aria-hidden" "true"
        , class "svg-inline--fa fa-minus"
        , attribute "data-icon" "minus"
        , attribute "data-prefix" "fas"
        , attribute "focusable" "false"
        , attribute "role" "img"
        , viewBox "0 0 448 512"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        ]
        [ path [ d "M400 288h-352c-17.69 0-32-14.32-32-32.01s14.31-31.99 32-31.99h352c17.69 0 32 14.3 32 31.99S417.7 288 400 288z", fill "currentColor" ]
            []
        ]
