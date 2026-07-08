# Curling Timer – användarguide

Curling Timer är en tidtagarapp för curling, för iPhone och Apple Watch. Den mäter tiden det tar för en sten att passera mellan två linjer på isen. Med den tiden kan laget bedöma stenens fart ("weight") och förutsäga var den kommer att stanna i boet.

## Så fungerar mätningen

Du väljer en mätsträcka (Timing Strategy) och startar klockan när stenen passerar den första linjen, och stoppar den när stenen passerar hoglinjen i motsatt ände (eller den andra hoglinjen, beroende på läge).

| Mätsträcka | Start | Stopp |
|---|---|---|
| Tee -> Hog | Tee-linjen | Närmaste hoglinjen |
| Back -> Hog | Backlinjen | Närmaste hoglinjen |
| Hog -> Hog | Första hoglinjen | Andra hoglinjen |

I lägena **Tee -> Hog** och **Back -> Hog** räknar appen automatiskt ut tiden för den sträcka du inte klockade. Du får alltså alltid både en Tee-tid och en Back-tid, där den klockade tiden ligger till grund för den beräknade. Omräkningen använder ett fast förhållande: Back-tiden är 1,256 gånger Tee-tiden.

I läget **Hog -> Hog** loggas bara den klockade tiden.

Tider visas i sekunder med två decimaler.

## iPhone-appen

Skärmen består av tre delar:

- **Sidhuvudet** överst. Tryck på logotypen för att visa en kort beskrivning av appen. Tryck på kugghjulet för att öppna inställningarna.
- **Loggen** i mitten, med en rad per mätning.
- **Urtavlan** längst ner (i liggande läge till höger).

### Ta en tid

1. Tryck var som helst på urtavlan när stenen passerar startlinjen. Ringen byter färg, texten visar STOP och tiden börjar räknas.
2. Tryck igen när stenen passerar hoglinjen. Tiden stannar, visas i mitten av urtavlan och sparas som en ny rad överst i loggen.

Telefonen ger en vibration både vid start och vid stopp, med olika känsla så att du får en tydlig bekräftelse på att tiden fångades.

### Loggen

Varje rad visar klockslaget för mätningen (24-timmarsformat) samt tiderna:

- I Tee- och Back-lägena visas två kolumner: **Tee** och **Back**.
- I Hog -> Hog-läget visas en kolumn: **Hog**.

Den senaste mätningen ligger alltid överst. Tryck på **Clear log** och bekräfta för att tömma loggen.

### Inställningar

Tryck på kugghjulet och välj mätsträcka under **Timing Strategy**. Observera att loggen töms när du byter mätsträcka — tider tagna på olika sträckor går inte att jämföra. Stäng med **Close Settings**.

## Apple Watch-appen

Klock-appen fungerar fristående — du behöver inte ha telefonen med dig på isen.

Appen har tre sidor som du bläddrar mellan genom att svepa uppåt/nedåt (eller vrida på kronan):

1. **Klockan** — tryck var som helst på skärmen för att starta respektive stoppa tidtagningen, precis som på telefonen. Bakgrundsfärgen visar läget och den valda mätsträckan står längst ner. Klockan ger haptisk återkoppling vid start och stopp.
2. **Loggen** — samma innehåll som på telefonen: klockslag och tider, senaste mätningen överst. Här finns texten "No times stored" om inga tider tagits ännu.
3. **Inställningar** — välj mätsträcka under **Timing Strategy** (loggen töms vid byte) eller töm loggen manuellt med **Clear log**.

## Bra att veta

- **Loggen sparas inte** mellan körningar. Den töms när appen stängs, när du byter mätsträcka och när du väljer Clear log.
- **iPhone och Apple Watch delar inte data.** Tider tagna på klockan syns inte på telefonen och tvärtom.
- **Tolka tiderna:** kortare tid betyder tyngre sten (längre glid), längre tid betyder lättare sten. Genom att jämföra tiden med tidigare stenar på samma is kan skippern bedöma om stenen når boet, blir kort eller går igenom. Isen ändrar sig under matchen, så det är jämförelsen mellan färska mätningar som ger den bästa bilden.
