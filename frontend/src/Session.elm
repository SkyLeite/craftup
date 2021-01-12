module Session exposing (..)

import DataTypes.User exposing (User)


type SessionStatus
    = LoggedIn User
    | Guest
