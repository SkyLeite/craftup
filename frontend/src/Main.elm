module Main exposing (init, initModel, main, mainArea, update, view)

import Api
import App exposing (Model, Msg(..))
import Browser
import Browser.Navigation as Nav
import DataTypes.Item
import DataTypes.User
import Footer
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Navbar
import Pages.CraftingLists
import Pages.Home
import Pages.Login
import Pages.Register
import Route exposing (Route(..))
import Session exposing (SessionStatus(..))
import Url exposing (Url)
import Url.Parser


initModel : Url -> Nav.Key -> App.Model
initModel url navKey =
    { navKey = navKey
    , route = Url.Parser.parse Route.parser url
    , searchQuery = Nothing
    , foundItems = Nothing
    , searchResultsOpen = False
    , searchResults = Navbar.commands
    , session = Guest
    , isLoginDialogOpen = False
    , loginEmail = ""
    , loginPassword = ""
    , registerEmail = ""
    , registerPassword = ""
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( initModel url navKey, Api.makeRequest DataTypes.User.meQuery GotMeResponse )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl url ->
            ( { model | route = Url.Parser.parse Route.parser url }, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey <| Url.toString url )

                Browser.External url ->
                    ( model, Nav.load url )

        EnteredSearchQuery query ->
            ( { model | searchQuery = Just query, searchResultsOpen = not (query == "") }, Api.makeRequest (DataTypes.Item.itemSearchQuery query) GotItemsResponse )

        OpenSearchResults ->
            ( { model | searchResultsOpen = True }, Cmd.none )

        CloseSearchResults ->
            ( { model | searchResultsOpen = False }, Cmd.none )

        GotItemsResponse response ->
            case response of
                Ok items ->
                    ( { model | foundItems = Just items }, Cmd.none )

                Err _ ->
                    ( { model | foundItems = Nothing }, Cmd.none )

        GotMeResponse response ->
            case response of
                Ok user ->
                    ( { model | session = LoggedIn user, route = Just Home }, Nav.pushUrl model.navKey "/" )

                Err _ ->
                    ( { model | session = Guest }, Cmd.none )

        OpenLoginDialog ->
            ( { model | isLoginDialogOpen = True }, Cmd.none )

        CloseLoginDialog ->
            ( { model | isLoginDialogOpen = False }, Cmd.none )

        CloseAllDialogs ->
            ( { model | isLoginDialogOpen = False, searchResultsOpen = False }, Cmd.none )

        EnteredLoginPassword password ->
            ( { model | loginPassword = password }, Cmd.none )

        EnteredLoginEmail email ->
            ( { model | loginEmail = email }, Cmd.none )

        SubmitLogin ->
            ( model, Pages.Login.loginMutation { email = model.loginEmail, password = model.loginPassword } GotMeResponse )

        EnteredRegisterPassword password ->
            ( { model | registerPassword = password }, Cmd.none )

        EnteredRegisterEmail email ->
            ( { model | registerEmail = email }, Cmd.none )

        SubmitRegister ->
            ( model, Pages.Register.registerMutation { email = model.registerEmail, password = model.registerPassword } GotMeResponse )



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
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }
