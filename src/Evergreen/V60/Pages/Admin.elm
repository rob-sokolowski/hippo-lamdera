module Evergreen.V60.Pages.Admin exposing (..)

import Evergreen.V60.Api.Admin


type Msg
    = GotAdminSummary (List Evergreen.V60.Api.Admin.AdminSummary)


type alias Model =
    { adminSummary : Maybe (List Evergreen.V60.Api.Admin.AdminSummary)
    }
