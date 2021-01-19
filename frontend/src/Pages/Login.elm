module Pages.Login exposing (loginMutation, view)

import Api
import Api.InputObject
import Api.Mutation
import DataTypes.User
import Graphql.Http exposing (Error)
import Html exposing (Html, a, button, div, form, h1, h2, input, span, text)
import Html.Attributes exposing (class, placeholder, required, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route


view : Model -> Html Msg
view model =
    let
        inputClasses =
            "border rounded p-2 focus:ring-2 transition ease-in duration-75 w-full"
    in
    div [ class "flex flex-col items-center justify-center m-4" ]
        [ div [ class "max-w-xs sm:max-w-lg w-full space-y-4" ]
            [ h1 [ class "font-semibold text-2xl" ] [ text "Login" ]
            , span [ class "text-sm" ] [ text "Welcome back! Please log in to get access to all of your lists, rotations, and more." ]
            , form
                [ class "flex flex-col space-y-4 w-full"
                , onSubmit SubmitLogin
                ]
                [ input
                    [ class inputClasses
                    , placeholder "E-mail"
                    , onInput EnteredLoginEmail
                    , value model.loginEmail
                    , type_ "email"
                    , required True
                    ]
                    []
                , input
                    [ class inputClasses
                    , placeholder "Password"
                    , onInput EnteredLoginPassword
                    , value model.loginPassword
                    , type_ "password"
                    , required True
                    ]
                    []
                , button
                    [ class "rounded text-center font-semibold bg-green-500 text-white p-2 shadow-md"
                    , type_ "submit"
                    ]
                    [ text "Log in" ]
                , span
                    [ class "text-gray-500 self-center" ]
                    [ text "Don't have an account? "
                    , a [ class "font-bold text-green-600", Route.href Route.Register ] [ text "Sign up" ]
                    ]
                , a [ class "self-center font-bold text-green-600" ] [ text "Forgot password?" ]
                ]
            ]
        ]


loginMutation : Api.InputObject.LoginInput -> (Result (Error DataTypes.User.User) DataTypes.User.User -> msg) -> Cmd msg
loginMutation input =
    Api.makeMutation
        (Api.Mutation.login { input = input } DataTypes.User.userSelectionSet)
