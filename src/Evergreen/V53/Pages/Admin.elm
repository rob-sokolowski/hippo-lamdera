module Evergreen.V53.Pages.Admin exposing (..)

import Evergreen.V53.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V53.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V53.Api.Admin.AdminSummary)
