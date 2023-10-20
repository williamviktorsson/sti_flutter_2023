# Uppgift 6, social platform "clique king"

Du har redan kodat logiken för din applikation i Dart.

Nu är uppgiften tydlig: du ska färdigställa applikationen med hjälp av Flutter.

När kursen fortlöper kommer exempel tillhandahållas för hur olika vy-komponenter och koncept används som du kan välja att använda eller låta bli att använda i din applikation.

Tanken med denna applikation är att den ska byggas med web, iOS och Android som build target.

### **Utöver nedan funktionalitet som redan är programmerad i Dart, ska applikationen:**

- Utnyttja flutter_bloc paketet för att underlätta arbetet med bloc.
- Utnyttja streams för att visa uppdateringar i realtid när en användare öppnat en specifik clique i applikationen.

### Nedan är den funktionalitet som applikationen skall stödja:

---

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

---

### **För betyget G(godkänt) på uppgiften ska du lämna in din kod och bifoga en kort video som visar att din applikation stödjer ovan funktionalitet.**

### **För betyget VG(väl godkänt) på uppgifterna i kursen gäller följande beskrivning:**
Studenten ska utveckla programvara i ramverket Flutter med högre kvalitet än för betyget G. Exempel på hög kvalité är väl strukturerad och kommenterad källkod, utnyttjande av vedertagna goda principer och designmönster för mjukvaruutveckling, eller utökad funktionalitet/komplexitet i lösningar. Den studerande ska uppvisa mer än godkänd behärskning av att använda de olika tjänster som finns tillgängliga via Firebase. Den studerande ska kunna ta ett fullständigt och självständigt ansvar för leveransen av utvecklad programvara.

### **Förslag på hur VG kan nås på denna uppgift:**

* Mer avancerade actions än ett "Klick", t.ex. stegräknare

eller

* Applikationen som går att köra på både web, iOS och Android ser även duglig ut på samtliga plattformar (kräver viss styling och konfiguration i hur innehåll visas på olika plattformar)

eller 

* Utökad funktionalitet på översikten av "cliques" t.ex. att det går att se vilka som är mest aktiva eller liknande.

eller

* Avsaknad av uppenbara brister

eller

* Generellt genomgående hög kvalité på kod, struktur, designval

eller 

* Applikationen har en mer än godkänd användarupplevelse med intuitiv navigering, harmoniska färgval, omsorgsfullt valda typsnitt och komponenter, osv.

eller

* Eget förslag ...