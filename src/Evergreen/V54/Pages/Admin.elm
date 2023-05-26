module Evergreen.V54.Pages.Admin exposing (..)

import Evergreen.V54.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V54.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V54.Api.Admin.AdminSummary)
