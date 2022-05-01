module Msg exposing (Msg(..))

import Browser
import DataTypes.CraftingList exposing (CraftingList, WipList)
import DataTypes.Item exposing (Item)
import DataTypes.ListItem exposing (WipListItem)
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
    | GotItemResponse (Result (Graphql.Http.Error (Maybe DataTypes.Item.Item)) (Maybe DataTypes.Item.Item))
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
    | AddItemToWipList Item
    | RemoveItemFromWipList String
    | IncreaseWipItemQuantity String
    | DecreaseWipItemQuantity String
    | CloseWipList
    | OpenWipList
    | ToggleWipList
    | ChangeWipListName String
    | SaveWipList WipList
    | GotSaveWipListResponse (Result (Graphql.Http.Error DataTypes.CraftingList.CraftingList) DataTypes.CraftingList.CraftingList)
    | DeleteCraftingList CraftingList
    | GotDeleteCraftingListResponse (Result (Graphql.Http.Error DataTypes.CraftingList.CraftingList) DataTypes.CraftingList.CraftingList)
