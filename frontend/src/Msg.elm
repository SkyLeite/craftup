module Msg exposing (Msg(..))

import Browser
import DataTypes.Item
import DataTypes.User
import Graphql.Http
import Url exposing (Url)


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | EnteredSearchQuery String
    | OpenSearchResults
    | CloseSearchResults
    | GotItemsResponse (Result (Graphql.Http.Error (List DataTypes.Item.Item)) (List DataTypes.Item.Item))
    | GotLoginResponse (Result (Graphql.Http.Error DataTypes.User.User) DataTypes.User.User)
    | GotMeResponse (Result (Graphql.Http.Error DataTypes.User.User) DataTypes.User.User)
    | OpenLoginDialog
    | CloseLoginDialog
    | CloseAllDialogs
    | EnteredLoginPassword String
    | EnteredLoginEmail String
    | SubmitLogin
    | EnteredRegisterPassword String
    | EnteredRegisterEmail String
    | SubmitRegister
    | EnteredListFilter String
    | EnteredNewListSearchQuery String
    | OpenNewListSearchResults
