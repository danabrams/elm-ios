module Main exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (..)
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


type alias Entry =
    { description : String
    , editing : Bool
    , completed : Bool
    , uid : Int
    }


type alias Model =
    { entries : List Entry
    , currentId : Int
    , counter : Int
    , debugCounter : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { entries = (List.map (emptyEntry "") [ 0, 1, 2, 3, 4, 5 ]), currentId = 6, counter = 0, debugCounter = 0 }, Cmd.none )


emptyEntry : String -> Int -> Entry
emptyEntry desc id =
    { description = desc
    , completed = False
    , editing = False
    , uid = id
    }



-- UPDATE


type Msg
    = UpdateEntry Int String
    | NewEntry String
    | ChangeCompleted Int
    | DeleteEntry Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateEntry id desc ->
            let
                updateEntry t =
                    if t.uid == id then
                        { t | description = desc, editing = False }
                    else
                        t
            in
                ( { model | entries = List.map updateEntry model.entries, counter = model.counter + 1, debugCounter = model.debugCounter + 1 }
                , Cmd.none
                )

        NewEntry desc ->
            ( { model
                | entries = model.entries ++ [ emptyEntry desc model.currentId ]
                , currentId = model.currentId + 1
                , debugCounter = model.debugCounter + 1
              }
            , Cmd.none
            )

        ChangeCompleted uid ->
            let
                changeMark t =
                    if t.uid == uid then
                        { t | completed = not t.completed }
                    else
                        t
            in
                ( { model | entries = List.map changeMark model.entries, debugCounter = model.debugCounter + 1 }
                , Cmd.none
                )

        DeleteEntry uid ->
            let
                isOurId t =
                    t.uid /= uid
            in
                ( { model | entries = List.filter isOurId model.entries }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    column
        [ flexGrow 1
        , justifyContent "flex-start"
        , alignItems "center"
        , backgroundColor <| Color.rgb 245 245 245
        , paddingTop 20
        ]
    <|
        [ row []
            [ label
                [ textColor <| Color.rgb 175 85 85
                , text "todos"
                , fontSize 48
                ]
            ]
        , todoListView model
        , row [ position "absolute", bottom 10, right 10 ]
            [ button
                [ imageSrc "plus.png"
                , onTouchUpInside <| NewEntry ""
                ]
            ]
        , label [ text <| "Number of button clicks: " ++ toString model.debugCounter ]
        ]



--++ [ row [] [ button [ text "add" ] ] ]
--++ [ button [ imageSrc "plus.png", alignItems "left" ] ]


todoListView : Model -> Element Msg
todoListView model =
    column [] <| List.map entryView <| List.sortBy .uid model.entries


entryView : Entry -> Element Msg
entryView entry =
    let
        ( checkboxImage, txtColor ) =
            case entry.completed of
                True ->
                    ( "checked.png", Color.gray )

                False ->
                    ( "unchecked.png", Color.black )
    in
        row []
            [ column [ width 50, height 50 ]
                [ button [ imageSrc checkboxImage, onTouchDown (ChangeCompleted entry.uid) ]
                ]
            , column [ width 320, height 50 ]
                [ textField
                    [ width 320
                    , height 50
                    , placeholder "What needs to be done?"
                    , text entry.description
                    , textColor txtColor
                    , roundedRectBorder
                    , onEditingDidEndOnExit (UpdateEntry entry.uid)
                    ]
                ]
            , column [ width 50, height 50 ]
                [ button [ textColor Color.red, fontSize 40, text "-", onTouchDown (DeleteEntry entry.uid) ]
                ]
            ]
