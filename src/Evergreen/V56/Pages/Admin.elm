module Evergreen.V56.Pages.Admin exposing (..)

import Evergreen.V56.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V56.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V56.Api.Admin.AdminSummary)
