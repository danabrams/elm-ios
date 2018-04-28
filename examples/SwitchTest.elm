module Main exposing (..)

import Element
    exposing
        ( Element
        , column
        , label
        , switch
        , program
        , button
        )
import Element.Attributes
    exposing
        ( flexGrow
        , justifyContent
        , alignItems
        , text
        , switchedOn
        , switchedOnColor
        , switchedOffColor
        , thumbColor
        )
import Element.Events exposing (onBoolValueChanged, onTouchUpInside)
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
    Bool


init : ( Model, Cmd Msg )
init =
    ( True, Cmd.none )



-- UPDATE


type Msg
    = Switched Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Switched ison ->
            ( ison, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    column
        [ flexGrow 1
        , justifyContent "center"
        , alignItems "center"
        ]
        [ label [ text <| toString model ]
        , switch
            [ switchedOn model
            , switchedOnColor Color.darkOrange
            , switchedOffColor Color.darkGreen
            , thumbColor Color.lightBlue
            , onBoolValueChanged <| Switched
            ]
        ]
