module Components.UserForm exposing (Field, view)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Components.ErrorList
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Route as Route exposing (Route)


type alias Field msg =
    { label : String
    , type_ : String
    , value : String
    , onInput : String -> msg
    }


view :
    { user : Data User
    , label : String
    , onFormSubmit : msg
    , alternateLink : { label : String, route : Route }
    , fields : List (Field msg)
    }
    -> Element msg
view options =
    div [ class "auth-page" ]
        [ div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-6 offset-md-3 col-xs-12" ]
                    [ h1 [ class "text-xs-center" ] [ text options.label ]
                    , p [ class "text-xs-center" ]
                        [ a [ href (Route.toHref options.alternateLink.route) ]
                            [ text options.alternateLink.label ]
                        ]
                    , case options.user of
                        Api.Data.Failure reasons ->
                            Components.ErrorList.view reasons

                        _ ->
                            text ""
                    , form [ Events.onSubmit options.onFormSubmit ] <|
                        List.concat
                            [ List.map viewField options.fields
                            , [ button [ class "btn btn-lg btn-primary pull-xs-right" ] [ text options.label ] ]
                            ]
                    ]
                ]
            ]
        ]


viewField : Field msg -> Element msg
viewField options =
    row []
        [ Input.text
        ]
        fieldset
        [ class "form-group" ]
        [ input
            [ class "form-control form-control-lg"
            , placeholder options.label
            , type_ options.type_
            , value options.value
            , Events.onInput options.onInput
            ]
            []
        ]
