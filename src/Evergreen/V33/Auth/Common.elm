module Evergreen.V33.Auth.Common exposing (..)

import Evergreen.V33.OAuth
import Evergreen.V33.OAuth.AuthorizationCode
import Time
import Url


type alias MethodId =
    String


type alias AuthCode =
    String


type alias UserInfo =
    { name : String
    , email : String
    , username : Maybe String
    }


type Error
    = ErrStateMismatch
    | ErrAuthorization Evergreen.V33.OAuth.AuthorizationCode.AuthorizationError
    | ErrAuthentication Evergreen.V33.OAuth.AuthorizationCode.AuthenticationError
    | ErrHTTPGetAccessToken
    | ErrHTTPGetUserInfo
    | ErrAuthString String


type Flow
    = Idle
    | Requested MethodId
    | Pending
    | Authorized AuthCode String
    | Authenticated Evergreen.V33.OAuth.Token
    | Done UserInfo
    | Errored Error


type alias SessionId =
    String


type alias PendingAuth =
    { created : Time.Posix
    , sessionId : SessionId
    , state : String
    }


type alias State =
    String


type ToBackend
    = AuthSigninInitiated
        { methodId : MethodId
        , baseUrl : Url.Url
        , username : Maybe String
        }
    | AuthCallbackReceived MethodId Url.Url AuthCode State
    | AuthRenewSessionRequested
    | AuthLogoutRequested


type alias ClientId =
    String


type AuthChallengeReason
    = AuthSessionMissing
    | AuthSessionInvalid
    | AuthSessionExpired
    | AuthSessionLoggedOut


type ToFrontend
    = AuthInitiateSignin Url.Url
    | AuthError Error
    | AuthSessionChallenge AuthChallengeReason


type alias Token =
    { methodId : MethodId
    , token : Evergreen.V33.OAuth.Token
    , created : Time.Posix
    , expires : Time.Posix
    }


type BackendMsg
    = AuthSigninInitiated_
        { sessionId : SessionId
        , clientId : ClientId
        , methodId : MethodId
        , baseUrl : Url.Url
        , now : Time.Posix
        , username : Maybe String
        }
    | AuthSigninInitiatedDelayed_ SessionId ToFrontend
    | AuthCallbackReceived_ SessionId ClientId MethodId Url.Url String String Time.Posix
    | AuthSuccess SessionId ClientId MethodId Time.Posix (Result Error ( UserInfo, Maybe Token ))
    | AuthRenewSession SessionId ClientId
