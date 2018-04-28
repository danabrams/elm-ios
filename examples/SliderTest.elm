module Main exposing (..)

import Element
    exposing
        ( Element
        , column
        , label
        , slider
        , program
        , button
        )
import Element.Attributes
    exposing
        ( flexGrow
        , justifyContent
        , alignItems
        , text
        , minValue
        , maxValue
        , sliderValue
        , minTrackColor
        , maxTrackColor
        , thumbColor
        , width
        )
import Element.Events exposing (onFloatValueChanged)
import Color


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    Float


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Slid Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Slid value ->
            ( value, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    column
        [ flexGrow 1
        , justifyContent "center"
        , alignItems "center"
        ]
        [ label [ text <| toString model ]
        , slider
            [ minValue 0
            , maxValue 20
            , width 300
            , sliderValue model
            , minTrackColor Color.red
            , maxTrackColor Color.green
            , thumbColor Color.lightPurple
            , onFloatValueChanged Slid
            ]
        ]
