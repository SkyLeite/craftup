module Api exposing (makeRequest)

import Api.Query
import App exposing (Msg)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)


graphqlUrl : String
graphqlUrl =
    "https://localhost:4000/"


makeRequest : SelectionSet decodesTo RootQuery -> App.Msg -> Cmd App.Msg
makeRequest query msg =
    query
        |> Graphql.Http.queryRequest graphqlUrl
        |> Graphql.Http.send msg
