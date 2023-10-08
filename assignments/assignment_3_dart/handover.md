# Överlämning från Arkitekt Perra.

Okej, det här blir intressant. På kort notis fick jag uppmaningen att lämna över till en ny stjärna så här kommer väl det viktigaste.

Projektet innehåller ``/example``, ``/lib/src`` och ``/test``. En fil ``.env`` kommer också behövas skapas i roten av projektet.

- Filen ``.env`` behöver följande innehåll och du behöver skapa den själv med innehåll från ditt snart skapade Firebase projekt.

```bash
export FIREBASE_API_KEY = "foo"
export FIREBASE_PROJECT_ID = "bar"
```

- ``/example`` innehåller kod som visar hur paketet ``firedart`` kan användas för att kommunicera med Firebase Firestore och Firebase Authentication

- `/test` innehåller exempel på hur paketet `bloc_test` används för att testa bloc.

- `/lib/src` innehåller en föreslagen struktur på projektet som i sin tur innehåller `/bloc`, `/models` och `/repositories`
  - `/bloc` innehåller de `blocs` som projektet behöver.
  - `/models` innehåller datamodeller
  - `/repositories` innehåller implementationer för kommunikation med Firebase.
