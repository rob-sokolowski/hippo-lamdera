module Evergreen.V52.Pages.Admin exposing (..)

import Evergreen.V52.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V52.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V52.Api.Admin.AdminSummary)
