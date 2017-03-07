module Main exposing (..)

import Html exposing (program)
import Svg exposing (Svg, svg, circle, text_, text)
import Svg.Attributes exposing (..)
import Window exposing (..)

-- MODEL
type alias Model = { window: Window }
type alias Window = { size: Window.Size }
init : (Model, Cmd msg)
init = ({ window = { size = { width = 1000, height = 1000 } } }, Cmd.none)

-- VIEW
view : Model -> Svg msg
view model =
    let w = model.window.size.width
        h = model.window.size.height
        ws = toString w
        hs = toString h
        cxs = (toFloat w) / 2 |> toString
        cys = (toFloat h) / 2 |> toString
    in
    svg [ Svg.Attributes.width ws, Svg.Attributes.height hs ]
        [ circle [ cx cxs, cy cys, r "40", stroke "lightgrey", fillOpacity "10%", strokeWidth "3" ] [] ]

-- UPDATE
type Msg
    = Resize Size
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Resize size -> let win = model.window in ({ model | window = { win | size = size }}, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch -- Here I use just single subscription, but Sub.batch can potentially take be many subscriptions
        [ Window.resizes Resize
        ]

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }