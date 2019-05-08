module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, form, h1, input, p, text)
import Html.Attributes exposing (class, placeholder, style, value)
import Html.Events exposing (onClick, onInput, onSubmit)



---- MODEL ----


type alias Item =
    { text : String
    , votes : Int
    }


type alias Model =
    { successInput : String
    , improveInput : String
    , actionInput : String
    , successItems : List Item
    , improveItems : List Item
    , actionItems : List Item
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
    | ImproveInputSubmit
    | ActionInputSubmit


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
            let
                item =
                    { text = model.successInput, votes = 0 }
            in
            ( { model | successInput = "", successItems = item :: model.successItems }, Cmd.none )

        ImproveInputSubmit ->
            let
                item =
                    Item model.improveInput 0
            in
            ( { model | improveInput = "", improveItems = item :: model.improveItems }, Cmd.none )

        ActionInputSubmit ->
            let
                item =
                    { text = model.actionInput, votes = 0 }
            in
            ( { model | actionInput = "", actionItems = item :: model.actionItems }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Funny Retro - MagEdition" ]
        , div [ style "display" "flex", style "justify-content" "space-around" ]
            [ div [ class "column column--success" ]
                [ form [ onSubmit SuccessInputSubmit ]
                    [ input
                        [ placeholder "O que deu certo?"
                        , value model.successInput
                        , onInput SuccessInputChanged
                        ]
                        []
                    , button [] [ text "+" ]
                    ]
                , div [] (List.map (\item -> p [] [ text item.text ]) model.successItems)
                ]
            , div [ class "column column--improve" ]
                [ form [ onSubmit ImproveInputSubmit ]
                    [ input
                        [ placeholder "O que podemos melhorar?"
                        , value model.improveInput
                        , onInput ImproveInputChanged
                        ]
                        []
                    , button [] [ text "+" ]
                    ]
                , div [] (List.map (\item -> p [] [ text item.text ]) model.improveItems)
                ]
            , div [ class "column column--action" ]
                [ form [ onSubmit ActionInputSubmit ]
                    [ input
                        [ placeholder "Action items"
                        , value model.actionInput
                        , onInput ActionInputChanged
                        ]
                        []
                    , button [] [ text "+" ]
                    ]
                , div [] (List.map (\item -> p [] [ text item.text ]) model.actionItems)
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
