module Evergreen.V37.Pages.Admin exposing (..)

import Evergreen.V37.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V37.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V37.Api.Admin.AdminSummary)
