CREATE TABLE Giocatore (
	uid INT(10) PRIMARY KEY AUTO_INCREMENT,
    nickname VARCHAR(20) NOT NULL,
    email VARCHAR(45) NOT NULL,
    sesso CHAR(1),
    dataRegistrazione DATE DEFAULT current_timestamp NOT NULL,
    livelloAvventura TINYINT(2) NOT NULL,
    compleanno DATE NOT NULL,
    
    CONSTRAINT valid_email CHECK(email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),
    CONSTRAINT binary_gender CHECK(sesso IN ('M', 'F')),
    CONSTRAINT AR CHECK(livelloAvventura BETWEEN 0 AND 60)
);

CREATE TABLE ListaAmici (
	giocatore1 INT(10) NOT NULL,
    giocatore2 INT(10) NOT NULL,
    PRIMARY KEY (giocatore1, giocatore2),
    
    FOREIGN KEY (giocatore1) REFERENCES Giocatore(uid),
    FOREIGN KEY (giocatore2) REFERENCES Giocatore(uid),
    
    CONSTRAINT self_love CHECK(giocatore1 <> giocatore2)
);

CREATE TABLE ArmadiettoPersonaggi (
	uidGiocatore INT(10) NOT NULL,
    nomePersonaggio VARCHAR(20) NOT NULL,
    livello TINYINT(2) DEFAULT 1,
    amicizia TINYINT(2) DEFAULT 1,
    costellazione TINYINT(2) DEFAULT 0,
    dataAcquisizione DATE DEFAULT current_timestamp,
    PRIMARY KEY (uidGiocatore, nomePersonaggio),
    
    FOREIGN KEY (uidGiocatore) REFERENCES Giocatore(uid),
    FOREIGN KEY (nomePersonaggio) REFERENCES Personaggio(nome),
    
    CONSTRAINT maxminLevel CHECK(livello BETWEEN 1 AND 90),
    CONSTRAINT friendship CHECK(amicizia BETWEEN 1 AND 10),
    CONSTRAINT constellation CHECK(costellazione BETWEEN 0 AND 6)
);

CREATE TABLE Personaggio (
	nome VARCHAR(20) PRIMARY KEY,
    rarità TINYINT(1) NOT NULL,
    elemento VARCHAR(10) NOT NULL,
    arma VARCHAR(10) NOT NULL,
    costellazione VARCHAR(30) UNIQUE NOT NULL,
    attaccoBase INT NOT NULL,
    HPBase INT NOT NULL,
    difesaBase INT NOT NULL
    
    CONSTRAINT rarity CHECK(rarità IN (4, 5)),
    CONSTRAINT element CHECK(elemento IN ('pyro', 'hydro', 'cryo', 'electro', 'geo', 'anemo', 'dendro')),
    CONSTRAINT weapon CHECK(arma IN ('sword', 'claymore', 'polearm', 'bow', 'catalyst'))
);

CREATE TABLE Artefatto (
	ID INT AUTO_INCREMENT,
    proprietario INT(10) NOT NULL,
    personaggio VARCHAR(20),	-- un giocatore può possedere artefatti e non equipaggiarli / personaggio = NULL
    nomeSet VARCHAR(50) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    subSbloccato BOOL NOT NULL,
    mainStat VARCHAR(20) NOT NULL,
    HP TINYINT NOT NULL DEFAULT 0,
    HPperc TINYINT NOT NULL DEFAULT 0,
    ATK TINYINT NOT NULL DEFAULT 0,
    ATKperc TINYINT NOT NULL DEFAULT 0,
    DEF TINYINT NOT NULL DEFAULT 0,
    DEFperc TINYINT NOT NULL DEFAULT 0,
    elementalMastery TINYINT NOT NULL DEFAULT 0,
    energyRecharge TINYINT NOT NULL DEFAULT 0,
    critRate TINYINT NOT NULL DEFAULT 0,
    critDamage TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY (ID, proprietario, personaggio),
    
    FOREIGN KEY (proprietario, personaggio) REFERENCES ArmadiettoPersonaggi(uidGiocatore, nomePersonaggio),
    
    CONSTRAINT type CHECK(tipo IN ('fiore', 'piuma', 'clessidra', 'coppa', 'corona'))
);

-- i seguenti trigger si riferiscono a come sono distribuite le MainStat possibili tra i vari artefatti

