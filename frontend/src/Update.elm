module Update exposing (update)

import Api
import Browser
import Browser.Navigation as Nav
import DataTypes.Item
import DataTypes.User
import Graphql.Http
import Model exposing (Model)
import Msg exposing (Msg(..))
import Pages.Login
import Pages.Register
import Route exposing (Route(..))
import Session exposing (SessionStatus(..))
import Url exposing (Url)
import Url.Parser


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl url ->
            let
                route =
                    Url.Parser.parse Route.parser url

                setRoute r m =
                    { m | route = r }
            in
            ( model
                |> closeDialogs
                |> clearSearchQuery
                |> setRoute route
            , route |> Maybe.withDefault Route.Home |> Route.routeToCmd
            )

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

        GotLoginResponse response ->
            case response of
                Ok user ->
                    ( { model | session = LoggedIn user }, Nav.pushUrl model.navKey "/" )

                Err _ ->
                    ( { model | session = Guest }, Cmd.none )

        GotMeResponse response ->
            case response of
                Ok user ->
                    ( { model | session = LoggedIn user }, Cmd.none )

                Err _ ->
                    ( { model | session = Guest }, Cmd.none )

        OpenLoginDialog ->
            ( { model | isLoginDialogOpen = True }, Cmd.none )

        CloseLoginDialog ->
            ( { model | isLoginDialogOpen = False }, Cmd.none )

        CloseAllDialogs ->
            ( closeDialogs model, Cmd.none )

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

        EnteredListFilter filter ->
            ( { model | listFilter = filter }, Cmd.none )

        EnteredNewListSearchQuery query ->
            ( { model | newListSearchQuery = Just query, newListSearchResultsOpen = not (query == "") }, Api.makeRequest (DataTypes.Item.itemSearchQuery query) GotItemsResponse )

        OpenNewListSearchResults ->
            ( { model | newListSearchResultsOpen = True }, Cmd.none )

        GotItemResponse response ->
            case response of
                Ok item ->
                    ( { model | foundItem = item }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


closeDialogs : Model -> Model
closeDialogs model =
    { model | isLoginDialogOpen = False, searchResultsOpen = False, newListSearchResultsOpen = False }


clearSearchQuery : Model -> Model
clearSearchQuery model =
    { model | searchQuery = Nothing }
