module Models exposing (..)

import Random exposing (..)

type alias Model =
  { statusText : String
  , showExtraInfo : Bool
  , items: List ChartItemDetail
  , seed: Seed
  }


type alias ChartItemDetail =
  { country : String
  , visits: Int
  }