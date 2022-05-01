module Ui.Tooltip exposing (withTooltip)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)


withTooltip : String -> Html msg -> Html msg
withTooltip tooltipText element =
    div [ class "tooltip" ]
        [ element
        , span
            [ class "tooltiptext"
            ]
            [ text tooltipText ]
        ]
