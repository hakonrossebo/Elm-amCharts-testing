import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (id, href, class, style)
import Html.Events exposing (onClick)


main : Program Never
main =
  App.program
    { init = (model, Cmd.none)
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



type alias Model =
  { statusText : String
  , showExtraInfo : Bool
  }


model : Model
model =
  { statusText = "Showing extra info:"
  , showExtraInfo = False
  }


type Msg
  = NoOp
  | DoSomething



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    DoSomething ->
      ({ model | showExtraInfo = not model.showExtraInfo}, Cmd.none )



statusHelper : Bool -> String
statusHelper status =
  case status of
    True ->
      " True"
    False ->
      " False"

view : Model -> Html Msg
view model =
  div [][ button [ onClick DoSomething ] [ text "Show/hide extra info" ]
        , div [][text <| model.statusText ++ statusHelper model.showExtraInfo]
        , viewExtraInfo model
        , div [id "chartdiv"][text "test"]
        ]


viewExtraInfo : Model -> Html Msg
viewExtraInfo model =
  case model.showExtraInfo of
    True ->
      div [][ div [][ text "Test line 1"]
            , div [][ text "Test line 2"]
            , div [][ text "Test line 3"]
            , div [][ text "Test line 4"]
            ]
    False ->
      text ""

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none