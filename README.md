# hippo

Yet another space-repitition flash card app, implemented in [Elm](https://elm-lang.org/) / [Lamdera](https://dashboard.lamdera.app/docs)


Link to demo https://hippo.lamdera.app

^ Note: The signup flow is fake, so the `email` field is just a string, there's no email confirmation flow, so just make something up if you prefer.



### Markdown editor page:

After signing in, click on `cards` in the nav to view the editor page.

Here, you can create both sides of a card using Markdown. The previews are rendered on every keystroke! Once the card is to your liking, click `Submit` in the left panel. This will save the card, and queue it up for your next study session:


![img](./assets/screenshot1.png)


### Study session:
All cards have a `nextPromptScheduledAt` field. This is

![img](./assets/screenshot2.png)




![img](./assets/screenshot3.png)