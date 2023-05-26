module Evergreen.V55.Pages.Admin exposing (..)

import Evergreen.V55.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V55.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V55.Api.Admin.AdminSummary)