DELIMITER $$
CREATE TRIGGER check_artefatto_insert
BEFORE INSERT ON Artefatto
FOR EACH ROW
BEGIN
    -- Il fiore DEVE avere HP come mainStat e HP > 0
    IF NEW.tipo = 'fiore' AND (NEW.mainStat != 'HP' OR NEW.HP = 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: il fiore deve avere mainStat = HP e HP > 0';
    END IF;

    -- La piuma DEVE avere ATK come mainStat e ATK > 0
    IF NEW.tipo = 'piuma' AND (NEW.mainStat != 'ATK' OR NEW.ATK = 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: la piuma deve avere mainStat = ATK e ATK > 0';
    END IF;

    -- critRate e critDamage come mainStat sono riservati alla corona
    IF NEW.mainStat IN ('critRate', 'critDamage') AND NEW.tipo != 'corona' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: critRate e critDamage come mainStat sono riservati alla corona';
    END IF;
END$$

CREATE TRIGGER check_artefatto_update
BEFORE UPDATE ON Artefatto
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'fiore' AND (NEW.mainStat != 'HP' OR NEW.HP = 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: il fiore deve avere mainStat = HP e HP > 0';
    END IF;

    IF NEW.tipo = 'piuma' AND (NEW.mainStat != 'ATK' OR NEW.ATK = 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: la piuma deve avere mainStat = ATK e ATK > 0';
    END IF;

    IF NEW.mainStat IN ('critRate', 'critDamage') AND NEW.tipo != 'corona' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: critRate e critDamage come mainStat sono riservati alla corona';
    END IF;
END$$

DELIMITER ;

CREATE TABLE Banner (
	titolo VARCHAR(50) NOT NULL,
    IDVersione INT NOT NULL,
    personaggio5 VARCHAR(20) NOT NULL,
    personaggio4_1 VARCHAR(20) NOT NULL,
    personaggio4_2 VARCHAR(20) NOT NULL,
    personaggio4_3 VARCHAR(20) NOT NULL,
    dataRilascio DATE NOT NULL,
    dataScadenza DATE NOT NULL,
    PRIMARY KEY (titolo, IDVersione),
    
	FOREIGN KEY (personaggio5) REFERENCES Personaggio(nome),
    FOREIGN KEY (personaggio4_1) REFERENCES Personaggio(nome),
    FOREIGN KEY (personaggio4_2) REFERENCES Personaggio(nome),
    FOREIGN KEY (personaggio4_3) REFERENCES Personaggio(nome)
);

-- i seguenti trigger verificano che i personaggi siano della rarità corretta all'inserimento e all'update

DELIMITER $$
CREATE TRIGGER check_banner_rarity_insert
BEFORE INSERT ON Banner
FOR EACH ROW
BEGIN
    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio5) != 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio5 deve avere rarità 5';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_1) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_1 deve avere rarità 4';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_2) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_2 deve avere rarità 4';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_3) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_3 deve avere rarità 4';
    END IF;
END$$


CREATE TRIGGER check_banner_rarity_update
BEFORE UPDATE ON Banner
FOR EACH ROW
BEGIN
    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio5) != 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio5 deve avere rarità 5';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_1) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_1 deve avere rarità 4';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_2) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_2 deve avere rarità 4';
    END IF;

    IF (SELECT rarità FROM Personaggio WHERE nome = NEW.personaggio4_3) != 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: personaggio4_3 deve avere rarità 4';
    END IF;
END$$

DELIMITER ;

CREATE TABLE Versione (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(100) UNIQUE NOT NULL, 
    dataRilascio DATE NOT NULL,
    dataScadenza DATE NOT NULL
);

CREATE TABLE Abisso (
	faseLunare VARCHAR(30) NOT NULL,
    IDVersione INT NOT NULL,
    PRIMARY KEY (faseLunare, IDVersione),
    
    FOREIGN KEY (IDVersione) REFERENCES Versione(ID)
);

CREATE TABLE Camera (
	piano TINYINT(2) NOT NULL,
    camera TINYINT(2) NOT NULL,
    faseLunare VARCHAR(30) NOT NULL,
    IDVersione INT NOT NULL,
    nemico VARCHAR(60) NOT NULL,
    quantità TINYINT NOT NULL,
    PRIMARY KEY (piano, camera, faseLunare, IDVersione, nemico),
    
    FOREIGN KEY (faseLunare, IDVersione) REFERENCES Abisso(faseLunare, IDVersione),
    FOREIGN KEY (nemico) REFERENCES Nemico(nome),
    
    CONSTRAINT floor CHECK(piano BETWEEN 1 AND 12),
    CONSTRAINT chamber CHECK(camera BETWEEN 1 AND 3)
);

CREATE TABLE Nemico (
	nome VARCHAR(60) PRIMARY KEY NOT NULL,
    fazione VARCHAR(20) NOT NULL,
    grado VARCHAR(8) NOT NULL,
    attacco TINYINT NOT NULL,
    difesa TINYINT NOT NULL,
    HP INT NOT NULL,
    
    CONSTRAINT faction CHECK(fazione IN ('umani', 'automi', 'fatui', 'hilichurl', 'elementali', 'abisso', 'bestie mistiche', 'leggende')),
    CONSTRAINT tier CHECK(grado IN ('normale', 'elite', 'boss'))
);