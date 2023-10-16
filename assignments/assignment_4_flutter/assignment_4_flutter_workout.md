# Uppgift 4, träningsapp i Flutter

Du har redan kodat logiken för din applikation i Dart.

Nu är uppgiften tydlig: du ska färdigställa applikationen med hjälp av Flutter.

När kursen fortlöper kommer exempel tillhandahållas för hur olika vy-komponenter och koncept används som du kan välja att använda eller låta bli att använda i din applikation.

Tanken med denna applikation är att den ska byggas med iOS och Android som build target.

### Nedan är den funktionalitet som applikationen skall stödja:

---

- Generella funktioner:
    - Träningsdashboard - visar alla träningspass och deras status
- Övningshantering:
    - Skapa övningar - namn,beskrivning, repetitioner, vilotid, antal sets, vikt
    - Lista övningar
    - Uppdatera övningar
    - Radera övningar
- Träningspass:
    - Starta nytt träningspass
    - Återuppta pågående träningspass
    - Pausa träningspass
    - Lägg till övningar i träningspass - välj från lista av övningar
    - Registrera prestanda - antal sets samt repetioner+vikt per set
    - Visa träningsöversikt - vilka övningar som utförts, antal set, repetitioner och vikt.
    - Avsluta träningspass
- Dataintegritet och felsökning:
    - Validering - Ska inte gå att t.ex. utföra ett negativt antal repetitioner
    - Felåterkoppling - Användaren bör få tillbaka information om något gick fel
- Synkronisering och lagring:
    - Lokal lagring - Informationen i appen lagras lokalt på telefonen

---

### **För betyget G(godkänt) på uppgiften ska du lämna in din kod och bifoga en kort video som visar att din applikation stödjer ovan funktionalitet.**

### **För betyget VG(väl godkänt) på uppgifterna i kursen gäller följande beskrivning:**
Studenten ska utveckla programvara i ramverket Flutter med högre kvalitet än för betyget G. Exempel på hög kvalité är väl strukturerad och kommenterad källkod, utnyttjande av vedertagna goda principer och designmönster för mjukvaruutveckling, eller utökad funktionalitet/komplexitet i lösningar. Den studerande ska uppvisa mer än godkänd behärskning av att använda de olika tjänster som finns tillgängliga via Firebase. Den studerande ska kunna ta ett fullständigt och självständigt ansvar för leveransen av utvecklad programvara.

### **Förslag på hur VG kan nås på denna uppgift:**

- Implementera någon form av alarm / notis funktion för din träning, så att du får en vibration eller notis att nu är det dags att påbörja nästa set.

eller 

* Implementera BLoC för hanteringen av state i applikationen.

eller

* Applikationen har en mer än godkänd användarupplevelse med intuitiv navigering, harmoniska färgval, omsorgsfullt valda typsnitt och komponenter, osv.

eller

* Någon form av översikt av progression implementeras. T.ex. så att användaren kan se grafer över dess utveckling vad gäller repetitioner/vikt/tid för en viss typ av övning.

eller

* Generellt genomgående hög kvalité på kod, struktur, designval

eller

* eget förslag ...

