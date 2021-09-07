module Dev.ComponentDemoData exposing (..)

import Api.Card exposing (CardEnvelope, FlashCard(..), PromptFrequency(..))
import Time


catalogTableDemoData : List CardEnvelope
catalogTableDemoData =
    [ { id = 1
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 2
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 3
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 4
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 5
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 6
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 7
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    , { id = 8
      , card =
            Markdown
                { question = ""
                , renderedQuestion = ""
                , answer = ""
                , renderedAnswer = ""
                , tags = []
                }
      , userId = -999999
      , createdAt = Time.millisToPosix 1630971219000
      , lastModifiedOn = Time.millisToPosix 1630971219000
      , nextPromptSchedFor = Time.millisToPosix 1630971219000
      , frequency = Immediately
      }
    ]
