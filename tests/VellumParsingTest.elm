module VellumParsingTest exposing (..)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)
import VellumClient exposing (runParser)


suite : Test
suite =
    describe "Vellum"
        [ describe "Parsing response into individual flash cards"
            [ test "case 1"
                (\_ ->
                    runParser case1_inline
                        |> Expect.equal
                            (Ok
                                [ { question = "What is the meaning of life?"
                                  , answer = "42"
                                  }
                                , { question = "Who was president of the United States in 2022?"
                                  , answer = "Dark Brandon"
                                  }
                                ]
                            )
                )

            -- TODO: Clean up white spaces
            , test "case 2"
                (\_ -> runParser case2_newlines |> Expect.ok)

            -- TODO: Clean up white spaces
            , test "case 3"
                (\_ -> runParser case3_funkySpacing |> Expect.ok)

            -- TODO: How do I measure partial success here?
            , test "case 4"
                (\_ -> runParser case4_truncatedResponse |> Expect.err)
            ]
        ]


case1_inline : String
case1_inline =
    """
<question>What is the meaning of life?</question><answer>42</answer>
<question>Who was president of the United States in 2022?</question><answer>Dark Brandon</answer>
"""


case2_newlines : String
case2_newlines =
    """
<question>
What is the meaning of life?
</question>
<answer>
42
</answer>
<question>
Who was president of the United States in 2022?</question>
<answer>
Dark Brandon
</answer>
"""


case3_funkySpacing : String
case3_funkySpacing =
    """
<question>
                What is the meaning of life?
    </question>
    <answer>
        42
</answer>
<question>
Who was president of the United States in 2022?</question>
            <answer>
        Dark Brandon
    </answer>
"""


case4_truncatedResponse : String
case4_truncatedResponse =
    -- When testing manually, I sometimes noticed truncated output, we should handling this gracefully with
    -- friendly error messaging
    """
<question>
                What is the meaning of life?
    </question>
    <answer>
        42
</answer>
<question>
Who was president of the United States in 2022?</question>
            <answer>
        Dark 
"""
