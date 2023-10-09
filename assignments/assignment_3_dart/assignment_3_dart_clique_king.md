# Se bifogad [mailkorrespondens](clique_king_mail.md) som instruktion för vad du förväntas göra.

---

Koden ska stödja:

- Registrering och inloggning av användare m.h.a. Firebase Authentication
- Lagring av användarinformation (user) i Firebase Firestore
- Möjlighet att som inloggad användare, se cliques, skapa nya, och gå med i cliques.
    - "Cliques" är som grupper som användare kan "vara med i".
    - Lagras också i Firebase Firestore
- Möjlighet att välja en Clique och då se information om alla medlemmar i en clique.
- Alla medlemmar i en clique ska få ett värde tilldelat sig som börjar på 0.
- När man utför "actions" i en clique, går värdet upp.
- Den med högst värde är "Clique King", top of the leaderboard so to speak..
- En Action kan vara vadsomhelst, det är upp till er.
    - Ett enkelt förslag är att börja med en knapp. Sen kan man i framtiden byta till t.ex. stegräknare eller liknande.
- Alla "actions" som ska kunna påverka logiken ska uttryckas som Events i bloc.
- Allt data som ska kunna hämtas för att visas i en vy ska kunna uttryckas som States i bloc.

**För godkänt på uppgiften skall uppgiften vara övervägande färdig och inte överdrivet många begränsningar**

Du kommer få öva på:

- event-driven-architecture
- bloc
- bloc testing
- firebase
- firebase firestore (realtime database)
- firebase authentication (stödjer flera login providers)
- environment variables
- nyttjande av baas-lösning (backend-as-a-service)
- repetition av innehåll från tidigare uppgifter.

**För betyget VG på uppgiften skall uppgiften kunna betraktas som färdig med få begränsningar**
