module Navbar exposing (searchInput, view)

import DataTypes.Item
import DataTypes.User exposing (User)
import Html exposing (Html, a, button, div, img, input, span, text)
import Html.Attributes exposing (class, classList, src, value)
import Html.Events exposing (onInput)
import List
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route exposing (href)
import Search exposing (SearchResultType(..))
import Session exposing (SessionStatus(..))
import Svg.Attributes
import Utils exposing (onClick)
import Zondicons


view : Model -> Html Msg
view model =
    div [ class "sticky flex items-center p-4 border-b-2 space-x-2" ]
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
                , class "h-10 rounded"
                ]
                []
            , span [ class "hidden text-xl sm:block" ] [ text "Manipulation.app" ]
            ]
        ]


searchInput : Model -> Html Msg
searchInput model =
    div
        [ class
            "relative flex items-center justify-start flex-auto h-10 font-medium text-gray-600 "
        ]
        [ Zondicons.search [ Svg.Attributes.class "absolute w-4 ml-2 text-gray-400" ]
        , input
            [ class "w-full h-full pl-8 border rounded"
            , model.searchQuery |> Maybe.withDefault "" |> value
            , onInput EnteredSearchQuery
            , onClick
                (if model.searchQuery /= Just "" then
                    OpenSearchResults

                 else
                    NoOp
                )
            ]
            []
        , span [ class "absolute right-3 border rounded py-0.5 px-2 text-sm text-gray-400" ] [ text "CTRL+K" ]
        , searchResults model
        ]


userArea : User -> Html Msg
userArea user =
    let
        imgUrl =
            "https://img2.finalfantasyxiv.com/f/c1006670e130fe1ec501ae70fff2fcdc_96ab1df8877c1f8ba6a89a39cccfd437fc0_96x96.jpg?1610153005"
    in
    div [ class "flex items-center space-x-4" ]
        [ img
            [ src imgUrl
            , class "h-10 rounded"
            ]
            []
        , span [ class "hidden sm:block" ] [ text user.email ]
        ]


guestUserArea : Html Msg
guestUserArea =
    a
        [ class "w-16 py-2 font-semibold text-center text-white bg-green-500 rounded shadow-md"
        , Route.href Route.Login
        ]
        [ text "Login" ]


searchResults : Model -> Html Msg
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
        [ class "absolute z-50 w-full h-64 p-2 overflow-y-scroll bg-white border rounded-b mt-72 transition-all space-y-1"
        , classList [ ( "invisible", not isShown ), ( opacityClass, True ) ]
        , onClick NoOp
        ]
        (model.foundItems
            |> Maybe.withDefault []
            |> List.map itemToSearchResult
            |> (++) model.searchResults
            |> List.map searchResult
        )


searchResult : Search.SearchResult Msg -> Html Msg
searchResult data =
    let
        prefixHtml =
            case data.resultType of
                Command prefix ->
                    span [ class "px-0.5 rounded text-blue-500" ] [ text prefix ]

                Search ->
                    span [] []
    in
    a
        [ class "flex items-center h-12 px-2 py-1 bg-green-100 rounded cursor-pointer sm:h-8 hover:bg-green-200"
        , href (Route.Item data.title)
        ]
        [ prefixHtml
        , span [ class "mx-2" ] [ text data.title ]
        ]


itemToSearchResult : DataTypes.Item.Item -> Search.SearchResult Msg
itemToSearchResult item =
    { title = item.name, description = "Some item", action = NoOp, resultType = Search }
