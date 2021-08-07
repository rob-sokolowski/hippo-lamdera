module Pages.Article.Slug_ exposing (Model, Msg(..), page)

import Api.Article exposing (Article)
import Api.Article.Comment exposing (Comment)
import Api.Data exposing (Data)
import Api.Profile exposing (Profile)
import Api.User exposing (User)
import Bridge exposing (..)
import Components.IconButton as IconButton
import Gen.Params.Article.Slug_ exposing (Params)
import Gen.Route as Route
import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, placeholder, src, value)
import Html.Events as Events
import Markdown
import Page
import Request
import Shared
import Utils.Maybe
import Utils.Route
import Utils.Time
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init shared req
        , update = update req
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    { article : Data Article
    , comments : Data (List Comment)
    , commentText : String
    }


init : Shared.Model -> Request.With Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { article = Api.Data.Loading
      , comments = Api.Data.Loading
      , commentText = ""
      }
    , Cmd.batch
        [ ArticleGet_Article__Slug_
            { slug = params.slug
            }
            |> sendToBackend
       
        ]
    )



-- UPDATE


type Msg
    = GotArticle (Data Article)
    | ClickedDeleteArticle User Article
    | DeletedArticle (Data Article)
    | GotAuthor (Data Profile)


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update req msg model =
    case msg of
        GotArticle article ->
            ( { model | article = article }
            , Cmd.none
            )

        ClickedDeleteArticle user article ->
            ( model
            , ArticleDelete_Article__Slug_
                { slug = article.slug
                }
                |> sendToBackend
            )

        DeletedArticle _ ->
            ( model
            , Utils.Route.navigate req.key Route.Home_
            )

        GotAuthor profile ->
            let
                updateAuthor : Article -> Article
                updateAuthor article =
                    case profile of
                        Api.Data.Success author ->
                            { article | author = author }

                        _ ->
                            article
            in
            ( { model | article = Api.Data.map updateAuthor model.article }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared model =
    case model.article of
        Api.Data.Success article ->
            { title = article.title
            , body = [ viewArticle shared model article ]
            }

        _ ->
            { title = "Article"
            , body = []
            }


viewArticle : Shared.Model -> Model -> Article -> Html Msg
viewArticle shared model article =
    div [ class "article-page" ]
        [ div [ class "banner" ]
            [ div [ class "container" ]
                [ h1 [] [ text article.title ]
                , viewArticleMeta shared model article
                ]
            ]
        , div [ class "container page" ]
            [ div [ class "row article-content" ]
                [ div [ class "col-md-12" ]
                    [ Markdown.toHtml [] article.body ]
                , if List.isEmpty article.tags then
                    text ""

                  else
                    ul [ class "tag-list" ]
                        (List.map
                            (\tag -> li [ class "tag-default tag-pill tag-outline" ] [ text tag ])
                            article.tags
                        )
                ]
            , hr [] []
            , div [ class "article-actions" ] [ viewArticleMeta shared model article ]
            ]
        ]


viewArticleMeta : Shared.Model -> Model -> Article -> Html Msg
viewArticleMeta shared model article =
    div [ class "article-meta" ] <|
        List.concat
            [ [ a [ href ("/profile/" ++ article.author.username) ]
                    [ img [ src article.author.image ] []
                    ]
              , div [ class "info" ]
                    [ a [ class "author", href ("/profile/" ++ article.author.username) ] [ text article.author.username ]
                    , span [ class "date" ] [ text (Utils.Time.formatDate article.createdAt) ]
                    ]
              ]
            , case shared.user of
                Just user ->
                    viewControls article user

                Nothing ->
                    []
            ]


viewControls : Article -> User -> List (Html Msg)
viewControls article user =
    if article.author.username == user.username then
        [ a
            [ class "btn btn-outline-secondary btn-sm"
            , href ("/editor/" ++ article.slug)
            ]
            [ i [ class "ion-edit" ] []
            , text "Edit article"
            ]
        , IconButton.view
            { color = IconButton.OutlinedRed
            , icon = IconButton.Trash
            , label = "Delete article"
            , onClick = ClickedDeleteArticle user article
            }
        ]

    else
        [ 

        ]

