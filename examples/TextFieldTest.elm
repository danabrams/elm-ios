module Main exposing (..)

import Element
    exposing
        ( Element
        , column
        , label
        , textField
        , program
        , button
        )
import Element.Attributes
    exposing
        ( flexGrow
        , justifyContent
        , alignItems
        , text
        , roundedRectBorder
        , bezelBorder
        , textColor
        , placeholder
        , font
        , width
        , whileEditingClearButton
        )
import Element.Events exposing (onEditingDidEndOnExit, onEditingChanged)
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
    String


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



-- UPDATE


type Msg
    = TextUpdate String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TextUpdate value ->
            ( value, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    column
        [ flexGrow 1
        , justifyContent "center"
        , alignItems "center"
        ]
        [ label [ text model ]
        , textField
            [ text model
            , bezelBorder
            , textColor Color.red
            , placeholder "Start"
            , font "Courier"
            , width 300
            , whileEditingClearButton
            , onEditingChanged TextUpdate
            ]
        ]
