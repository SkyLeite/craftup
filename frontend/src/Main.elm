module Main exposing (..)

import Api
import App exposing (Model, Msg(..))
import Browser
import Browser.Navigation as Nav
import DataTypes.Item
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Navbar
import Pages.CraftingLists
import Pages.Home
import Route exposing (Route(..))
import Search
import Url exposing (Url)
import Url.Parser


initModel : Url -> Nav.Key -> App.Model
initModel url navKey =
    { navKey = navKey
    , route = Url.Parser.parse Route.parser url
    , searchQuery = Nothing
    , foundItems = Nothing
    , searchModalOpen = False
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( initModel url navKey, Cmd.none )



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
            ( { model | searchQuery = Just query }, Api.makeRequest (DataTypes.Item.itemSearchQuery query) GotItemsResponse )

        OpenSearchModal ->
            ( { model | searchModalOpen = True }, Cmd.none )

        CloseSearchModal ->
            ( { model | searchModalOpen = False }, Cmd.none )

        GotItemsResponse response ->
            case response of
                Ok items ->
                    ( { model | foundItems = Just items }, Cmd.none )

                Err _ ->
                    ( { model | foundItems = Nothing }, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "XIVCraft"
    , body =
        [ div [ class "w-full max-w-7xl mx-auto" ]
            [ -- Sidebar.view model
              -- ,
              Navbar.view model
            , mainArea model
            ]
        , Search.view model
        ]
    }


mainArea : Model -> Html Msg
mainArea model =
    div [ class "" ]
        [ case model.route of
            Just route ->
                case route of
                    Home ->
                        Pages.Home.view model

                    CraftingList _ ->
                        div [] []

                    CraftingLists ->
                        Pages.CraftingLists.view model

            Nothing ->
                div [] []
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
