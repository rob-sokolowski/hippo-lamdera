module Utils.Task exposing (..)

import Task


send : msg -> Cmd msg
send m =
    Task.succeed m
        |> Task.perform identity
