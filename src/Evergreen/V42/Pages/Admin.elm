module Evergreen.V42.Pages.Admin exposing (..)

import Evergreen.V42.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V42.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V42.Api.Admin.AdminSummary)
