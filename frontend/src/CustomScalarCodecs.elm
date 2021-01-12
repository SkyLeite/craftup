module CustomScalarCodecs exposing (Id(..), codecs)

import Api.Scalar
import Json.Decode
import Json.Encode


type Id
    = Id String


codecs : Api.Scalar.Codecs Id
codecs =
    Api.Scalar.defineCodecs
        { codecId =
            { encoder = \(Id raw) -> raw |> Json.Encode.string
            , decoder =
                Json.Decode.string
                    |> Json.Decode.map Id
            }
        }
