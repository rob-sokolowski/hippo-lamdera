module Evergreen.V45.Pages.Admin exposing (..)

import Evergreen.V45.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V45.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V45.Api.Admin.AdminSummary)
