module App exposing (Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import Route exposing (Route(..))
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s, string)


type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    }


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
