module Auth exposing (User, beforeProtectedInit)

import Api.User
import ElmSpa.Page as ElmSpa
import Gen.Route exposing (Route)
import Request exposing (Request)
import Shared


type alias User =
    Api.User.User


beforeProtectedInit : Shared.Model -> Request -> ElmSpa.Protected User Route
beforeProtectedInit shared req =
    let
        _ =
            Debug.log "beforeProtectedInit" shared
    in
    case shared.user of
        Just user ->
            ElmSpa.Provide user

        Nothing ->
            ElmSpa.RedirectTo Gen.Route.Login
