module Api exposing (makeMutation, makeRequest)

import App
import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
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


makeMutation :
    SelectionSet decodesTo RootMutation
    -> (Result (Graphql.Http.Error decodesTo) decodesTo -> App.Msg)
    -> Cmd App.Msg
makeMutation mutation msg =
    mutation
        |> Graphql.Http.mutationRequest graphqlUrl
        |> Graphql.Http.withCredentials
        |> Graphql.Http.send msg
