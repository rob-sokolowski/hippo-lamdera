module Evergreen.V60.Pages.Stories.ElmAudio exposing (..)

import Audio
import Time


type Msg
    = ReplaceMe


type SoundState
    = NotPlaying
    | Playing Time.Posix
    | FadingOut Time.Posix Time.Posix


type alias AudioData =
    { sound : Audio.Source
    , soundState : SoundState
    }


type LoadState
    = NotAsked
    | Loading
    | LoadedSuccess AudioData
    | LoadFailed


type alias Model =
    { loadState : LoadState
    }
