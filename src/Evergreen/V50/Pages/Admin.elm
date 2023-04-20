module Evergreen.V50.Pages.Admin exposing (..)

import Evergreen.V50.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V50.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V50.Api.Admin.AdminSummary)
