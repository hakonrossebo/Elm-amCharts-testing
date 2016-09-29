port module CustomPorts exposing (..)

import Models exposing (..)

port showChart : List ChartItemDetail -> Cmd msg
port setUpdatedData : List ChartItemDetail -> Cmd msg


