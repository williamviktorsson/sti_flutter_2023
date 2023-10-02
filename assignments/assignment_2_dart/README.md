# Överlämning från Kenneth. 

### Läs [mailkorrespondens](pixelart_mail.md) för introduktion från CTO.

Projektet är uppdelat i tre dart projekt. `pixelart_shared`, `pixelart_client` och `pixelart_server`.

Tillsammans ska de möjliggöra att flera personer samtidigt kopplar upp sig mot en server för att redigera så kallad "Pixel art". När en tom "Pixel art" har skapats kan flera användare gå in och börja redigera pixlar och se förändringar i realtid.

## pixelart_shared

Ett projekt som är färdigt, testat och med exempelkod. De två andra projekten har detta projekt som en dependency.

- Innehåller datamodellerna.
- Datat är immutable tack vare [https://pub.dev/packages/freezed](https://pub.dev/packages/freezed).
  - Datat har to-/fromJson, copyWith(för att underlätta att klona objekt) och serializering till/från String.
- Kör `dart test` för att köra testerna.
- Kör `dart run example/pixelart_shared_example.dart` för att köra ett exempel.

## pixelart_server

Ett projekt som är halvfärdigt. Det är en klassisk http server som är skapad med hjälp av [https://dartfrog.vgv.dev/](https://dartfrog.vgv.dev/).

- Dart Frog Påminner om next.js/express.js/remix. Alla request handlers är definierade redan på rätt sätt i rätt fil. Filerna under `/routes` håller alla request handlers och hierarkin under `/routes` utgör en filsystemsbaserad router. Alla request handlers svarar och tar emot data serializerad till string.

- De routes och requests som finns är:
  - HTTP GET `/`
  - HTTP GET,POST `/pixelart` (list/create)
  - HTTP GET,PUT,DELETE `/pixelart/[id]` (read/update/delete)
  - WebSocket `/pixelart/[id]/stream` (changes)

För att köra servern behöver du följa länken och kolla på quick start. Sedan är det bara `dart pub get` och `dart_frog dev` i mappen `pixelart_server`.

- Innehåller halvfärdiga tester med TODOS annoterade som kommentarer.
- Innehåller halvfärdiga request handlers med TODOS annoterade.
- Innehåller en halvfärdig hive pixelart-repository implementation med TODOS annoterade.
- Kör `dart test` för att köra testerna.

## pixelart_client

Ett projekt som är halvfärdigt. Det innehåller en implementation av ett pixelart-repository som kommunicerar över HTTP med pixelart_servern.

- Innehåller halvfärdiga tester med TODOS annoterade som kommentarer.
- Innehåller halvfärdiga request handlers med TODOS annoterade.
- Innehåller en halvfärdig http pixelart-repository implementation med TODOS annoterade.
- Kör `dart test` för att köra testerna. Notera att testerna kör direkt mot servern såp de förväntar sig att du kör servern lokalt i `pixelart_server` med `dart_frog dev`
- När testerna fungerar kan du också köra `dart run example/pixelart_client_example.dart` för att utföra en del operationer som kommunicerar med servern.
