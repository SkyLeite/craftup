module Api exposing (makeRequest)

import App
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)


graphqlUrl : String
graphqlUrl =
    "http://localhost:4000/"


makeRequest :
    SelectionSet decodesTo RootQuery
    -> (Result (Graphql.Http.Error decodesTo) decodesTo -> App.Msg)
    -> Cmd App.Msg
makeRequest query msg =
    query
        |> Graphql.Http.queryRequest graphqlUrl
        |> Graphql.Http.withCredentials
        |> Graphql.Http.send msg
