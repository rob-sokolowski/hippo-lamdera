module Evergreen.V51.Pages.Admin exposing (..)

import Evergreen.V51.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V51.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V51.Api.Admin.AdminSummary)
