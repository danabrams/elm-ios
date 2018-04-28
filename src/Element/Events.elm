module Element.Events
    exposing
        ( on
        , onBoolValueChanged
        , onFloatValueChanged
        , onTouchUpInside
        , onTouchUpOutside
        , onTouchDown
        , onTouchDownRepeat
        , onTouchCancel
        , onTouchDragInside
        , onTouchDragOutside
        , onTouchDragEnter
        , onTouchDragExit
        , onAllTouchEvents
        , onEditingDidBegin
        , onEditingChanged
        , onEditingDidEnd
        , onEditingDidEndOnExit
        )

{-| #Events
@docs on, onBoolValueChanged, onFloatValueChanged, onTouchUpInside, onTouchUpOutside, onTouchDown, onTouchDownRepeat, onTouchCancel, onTouchDragInside, onTouchDragOutside, onTouchDragEnter, onTouchDragExit, onAllTouchEvents, on, onEditingDidBegin, onEditingChanged, onEditingDidEnd, onEditingDidEndOnExit
-}

import Element exposing (Attribute)
import Element.Internal as Internal
import Json.Decode as Json


{-| -}
on : String -> Json.Decoder msg -> Attribute msg
on =
    Internal.on



-- TODO valueChanged


{-| -}
onBoolValueChanged : (Bool -> msg) -> Attribute msg
onBoolValueChanged tagger =
    on "valueChanged" (Json.map tagger Json.bool)


{-| -}
onFloatValueChanged : (Float -> msg) -> Attribute msg
onFloatValueChanged tagger =
    on "valueChanged" (Json.map tagger Json.float)


{-| -}
onTouchUpInside : msg -> Attribute msg
onTouchUpInside msg =
    on "touchUpInside" (Json.succeed msg)


{-| -}
onTouchUpOutside : msg -> Attribute msg
onTouchUpOutside msg =
    on "touchUpOutside" (Json.succeed msg)


{-| -}
onTouchDown : msg -> Attribute msg
onTouchDown msg =
    on "touchDown" (Json.succeed msg)


{-| -}
onTouchDownRepeat : msg -> Attribute msg
onTouchDownRepeat msg =
    on "touchDownRepeat" (Json.succeed msg)


{-| -}
onTouchCancel : msg -> Attribute msg
onTouchCancel msg =
    on "touchCancel" (Json.succeed msg)


{-| -}
onTouchDragInside : msg -> Attribute msg
onTouchDragInside msg =
    on "touchDragInside" (Json.succeed msg)


{-| -}
onTouchDragOutside : msg -> Attribute msg
onTouchDragOutside msg =
    on "touchDragOutside" (Json.succeed msg)


{-| -}
onTouchDragEnter : msg -> Attribute msg
onTouchDragEnter msg =
    on "touchDragEnter" (Json.succeed msg)


{-| -}
onTouchDragExit : msg -> Attribute msg
onTouchDragExit msg =
    on "touchDragExit" (Json.succeed msg)


{-| -}
onAllTouchEvents : msg -> Attribute msg
onAllTouchEvents msg =
    on "allTouchEvents" (Json.succeed msg)


{-| -}
onEditingDidEnd : (String -> msg) -> Attribute msg
onEditingDidEnd tagger =
    on "editingDidEnd" (Json.map tagger Json.string)


{-| -}
onEditingDidEndOnExit : (String -> msg) -> Attribute msg
onEditingDidEndOnExit tagger =
    on "editingDidEndOnExit" (Json.map tagger Json.string)


{-| -}
onEditingDidBegin : (String -> msg) -> Attribute msg
onEditingDidBegin tagger =
    on "editingDidBegin" (Json.map tagger Json.string)


{-| -}
onEditingChanged : (String -> msg) -> Attribute msg
onEditingChanged tagger =
    on "editingChanged" (Json.map tagger Json.string)


{-| -}
allEditingEvents : (String -> msg) -> Attribute msg
allEditingEvents tagger =
    on "allEditingEvents" (Json.map tagger Json.string)
