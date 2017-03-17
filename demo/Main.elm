import Html exposing (Html, div, text, button, ul, li, input, table, tr, td)
import Html.Attributes exposing (type_, class)
import Html.Events exposing (onClick, onInput)
import Char
import Char.CodePoint as CodePoint


type alias Model =
    { char : Char
    }


model : Model
model =
    { char = '𝔸'
    }


type Msg
    = SetChar Char


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetChar char ->
            ( { model | char = char }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ div [ class "form" ]
            [ inputView
            , buttonsView
            ]
        , outputView model.char
        ]


inputView : Html Msg
inputView =
    input
        [ type_ "text"
        , onInput (String.uncons
                >> Maybe.map Tuple.first
                >> Maybe.withDefault '𝔸'
                >> SetChar)
        ] []


buttonsView : Html Msg
buttonsView =
    List.map charButton badChars
        |> div []


charButton : Char -> Html Msg
charButton char =
    button
        [ onClick (SetChar char) ]
        [ text (String.fromChar char) ]


badChars : List Char
badChars =
    [ '𝔸','𝔹', '𝒜', '𝔅', '𝔄', '𝔲', '𝓉' ]


outputView : Char -> Html Msg
outputView char =
    table []
        [ tr []
            [ td [] [ text (String.fromChar char) ]
            , td [] [ text "Char" ]
            ]
        , tr []
            [ td [] [ text (Char.toCode char |> toString) ]
            , td [] [ text "Char.toCode" ]
            ]
        , tr []
            [ td []
                [ Char.toCode char
                    |> Char.fromCode
                    |> String.fromChar
                    |> text
                ]
            , td [] [ text "Char.fromCode" ]
            ]
        , tr []
            [ td []
                [ CodePoint.fromChar char
                    |> toString
                    |> text
                ]
            , td [] [ text "CodePoint.fromChar" ]
            ]
        , tr []
            [ td []
                [ CodePoint.fromChar char
                    |> CodePoint.toString
                    |> text
                ]
            , td [] [ text "CodePoint.toString" ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = ( model, Cmd.none )
        }
