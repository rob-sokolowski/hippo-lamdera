module Evergreen.V43.Pages.Admin exposing (..)

import Evergreen.V43.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V43.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V43.Api.Admin.AdminSummary)
