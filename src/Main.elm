module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, h1, input, p, text)
import Html.Attributes exposing (placeholder, style, value)
import Html.Events exposing (onClick, onInput)



---- MODEL ----


type alias Model =
    { successInput : String
    , improveInput : String
    , actionInput : String
    , successItems : List String
    , improveItems : List String
    , actionItems : List String
    }


init : ( Model, Cmd Msg )
init =
    ( { successInput = "deu certo"
      , improveInput = "nao rolou"
      , actionInput = "to-do"
      , successItems = []
      , improveItems = []
      , actionItems = []
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | SuccessInputChanged String
    | ImproveInputChanged String
    | ActionInputChanged String
    | SuccessInputSubmit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SuccessInputChanged value ->
            ( { model | successInput = value }, Cmd.none )

        ImproveInputChanged value ->
            ( { model | improveInput = value }, Cmd.none )

        ActionInputChanged value ->
            ( { model | actionInput = value }, Cmd.none )

        SuccessInputSubmit ->
            ( { model | successInput = "", successItems = model.successInput :: model.successItems }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Funny Retro - MagEdition" ]
        , div [ style "display" "flex", style "justify-content" "space-around" ]
            [ div [ style "background-color" "green", style "flex" "1" ]
                [ input
                    [ placeholder "O que deu certo?"
                    , value model.successInput
                    , onInput SuccessInputChanged
                    ]
                    []
                , button [ onClick SuccessInputSubmit ] [ text "+" ]
                , div [] (List.map (\item -> p [] [ text item ]) model.successItems)
                ]
            , div [ style "background-color" "blue", style "flex" "1" ]
                [ input
                    [ placeholder "O que podemos melhorar?"
                    , value model.improveInput
                    , onInput ImproveInputChanged
                    ]
                    []
                ]
            , div [ style "background-color" "purple", style "flex" "1" ]
                [ input
                    [ placeholder "Action items"
                    , value model.actionInput
                    , onInput ActionInputChanged
                    ]
                    []
                ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
