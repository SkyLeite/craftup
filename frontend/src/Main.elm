module Main exposing (init, main, mainArea, view)

import Api
import Browser
import Browser.Navigation as Nav
import DataTypes.User
import Footer
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Navbar
import Pages.CraftingLists
import Pages.Home
import Pages.Login
import Pages.Register
import Route exposing (Route(..))
import Session exposing (SessionStatus(..))
import Update
import Url exposing (Url)


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( Model.init url navKey, Api.makeRequest DataTypes.User.meQuery GotMeResponse )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Manipulation.app"
    , body =
        [ div
            [ class "flex flex-col w-full h-screen max-w-7xl mx-auto"
            , onClick CloseAllDialogs
            ]
            [ Navbar.view model
            , mainArea model
            , Footer.view model
            ]
        ]
    }


mainArea : Model -> Html Msg
mainArea model =
    div [ class "flex-grow" ]
        [ case model.route of
            Just route ->
                case route of
                    Home ->
                        Pages.Home.view model

                    CraftingList _ ->
                        div [] []

                    CraftingLists ->
                        Pages.CraftingLists.view model

                    Login ->
                        Pages.Login.view model

                    Register ->
                        Pages.Register.view model

            Nothing ->
                div [] [ text "Not found" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = Update.update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }
