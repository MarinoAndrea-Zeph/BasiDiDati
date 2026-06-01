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
| Desiderio | Possibilità di ottenere un personaggio, al costo di dei crediti di gioco | chance, pull | Banner |
| Abisso a Spirale | La modalità end game del gioco, dove i giocatori devono affrontare diverse ondate di mostri | Arena | Abisso a Spirale |
| Elite | Dei nemici particolarmente forti, con meccaniche uniche |  | Nemico |

## DIAGRAMMA ENTITY-RELATIONSHIP

![Diagramma E-R del database](/genshinDB.png "Diagramma E-R del database")

## DIZIONARIO DEI DATI - ENTITÀ

| Entità           | Descrizione | Attributi | Identificatore |
| :---------------- | :---------- | :------- | :----------- |
| Giocatore | i giocatori registrati a Genshin Impact | UID, nickname, email, dataRegistrazione, livello avventura, compleanno, sesso | UID |
| Armadietto Personaggi | i personaggi che ogni giocatore possiede | giocatore, personaggio, livello, costellazione, amicizia, dataAcquisizione | giocatore, personaggio |
| Artefatto | l'equipaggiamento assegnabile ai personaggi | ID, tipo, set, subSbloccato, mainStat, subStat1, subStat2, subStat3, subStat4 | ID |
| Personaggio | i personaggi presenti nel gioco | nome, elemento, arma, ascensionStat, attaccoBase, HPBase, difesaBase, costellazione | nome |
| Banner | dei luoghi dove è possibile ottenere specifici personaggi | versione, titolo, dataRilascio, dataScadenza | versione, titolo |
| Versione | le varie versioni del gioco | ID, titolo, dataRilascio, dataScadenza | ID |
| Abisso a Spirale | la modalità competitiva del gioco, dove i giocatori affrontano diversi nemici sempre più potenti | versione, faseLunare | versione, faseLunare |
| Nemico | i nemici del gioco | nome, HP, attacco, difesa, fazione | nome |

## DIZIONARIO DEI DATI - RELAZIONI

| Relazione           | Descrizione | Componenti | Attributi |
| :---------------- | :---------- | :------- | :----------- |
| Amicizia | i giocatori stringono amicizia tra di loro | Giocatore |  |
| Possesso | ogni giocatore possiede un armadietto personaggi | Giocatore, Armadietto Personaggi |  |
| Proprietà | ogni giocatore è proprietario di degli artefatti | Giocatore, Artefatti |  |
| Equipaggiamento | i personaggi nell'armadietto possono venire equipaggiati con degli artefatti | Armadietto Personaggi, Artefatti |  |
| Presenza | i personaggi sono presenti all'interno degli armadietti dei vari giocatori | Personaggio, Armadietto Personaggi |  |
| Esposizione | i personaggi vengono esposti in dei banner | Personaggio, Banner |  |
| Uscita | i banner escono nel corso di diverse versioni | Banner, Versione |  |
| Avvenimento | l'abisso a spirale esce e cambia in diverse versioni | Abisso a Spirale, Versione |  |
| Contenuto | i nemici riempiono l'Abisso per essere sfidati dai giocatori | Abisso a Spirale, Nemico | piano, camera, quantità |

## VINCOLI NON ESPRIMIBILI GRAFICAMENTE

* sesso deve essere tra M e F, non esprimendo il genere del giocatore, ma il sesso del personaggio selezionato, a scelta tra un maschio e una femmina
* le date di rilascio di banner e versioni non possono essere antecedenti a quelle di scadenza
* il livello di un personaggi va dall'1 al 90, la sua amicizia dall'1 al 10 e la sua costellazione dallo 0 al 6
* un artefatto può essere equipaggiato su un personaggio solo se entrambi sono di proprietà dello stesso giocatore
* gli artefatti di tipo 'fiore' devono avere 'HP' come statistica principale
* gli artefatti di tipo 'piuma' devono avere 'ATK' come statistica principale
* solo gli artefatti di tipo 'corona' posono avere 'CritDmg' e 'CritRate come statistica principale
* un giocatore non può possedere più di 1500 artefatti

## CONSIDERAZIONI GENERALI

Considerando che alcune statistiche di gioco fondamentali non sono rese note al pubblico, bisognerà inventarsi qualche formula per rendere possibile la rappresentazione di alcune cose. Ad esempio, delle costanti valide per tutti i personaggi che esprimano di quanto aumentano attacco, salute e difesa di base di ogni personaggio all'aumentare dei livelli. Oltretutto, per semplificare il calcolo delle statistiche complessive, ogni artefatto dovrà tenere traccia di tutte le statistiche possibili, lasciando a 0 quelle che non possiede realmente (un artefatto ha una statistica pricncipale e 4 secondarie, quindi 5 statistiche su 10 disponibili. Queste 5 avranno un valore > 1, le altre saranno impostate a 0). Questa scelta renderà possibile utilizzare formule standard per il calcolo delle statistiche complessive dei personaggi senza dover andare a chiedersi se l'artefatto possiede quella statistica o meno.

