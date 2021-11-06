module Pages.NewCraftingList exposing (view)

import DataTypes.Item
import Html exposing (Html, button, div, form, input, span, text)
import Html.Attributes exposing (class, classList, placeholder)
import Html.Events exposing (onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Search exposing (SearchResultType(..))
import Session exposing (SessionStatus(..))
import Svg.Attributes
import Utils exposing (onClick)
import Zondicons


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
        , searchInput model
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


searchInput : Model -> Html Msg
searchInput model =
    div
        [ class
            "relative flex items-center justify-start flex-auto h-10 font-medium text-gray-600 "
        ]
        [ Zondicons.search [ Svg.Attributes.class "absolute w-4 ml-2 text-gray-400" ]
        , input
            [ class "w-full h-full pl-8 border rounded"
            , onInput EnteredNewListSearchQuery
            , onClick
                (if model.searchQuery /= Just "" then
                    OpenNewListSearchResults

                 else
                    NoOp
                )
            ]
            []
        , searchResults model
        ]


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
    div [ class "flex items-center h-12 px-2 py-1 bg-green-100 rounded cursor-pointer sm:h-8 hover:bg-green-200" ]
        [ prefixHtml
        , span [ class "mx-2" ] [ text data.title ]
        ]


searchResults : Model -> Html Msg
searchResults model =
    let
        isShown =
            case ( model.newListSearchQuery, model.newListSearchResultsOpen ) of
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


itemToSearchResult : DataTypes.Item.Item -> Search.SearchResult Msg
itemToSearchResult item =
    { title = item.name, description = "Some item", action = NoOp, resultType = Search }
