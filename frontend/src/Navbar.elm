module Navbar exposing (commands, view)

import App exposing (Model, Msg(..))
import DataTypes.Item
import DataTypes.User exposing (User)
import Html exposing (Html, a, button, div, img, input, span, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onInput)
import List
import Route
import Search exposing (SearchResultType(..))
import Session exposing (SessionStatus(..))
import Svg.Attributes
import Utils exposing (onClick)
import Zondicons


view : App.Model -> Html App.Msg
view model =
    div [ class "sticky flex items-center border-b-2 space-x-2 p-4" ]
        [ logo
        , searchInput model
        , case model.session of
            LoggedIn user ->
                userArea user

            Guest ->
                guestUserArea
        ]


logo : Html msg
logo =
    div [ class "" ]
        [ a
            [ Route.href Route.Home
            , class "flex items-center space-x-4"
            ]
            [ img
                [ src "http://garlandtools.org/files/icons/action/1668.png"
                , class "rounded h-10"
                ]
                []
            , span [ class "text-xl hidden sm:block" ] [ text "Manipulation.app" ]
            ]
        ]


searchInput : App.Model -> Html App.Msg
searchInput model =
    div
        [ class
            "relative flex-auto flex h-10 items-center justify-start text-gray-600 font-medium "
        ]
        [ Zondicons.search [ Svg.Attributes.class "text-gray-400 w-4 absolute ml-2" ]
        , input
            [ class "border w-full h-full pl-8 rounded"
            , onInput EnteredSearchQuery
            , onClick
                (if model.searchQuery /= Just "" then
                    OpenSearchResults

                 else
                    NoOp
                )
            ]
            []
        , span [ class "absolute right-3 border rounded py-0.5 px-2 text-sm text-gray-400"] [ text "CTRL+K" ]
        , searchResults model
        ]


userArea : User -> Html App.Msg
userArea user =
    let
        imgUrl =
            "https://img2.finalfantasyxiv.com/f/c1006670e130fe1ec501ae70fff2fcdc_96ab1df8877c1f8ba6a89a39cccfd437fc0_96x96.jpg?1610153005"
    in
    div [ class "flex items-center space-x-4" ]
        [ img
            [ src imgUrl
            , class "rounded h-10"
            ]
            []
        , span [ class "hidden sm:block" ] [ text user.email ]
        ]


guestUserArea : Html App.Msg
guestUserArea =
    a
        [ class "rounded text-center w-16 font-semibold bg-green-500 text-white py-2 shadow-md"
        , Route.href Route.Login
        ]
        [ text "Login" ]


searchResults : App.Model -> Html App.Msg
searchResults model =
    let
        isShown =
            case ( model.searchQuery, model.searchResultsOpen ) of
                ( Nothing, _ ) ->
                    False

                ( Just _, True ) ->
                    True

                _ ->
                    False

        opacityClass =
            if isShown then
                "opacity-100"

            else
                "opacity-0"
    in
    div
        [ class "absolute mt-72 h-64 w-full z-50 bg-white rounded-b border transition-all p-2 space-y-1 overflow-y-scroll"
        , classList [ ( "invisible", not isShown ), ( opacityClass, True ) ]
        , onClick NoOp
        ]
        (model.foundItems
            |> Maybe.withDefault []
            |> List.map itemToSearchResult
            |> (++) model.searchResults
            |> List.map searchResult
        )


searchResult : Search.SearchResult Msg -> Html App.Msg
searchResult data =
    let
        prefixHtml =
            case data.resultType of
                Command prefix ->
                    span [ class "px-0.5 rounded text-blue-500" ] [ text prefix ]

                Search ->
                    span [] []
    in
    div [ class "flex items-center h-12 sm:h-8 bg-green-100 hover:bg-green-200 cursor-pointer rounded py-1 px-2" ]
        [ prefixHtml
        , span [ class "mx-2" ] [ text data.title ]
        ]


commands : List (Search.SearchResult Msg)
commands =
    [ { title = "Create list", description = "Creates an empty list", action = NoOp, resultType = Command "cl" }
    , { title = "Go to list", description = "Opens a list", action = NoOp, resultType = Command "gl" }
    , { title = "Login", description = "Login to your account", action = NoOp, resultType = Command "log" }
    ]


itemToSearchResult : DataTypes.Item.Item -> Search.SearchResult App.Msg
itemToSearchResult item =
    { title = item.name, description = "Some item", action = NoOp, resultType = Search }
