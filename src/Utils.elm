module Utils exposing (..)

import Element exposing (Attribute, Element, behindContent, el, html, htmlAttribute)
import Simple.Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Task


animatedEl : Animation -> List (Attribute msg) -> Element msg -> Element msg
animatedEl =
    let
        animatedUi =
            Animated.ui
                { behindContent = behindContent
                , htmlAttribute = htmlAttribute
                , html = html
                }
    in
    animatedUi el


do : msg -> Cmd msg
do m =
    Task.succeed m
        |> Task.perform identity
