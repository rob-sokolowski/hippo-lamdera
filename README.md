### hippo

Yet another spaced-repetition flash card app. Check out the [live demo](https://hippo.lamdera.app/). Once signed in, you may create flash cards in Markdown, or plain text. Come back daily to study your flashcards. Consecutive correct answers decreases study frequency for a card!


#### Screenshots

Using markdown to create a question and answer:

![img](./assets/screenshot1.png)

Study session prompt, with answer hidden:

![img](./assets/screenshot2.png)


Study session prompt, with answer shown:

![img](./assets/screenshot3.png)


### dev notes

Port 8000 is usually busy doing something else on my machine, so I've moved all lamdera things to port `8080`

This changes local dev:
```bash
lamdera live --port 8080
```

And for OAuth, local callbacks must be configured to use `http://localhost:8080/login/OAuthGoogle/callback`

Secrets are stored in Project Fir's GCP [secrets manager](https://console.cloud.google.com/security/secret-manager?project=fir-sandbox-326008)
