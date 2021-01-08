module App exposing (Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import Route exposing (Route(..))
import Url exposing (Url)
import Graphql.Http
import DataTypes.Item


type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , itemQuery : Maybe String
    , foundItems : Maybe (List DataTypes.Item.Item)
    }


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | EnteredItemQuery String
    | GotItemsResponse (Result (Graphql.Http.Error (List DataTypes.Item.Item)) (List DataTypes.Item.Item))
