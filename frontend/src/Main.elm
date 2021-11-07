module Main exposing (init, main, mainArea, view)

import Api
import Browser
import Browser.Navigation as Nav
import DataTypes.User
import Footer
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Icons
import Model exposing (Model)
import Msg exposing (Msg(..))
import Navbar
import Pages.CraftingLists
import Pages.Home
import Pages.Item
import Pages.Login
import Pages.NewCraftingList
import Pages.Register
import Route exposing (Route(..))
import Session exposing (SessionStatus(..))
import Update
import Url exposing (Url)


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        meRequest =
            Api.makeRequest DataTypes.User.meQuery GotMeResponse
    in
    ( Model.init url navKey
    , url
        |> Route.fromUrl
        |> Maybe.map Route.routeToCmd
        |> Maybe.map (\x -> Cmd.batch [ x, meRequest ])
        |> Maybe.withDefault meRequest
    )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Manipulation.app"
    , body =
        [ div
            [ class "flex flex-col w-full h-screen mx-auto max-w-7xl"
            , onClick CloseAllDialogs
            ]
            [ Navbar.view model
            , mainArea model
            , Footer.view model
            ]
        ]
    }


loadingView : Html Msg
loadingView =
    div [ class "flex items-center justify-between text-xl w-28" ]
        [ Icons.loading (Just 15)
        , span [] [ text "Loading" ]
        ]


mainArea : Model -> Html Msg
mainArea model =
    div [ class "flex items-center justify-center flex-grow w-full h-full p-8" ]
        [ case model.route of
            Just route ->
                case route of
                    Home ->
                        Pages.Home.view model

                    CraftingList _ ->
                        div [] []

                    CraftingLists ->
                        Pages.CraftingLists.view model

                    NewCraftingList ->
                        Pages.NewCraftingList.view model

                    Login ->
                        Pages.Login.view model

                    Register ->
                        Pages.Register.view model

                    Item id ->
                        case model.foundItem of
                            Nothing ->
                                loadingView

                            Just item ->
                                Pages.Item.view item

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
