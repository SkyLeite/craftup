module Api exposing (makeMutation, makeRequest)

import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)


graphqlUrl : String
graphqlUrl =
    "https://localhost:4001/"


makeRequest :
    SelectionSet decodesTo RootQuery
    -> (Result (Graphql.Http.Error decodesTo) decodesTo -> msg)
    -> Cmd msg
makeRequest query msg =
    query
        |> Graphql.Http.queryRequest graphqlUrl
        |> Graphql.Http.withCredentials
        |> Graphql.Http.send msg


makeMutation :
    SelectionSet decodesTo RootMutation
    -> (Result (Graphql.Http.Error decodesTo) decodesTo -> msg)
    -> Cmd msg
makeMutation mutation msg =
    mutation
        |> Graphql.Http.mutationRequest graphqlUrl
        |> Graphql.Http.withCredentials
        |> Graphql.Http.send msg
