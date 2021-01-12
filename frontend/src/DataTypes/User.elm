module DataTypes.User exposing (User, meQuery, userSelectionSet)

import Api.Object
import Api.Object.User
import Api.Query
import CustomScalarCodecs exposing (Id)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)


type alias User =
    { id : Id
    , email : String
    }


meQuery : SelectionSet User RootQuery
meQuery =
    Api.Query.me userSelectionSet


userSelectionSet : SelectionSet User Api.Object.User
userSelectionSet =
    Graphql.SelectionSet.map2 User
        Api.Object.User.id
        Api.Object.User.email
