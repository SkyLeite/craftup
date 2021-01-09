module Search exposing (Prefix, SearchResult, SearchResultType(..))

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, classList)
import Json.Decode exposing (Decoder)
import Utils exposing (onClick)


type alias SearchResult msg =
    { title : String
    , description : String
    , action : msg
    , resultType : SearchResultType
    }


type SearchResultType
    = Command Prefix
    | Search


type alias Prefix =
    String
