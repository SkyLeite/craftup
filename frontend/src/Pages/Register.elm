module Pages.Register exposing (registerMutation, view)

import Api
import Api.InputObject
import Api.Mutation
import App exposing (Msg(..))
import DataTypes.User
import Graphql.Http exposing (Error)
import Html exposing (Html, a, button, div, form, h1, input, span, text)
import Html.Attributes exposing (class, placeholder, required, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Route


view : App.Model -> Html App.Msg
view model =
    let
        inputClasses =
            "border rounded p-2 focus:ring-2 transition ease-in duration-75 w-full"
    in
    div [ class "flex flex-col items-center justify-center m-4" ]
        [ div [ class "max-w-xs sm:max-w-lg w-full space-y-4" ]
            [ h1 [ class "font-semibold text-2xl" ] [ text "Register" ]
            , span [ class "text-sm" ]
                [ text """
                       Please fill out the form below to create your account.
                       With a Manipulation.app account, your lists and rotations can be accessed from any device.
                       """
                ]
            , form
                [ class "flex flex-col space-y-4"
                , onSubmit SubmitRegister
                ]
                [ input
                    [ class inputClasses
                    , placeholder "E-mail"
                    , type_ "email"
                    , required True
                    , onInput EnteredRegisterEmail
                    , value model.registerEmail
                    ]
                    []
                , input
                    [ class inputClasses
                    , placeholder "Password"
                    , type_ "password"
                    , required True
                    , onInput EnteredRegisterPassword
                    , value model.registerPassword
                    ]
                    []
                , button
                    [ class "rounded text-center font-semibold bg-green-500 text-white p-2 shadow-md"
                    , type_ "submit"
                    ]
                    [ text "Create my account" ]
                , span
                    [ class "text-gray-500 self-center" ]
                    [ text "Already have an account? "
                    , a [ class "font-bold text-green-600", Route.href Route.Login ] [ text "Log in" ]
                    ]
                ]
            ]
        ]


registerMutation : Api.InputObject.RegisterInput -> (Result (Error DataTypes.User.User) DataTypes.User.User -> Msg) -> Cmd Msg
registerMutation input =
    Api.makeMutation
        (Api.Mutation.register { input = input } DataTypes.User.userSelectionSet)
