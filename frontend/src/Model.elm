module Model exposing (Model, init)

import Browser
import Browser.Navigation as Nav
import DataTypes.CraftingList exposing (WipList)
import DataTypes.Item
import DataTypes.User
import Graphql.Http
import Msg exposing (Msg(..))
import Route exposing (Route(..))
import Search
import Session exposing (SessionStatus(..))
import Url exposing (Url)
import Url.Parser


type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , searchQuery : Maybe String
    , newListSearchQuery : Maybe String
    , foundItems : Maybe (List DataTypes.Item.Item)
    , foundItem : Maybe DataTypes.Item.Item
    , searchResultsOpen : Bool
    , newListSearchResultsOpen : Bool
    , searchResults : List (Search.SearchResult Msg)
    , session : SessionStatus
    , isLoginDialogOpen : Bool
    , loginEmail : String
    , loginPassword : String
    , registerEmail : String
    , registerPassword : String
    , listFilter : String
    , wipList : Maybe WipList
    , wipListOpen : Bool
    }


init : Url -> Nav.Key -> Model
init url navKey =
    { navKey = navKey
    , route = Url.Parser.parse Route.parser url
    , searchQuery = Nothing
    , newListSearchQuery = Nothing
    , foundItems = Nothing
    , foundItem = Nothing
    , searchResultsOpen = False
    , newListSearchResultsOpen = False
    , searchResults = []
    , session = Guest
    , isLoginDialogOpen = False
    , loginEmail = ""
    , loginPassword = ""
    , registerEmail = ""
    , registerPassword = ""
    , listFilter = ""
    , wipList = Nothing
    , wipListOpen = False
    }
