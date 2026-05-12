# Progetto di Basi di Dati 2026 - Marino Andrea - SM3201660

## INTRODUZIONE

Si vuole progettare e realizzare una base di dati che simuli il funzionamento (per quanto rudimentale e ridotto a casi più interessanti) del databse del videogioco Genshin Impact. L'obiettivo del database è quello di immagazzinare tutte le informazioni dei vari giocatori e dei dati più importanti per il corretto funzionamento del gioco, come i dati dei nemici e dei personaggi giocabili. Per chiarezza, Genshin impact è un videogioco Gacha RPG Open World nel quale i giocatori devono sconfiggere diversi nemici utilizzando gli elementi branditi dai personaggi e le interazioni tra di essi.

## ANALISI DEI REQUISITI

Cominciando dai dati dei giocatori, abbiamo certamente bisogno dell'email di ogni giocatore, a cui poi verrà assegnato un UID. Avremo poi ovviamente bisogno anche di sapere il nickname che ha scelto per il suo personaggio. Tenere traccia del suo livello durante l'avanzamento del gioco risulta molto importante e, per questioni di QOL dei giocatori, è interessante mantenere anche la data di nascita del giocatore. I giocatori potranno selezionare il sesso del personaggio principale. Non sempre rispecchierà il sesso dell'effettivo giocatore, ma essendo comunque una buona assunzione sul giocatore medio, il sesso che selezioneranno per il protagonista verrà comunque collegato al giocatore. I giocatori possono essere amici tra di loro scambiandosi il loro UID per poter giocare assieme.
Ogni giocatore entrerà piano piano in possesso di diversi personaggi, che verranno salvati in un armadietto personaggi. Ogni personaggio ha un nome unico, un elemento, un'arma e una serie di statistiche di base. Quando entra in possesso di un giocatore avrà successivzmente anche un livello, una costellazione, una data di acquisizione e un livello di amicizia.
I personaggi possiedono, dopo che un giocatore li ha ottenuti, un equipaggiamento, composto da 5 artefatti (un fiore, una piuma, una clessidra, una coppa e una corona) che migliorano le statistiche di base dei personaggi. Di conseguenza, per ogni artefatto si vuole sapere a che set appartenga, di che tipo sia e le statisctiche che migliorerà.
I personaggi vengono rilasciati e si ripresentano ricorrentemente durante dei banner, dei quali vogliamo sapere titolo, data di rilascio e data di scadenza. Utile ad identificare i banner risulta la presenza delle versioni di gioco, che avranno un codice (1.0, 2.5, 3.4, ...), un titolo, una data di inizio e di fine.
Un buon gioco RPG open world ha necessariamente bisogno di nemici. I nemici possono essere normali, elite o boss e di essi ci interessano sapere le varie statistiche di combattimento e il loro nome. Questi nemici saranno presenti nel mondo di gioco, ma soprattutto nella modalità di gioco competitiva conosciuta come _Abisso a Spirale_. In questa modalità, composta da piani e camere, i mostri si presenteranno con vari livelli di forza. Dell'Abisso a spirale ci interessa sapere la versione di uscita, la fase lunare e le camere e i piani da cui è composta.

## GLOSSARIO DEI TERMINI

| Termine           | Definizione | Sinonimi | Collegamento |
| :---------------- | :---------- | :------- | :----------- |
| RPG | Role Play Game, gioco di ruolo | GDR |  |
| Open World | Gioco in cui il mondo è liberamente esplorabile |  |  |
| Gacha | Gioco in cui i personaggi si ottengono tramite probabilità e non tramite avanzamento o acquisto diretto |  |  |
| Livello avventura | Il livello di esperienza del giocatore |  | Giocatore |
| Amicizia | Il livello di amicizia instaurato con un personaggio, direttamente proporzionale al tempo di gioco con esso | tempo di gioco | Personaggio, Giocatore, Armadietto Personaggi |
| Costellazione |  Il numero di volte che lo stesso personaggio è stato trovato | | Personaggio, Armadietto Personaggi |
| Elemento | I personaggi combattono con l'aiuto di uno dei 7 elementi | potere | Personaggio |
| Arma | I personaggi impugnano una delle 5 armi |  | Personaggio |
| Banner | I personaggi escono durante un banner, dove il giocatore può effettuare dei desideri |  | Banner |
| Desiderio | Possibilità di ottenere un personaggio, al costo di dei crediti di gioco | Canche, pull | Banner |
| Abisso | La modalità end game del gioco, dove i giocatori devono affrontare diverse ondate di mostri | Arena | Abisso a Spirale |
| Elite | Dei nemici particolarmente forti, con meccaniche uniche |  | Nemico |

## SUDDIVISIONE DEL TESTO IN FRASI OMOGENEE

## DIAGRAMMA ENTITY-RELATIONSHIP

## DIZIONARIO DEI DATI

## DIZIONARIO DEI DATI (RELATIONSHIPS)

## VINCOLI NON ESPRIMIBILI GRAFICAMENTE

## CONSIDERAZIONI GENERALI

## TAVOLA DEI VOLUMI

## OPERAZIONI DI INTERESSE

## ANALISI DELLE RIDONDANZE

## ELIMINAZIONE DELLE GENERALIZZAZIONI

## PARTIZIONAMENTI DELLE ENTITÀ

## PARTIZIONAMENTO DI RELATIONSHIPS

## SCELTA DEGLI IDENTIFICATORI

## DIAGRAMMA E-R RISTRUTTURATO

## PASSAGGIO AL MODELLO RELAZIONALE

## SCHEMA LOGICO

## NORMALIZZAZIONE

## PROGETTAZIONE FISICA

## DESCRIZIONE DI FILE E CARTELLE
