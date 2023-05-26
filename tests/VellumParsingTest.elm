module VellumParsingTest exposing (..)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)


add : Int -> Int -> Int
add x y =
    x + y


suite : Test
suite =
    describe "Vellum"
        [ describe "Parsing response into individual flash cards"
            [ test "case 1"
                (\_ -> add 3 3 |> Expect.equal 6)
            ]
        ]
