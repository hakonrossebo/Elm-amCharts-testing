module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, href, class, style)
import Html.Events exposing (onClick)
import Models exposing (..)
import CustomPorts exposing (..)
import FakeData exposing (..)
import Random exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


model : Model
model =
    { statusText = "Showing extra info:"
    , showExtraInfo = False
    , items = chartItems
    , showingChart = False
    , seed = initialSeed 31254
    }


type Msg
    = NoOp
    | ToggleExtraInfo
    | UpdateChartData
    | ShowChart


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleExtraInfo ->
            ( { model | showExtraInfo = not model.showExtraInfo }, Cmd.none )

        UpdateChartData ->
            let
                updatedItems =
                    updateItemsWithRandom model
            in
                ( { model | seed = (Tuple.second updatedItems), items = (Tuple.first updatedItems) }, setUpdatedData (Tuple.first updatedItems) )

        ShowChart ->
            ( { model | showingChart = True }, showChart model.items )


intList : Int -> Generator (List Int)
intList count =
    list count (int 0 2000)


updateItemsWithRandom : Model -> ( List ChartItemDetail, Seed )
updateItemsWithRandom model =
    let
        count =
            List.length model.items

        randomData =
            step (intList count) model.seed

        items =
            model.items
                |> List.map2 (,) (Tuple.first randomData)
                |> List.map (\( number, item ) -> { item | visits = number })
    in
        ( items, Tuple.second randomData )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick ToggleExtraInfo ] [ text "Show/hide extra info" ]
        , if not model.showingChart then
            button [ onClick ShowChart ] [ text "Show chart" ]
          else
            text ""
        , if model.showingChart then
            button [ onClick UpdateChartData ] [ text "Update chart with random data" ]
          else
            text ""
        , div []
            [ text <| model.statusText
                ++ if model.showExtraInfo then
                    " True"
                   else
                    " False"
            ]
        , viewExtraInfo model
        , div [ id "chartdiv" ] []
        ]


viewExtraInfo : Model -> Html Msg
viewExtraInfo model =
    case model.showExtraInfo of
        True ->
            div []
                (List.map viewItem model.items)

        False ->
            text ""


viewItem : ChartItemDetail -> Html Msg
viewItem item =
    div [] [ text <| "Country: " ++ item.country ++ ", " ++ (toString item.visits) ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
