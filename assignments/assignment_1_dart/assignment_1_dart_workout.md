# Se bifogad mailkorrespondens som instruktion för vad du förväntas göra. 

**För godkänt på uppgiften skall kraven på det "dart package" som beskrivits i den överenskomna listan av funktionalitet mötas.**

Du uppmanas i första hand försöka modellera systemet. Detta innebär att du med hjälp av interfaces/abstrakta klasser definierar det beteende som du sedan skall implementera. Detta innefattar att skapa databärande klassbeskrivningar samt metoder som tillhör klasserna som när de utförs bidrar till att möta den efterfrågade funktionaliteten.

Den bästa resursen att börja bekanta dig med är: https://dart.dev/language

Jag ser framför mig att ni följer Petters uppmaning och testar skapa ett dart package, navigerar filerna ni får där och testar exekvera den kod som genererats. Sedan börjar ni sakta närma er en modellering genom att introducera en egen klass/abstrakt klass/interface klass. Lägg till några fält som kanske behövs i en databärande klass, någon funktion, navigera de olika sätten att skapa funktioner. Behöver ni någon lista, map, osv?

Möjligheter att få handledning i att angripa detta kommer på fredag 22/9. Här hoppas jag också att vi kan dela med oss med varandra av det vi lärt oss och hur långt vi kommit på vägen att modellera det här systemet. På måndag 24/9 kommer jag på lektionstid gå igenom ytterligare detaljer kopplat till modellering, att komma igång med paket i dart och hur man sedan implementerar den abstrakta modellen.

**För betyget VG på uppgifterna i kursen gäller följande beskrivning:**
Studenten ska utveckla programvara i programmeringsspråket Dart med högre kvalitet än för betyget G. Exempel på hög kvalité är väl strukturerad och kommenterad källkod, utnyttjande av vedertagna goda principer och designmönster för mjukvaruutveckling, eller utökad funktionalitet/komplexitet i lösningar.


**Förslag på hur VG kan mötas på uppgift 1: (endast exempel som inte alla måste mötas)**
- Användning av uttrycksfulla enums för att representera tillstånd/fel
- Felhantering som gör det tydligt för användaren vad som gått fel
- Återanvändning av kod där applicerbart genom t.ex. arv eller mixins
- Användning av factory constructors/named constructors
- Nyttjande av serializering/deserializering som t.ex. toJson/fromJson eller toString/fromString
- Nyttjande av generics där applicerbart
- Nyttjande av designönstret Singleton där applicerbart
- Nyttjande av kodgenerering för att underlätta t.ex. i skapandet av serializering. Förslagsvis med paketet https://pub.dev/packages/freezed
- Immutability för data-klasser.

**eller:**

Utökad funktionalitet/komplexitet genom att utöka funktionaliteten som Petter och Sara kommit överens om. Kanske t.ex. genom att programmera stöd för att planera pass i förväg så att användaren endast behöver klicka i när den gjort som redan planerats, eller att lätt kunna "repetera" ett redan utfört pass, eller något annat som du föreslår.

Inlämning sker genom att länka ett GitHub repo med din kod. Vill du kan du dela ditt repo med https://github.com/williamviktorsson , men se till att kommentera på uppgiften vid inlämning så att jag vet vems git-repo som är vems. Vill du inte det kan du också zippa ditt projekt och ladda upp koden här på plattformen.