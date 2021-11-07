module Pages.Item exposing (view)

import DataTypes.Item exposing (Item)
import DataTypes.Recipe exposing (Recipe)
import Html exposing (Html, a, article, div, h1, h2, header, img, li, section, span, text, ul)
import Html.Attributes exposing (class, src)
import Model exposing (Model)
import Msg exposing (Msg)
import Route exposing (href)


iconUrl : String -> String
iconUrl id =
    let
        folder =
            id |> String.left 2 |> (\x -> "0" ++ x ++ "000")

        file =
            "0" ++ id
    in
    "https://xivapi.com/i/" ++ folder ++ "/" ++ file ++ ".png"


view : Item -> Html Msg
view item =
    article [ class "flex flex-col w-full h-full" ]
        [ header [ class "flex items-center mb-8" ]
            [ img [ item.icon |> iconUrl |> src, class "mr-4" ] []
            , span [ class "flex flex-col" ]
                [ h1 [ class "text-xl" ] [ text item.name ]
                , h2 [] [ text item.description ]
                ]
            ]
        , div [ class "space-y-8" ]
            [ item.recipe |> Maybe.map recipeView |> Maybe.withDefault (div [] [])
            ]
        ]


recipeView : Recipe -> Html Msg
recipeView recipe =
    div [ class "max-w-lg p-4 border rounded shadow-md" ]
        [ h2 [ class "mb-4 text-lg" ] [ text "Crafting Recipe" ]
        , ul [ class "space-y-2" ]
            (recipe.ingredients
                |> List.map
                    (\x ->
                        li []
                            [ a [ class "flex items-center p-2 rounded bg-gray-50 hover:bg-green-50", href (Route.Item x.item.name) ]
                                [ img [ x.item.icon |> iconUrl |> src, class "mr-2" ] []
                                , span []
                                    [ span [ class "mr-2" ]
                                        [ x.quantity |> String.fromInt |> (\quantity -> quantity ++ "x") |> text
                                        ]
                                    , span [] [ text x.item.name ]
                                    ]
                                ]
                            ]
                    )
            )
        ]
