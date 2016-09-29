import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (id, href, class, style)


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
  }


model : Model
model =
  { statusText = "Ready"
 }


type Msg
  = NoOp



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )


view : Model -> Html Msg
view model =
  div [][ text model.statusText
        , div [id "chartdiv"][text "test"]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none