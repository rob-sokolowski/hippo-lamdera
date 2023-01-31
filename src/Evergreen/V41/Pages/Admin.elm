module Evergreen.V41.Pages.Admin exposing (..)

import Evergreen.V41.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V41.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V41.Api.Admin.AdminSummary)
