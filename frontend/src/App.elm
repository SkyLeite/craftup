module App exposing (Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import DataTypes.Item
import Graphql.Http
import Route exposing (Route(..))
import Url exposing (Url)


type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , searchQuery : Maybe String
    , foundItems : Maybe (List DataTypes.Item.Item)
    , searchModalOpen : Bool
    }


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | EnteredSearchQuery String
    | OpenSearchModal
    | CloseSearchModal
    | GotItemsResponse (Result (Graphql.Http.Error (List DataTypes.Item.Item)) (List DataTypes.Item.Item))
