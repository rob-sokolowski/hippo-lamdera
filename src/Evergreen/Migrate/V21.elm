module Evergreen.Migrate.V21 exposing (..)

import Dict
import Evergreen.V19.Api.Card as OldCard exposing (CardEnvelope, FlashCard(..))
import Evergreen.V19.Api.User
import Evergreen.V19.Types as Old
import Evergreen.V21.Api.Card as NewCard exposing (FlashCard(..))
import Evergreen.V21.Api.User
import Evergreen.V21.Types as New
import Lamdera.Migrations exposing (..)


frontendModel : Old.FrontendModel -> ModelMigration New.FrontendModel New.FrontendMsg
frontendModel old =
    ModelUnchanged


backendModel : Old.BackendModel -> ModelMigration New.BackendModel New.BackendMsg
backendModel old =
    let
        migrateSession : Old.Session -> New.Session
        migrateSession old_ =
            { userId = old_.userId
            , expires = old_.expires
            }

        migrateUser : Evergreen.V19.Api.User.UserFull -> Evergreen.V21.Api.User.UserFull
        migrateUser old_ =
            { id = old_.id
            , email = old_.email
            , username = old_.username
            , bio = old_.bio
            , image = old_.image
            , password = old_.password
            }

        migrateCard : OldCard.CardEnvelope -> NewCard.CardEnvelope
        migrateCard old_ =
            { id = old_.id
            , card =
                case old_.card of
                    OldCard.PlainText card ->
                        NewCard.PlainText card

                    OldCard.Markdown card ->
                        NewCard.Markdown card
            , userId = old_.userId
            , createdAt = old_.createdAt
            , lastModifiedOn = old_.lastModifiedOn
            , nextPromptSchedFor = old_.nextPromptSchedFor
            , frequency =
                case old_.frequency of
                    OldCard.Immediately ->
                        NewCard.Immediately

                    OldCard.OneDay ->
                        NewCard.OneDay

                    OldCard.TwoDays ->
                        NewCard.TwoDays

                    OldCard.SevenDays ->
                        NewCard.SevenDays

                    OldCard.FourteenDays ->
                        NewCard.FourteenDays

                    OldCard.ThirtyDays ->
                        NewCard.ThirtyDays
            }

        sessions =
            Dict.map (\k s -> migrateSession s) old.sessions

        users =
            Dict.map (\k u -> migrateUser u) old.users

        cards =
            Dict.map (\k c -> migrateCard c) old.cards

        now =
            old.now
    in
    ModelMigrated
        ( { sessions = sessions
          , users = users
          , cards = cards
          , now = now
          , nextCardId = 1000
          }
        , Cmd.none
        )


frontendMsg : Old.FrontendMsg -> MsgMigration New.FrontendMsg New.FrontendMsg
frontendMsg old =
    MsgOldValueIgnored


toBackend : Old.ToBackend -> MsgMigration New.ToBackend New.BackendMsg
toBackend old =
    MsgOldValueIgnored


backendMsg : Old.BackendMsg -> MsgMigration New.BackendMsg New.BackendMsg
backendMsg old =
    MsgOldValueIgnored


toFrontend : Old.ToFrontend -> MsgMigration New.ToFrontend New.FrontendMsg
toFrontend old =
    MsgOldValueIgnored