Ritengo oltremodo doveroso spiegare cosa indichi la relazione "Esposizione" con 4 frecce uscenti verso l'entità "Banner". Ogni Banner del gioco espone 1 personaggio _5 stelle_ e 3 personaggi _4 stelle_, per un totale di 4 personaggi per banner. Di conseguenza, all'interno del database i Banner verranno rappresentati con i loro dati specificati dall'Entità e poi da 4 colonne chiamate 5stelle, 4stelle1, 4stelle2, e 4stelle3. Sarebbe probabilmente stato più opportuno rappresentare quattro relazioni distinte e specificare tramite vincoli questo fattore, ma ho preferito optare per questa soluzione sia per un motivo estetico che per un motivo di compattezza. La relazione come realmente intesa dovrebbe somigliare all'immagine seguente: 

![Espansione della relazione "Esposizione"](/relazioneEsposizione.png "Espansione della relazione Esposizione")

## TAVOLA DEI VOLUMI

Supponiamo di dover utilizzare questo database per esprimere effettivamente i dati di gioco, utilizzando quindi dati effettivi reperiti online (data odierna 31/05/2026).
Genshin Impact ad oggi conta oltre 300 milioni (300'000'000+) di utenti registrati. 
Il gioco conta la bellezza di 116 personaggi giocabili. Ogni personaggio 5 stelle ha il suo banner dedicato, ad eccezione dei personaggi standard, per un totale di (65 personaggi 5 stelle - 8 standard) 57 banner differenti (che si ripetono però ciclicamente nel corso delle versioni). Essendo che lo stesso personaggio 5 stelle può presentarsi in più banner avendo però dei 4 stelle diversi combinati nelle diverse versioni e che dalla 1.0 alla 2.2 c'erano 2 banner per versione e dalla 2.3 in poi ce ne sono stati 4 per versione, possiamo approsimare il volume della tabella a 400 istanze (ad oggi dovrebbero essere usciti ~200 banner).
Le versioni di Genshin Impact vanno dalla 1.0 alla 6.6, Per un totale di 50 versioni esatte.
Ogni versione escono 2 Abissi a Spirale, per un totale di 100 abissi unici. Infine i nemici, contando nemici normali, elite e boss, ammontanto ad esattamente 331.

| Concetto | Tipo | Volume |
| :------- | :--- | :----- |
| Giocatore | E | 500'000'000 |
| Personaggio | E | 300 |
| Armadietto | E | 100'000'000'000 = (200 x 500'000'000) |
| Artefatti | E | 750'000'000'000 = (1500 x 500'000'000) |
| Banner | E | 400 |
| Versione | E | 100 |
| Abisso | E | 200 (2 x 100) |
| Nemico | E | 500 |
| Contenuto | R | 50'000 (100 x 500) |

Tutti i volumi indicati prevedono una eventuale crescita del gioco e della playerbase in base alla scala con cui potrebbero lievitare i numeri (ritengo più probabile che vengano creati circa 200'000'000 di account prima che vengano rilasciati 184 nuovi personaggi, con una media di 11 nuovi personaggi ogni anno).

## OPERAZIONI DI INTERESSE

## ANALISI DELLE RIDONDANZE

E' presente una ridondanza dovuta ad un ciclo tra le entità 'Giocatore', 'Armadietto Personaggi' e 'Artefatti', collegate tramite le relazioni 'Possesso', 'Equipaggiamento' e 'Proprietà'. Tuttavia, senza dover fare nessuna particolare analisi sugli accessi, si può dimostrare la necessità di questa ridondanza tramite un fattore implementativo: non tutti gli artefatti che un giocatore possiede sono equipaggiati a un personaggio. Di conseguenza, è necessario tenere traccia di ogni artefatto artefatto posseduto dai giocatori direttamente. Inoltre, non tutti i personaggi posseduti dai giocatori devono necessariamente avere degli artefatti, quindi non è possibile neppure risalire ai personaggi posseduti dai giocatori tramite gli artefatti. Ogni relazione è quindi necessaria per tenere traccia di ogni dato, altrimenti alcune informazioni sono andate perse. 

## ELIMINAZIONE DELLE GENERALIZZAZIONI

La generalizzazione dei nemici 'Normale', 'Elite' e 'Boss' in un'unica entità 'Nemico' è di tipo esclusivo, in quanto ogni nemico dovrà cadere in una di queste categorie (e una soltanto). Non avendo nessuna caratteristica che li distingua tra di loro, se non l'appartenenza stessa al gruppo, questa generalizzazione verrà tradotta con un attributo 'Grado' che esprime a quale categoria appartiene il nemico. Si manterrà quindi un'unica entità (e quindi poi tabella) 'Nemico'.

## PARTIZIONAMENTI DELLE ENTITÀ

## PARTIZIONAMENTO DI RELATIONSHIPS

## SCELTA DEGLI IDENTIFICATORI

## DIAGRAMMA E-R RISTRUTTURATO

## PASSAGGIO AL MODELLO RELAZIONALE

## SCHEMA LOGICO

## NORMALIZZAZIONE

## PROGETTAZIONE FISICA

## DESCRIZIONE DI FILE E CARTELLE
