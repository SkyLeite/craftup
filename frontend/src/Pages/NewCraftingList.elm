module Pages.NewCraftingList exposing (view)

import Html exposing (Html, button, div, form, input, text)
import Html.Attributes exposing (class, placeholder)
import Model exposing (Model)
import Msg exposing (Msg)
import Session exposing (SessionStatus(..))


view : Model -> Html Msg
view model =
    case model.session of
        LoggedIn _ ->
            div [ class "pt-8 px-7" ] [ listForm model ]

        Guest ->
            div [] []


inputClasses =
    "border rounded p-2 focus:ring-2 transition ease-in duration-75 w-full"


listForm : Model -> Html Msg
listForm model =
    form [ class "space-y-4" ]
        [ input
            [ class inputClasses
            , placeholder "Title"
            ]
            []
        , itemListInput model
        ]


itemListInput : Model -> Html Msg
itemListInput model =
    div []
        [ div [ class "flex" ]
            [ input
                [ class inputClasses
                , placeholder "Item ID"
                ]
                []
            , button [ class "" ] [ text "+" ]
            ]
        ]
