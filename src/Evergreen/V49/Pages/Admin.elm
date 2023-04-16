module Evergreen.V49.Pages.Admin exposing (..)

import Evergreen.V49.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V49.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V49.Api.Admin.AdminSummary)
