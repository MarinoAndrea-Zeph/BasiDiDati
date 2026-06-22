USE genshinDB;

-- Ricerca dei dati di un giocatore

DELIMITER $$

CREATE PROCEDURE genshinDB.getPlayerData(IN searchname VARCHAR(20))
BEGIN
	SELECT *
    FROM Giocatore
    WHERE nickname = searchname;
END$$

-- Visualizzazione della lista degli amici di un giocatore

CREATE PROCEDURE genshinDB.getFriendsList(IN searchname VARCHAR(20))
BEGIN
	SELECT l.giocatore2, g.nickname
    FROM ListaAmici l JOIN Giocatore g ON l.giocatore2 = g.uid
    WHERE l.giocatore1 = (SELECT uid
						FROM Giocatore
						WHERE nickname = searchname)
                        
	UNION
    
    SELECT l.giocatore1, g.nickname
    FROM ListaAmici l JOIN Giocatore g ON l.giocatore1 = g.uid
    WHERE l.giocatore2 = (SELECT uid
						FROM Giocatore
						WHERE nickname = searchname);
END$$

-- Ordinamento dei personaggi posseduti da un giocatore per livello (decrescente)

CREATE PROCEDURE genshinDB.getCharacterList(IN searchname VARCHAR(20))
BEGIN
	SELECT a.*
    FROM ArmadiettoPersonaggi a JOIN Giocatore g ON a.uidGiocatore = g.uid
    WHERE g.nickname = searchname
    ORDER BY a.livello DESC, a.nomePersonaggio ASC;
END$$

-- Calcolo delle statistiche totali di un personaggio posseduto da un giocatore

CREATE PROCEDURE genshinDB.getCharacterStats(IN searchname VARCHAR(20), IN searchcharacter VARCHAR(20))
BEGIN
	-- base * artefatti.perc + artefatti.flat + growth * livello
	SELECT a.nomePersonaggio, p.attaccoBase + (p.attaccoBase * (COALESCE(SUM(ar.ATKperc), 0) / 100)) + COALESCE(SUM(ar.ATK), 0) + (2.2 * a.livello) AS ATK, 
								p.HPBase + (p.HPBase * (COALESCE(SUM(ar.HPperc), 0) / 100)) + COALESCE(SUM(ar.HP), 0) + (45 * a.livello)  AS HP, 
								p.difesaBase + (p.difesaBase * (COALESCE(SUM(ar.DEFperc), 0) / 100)) + COALESCE(SUM(ar.DEF), 0) + (6.5 * a.livello)  AS DEF,
                                COALESCE(SUM(ar.elementalMastery), 0) AS elementalMastery,
                                CONCAT(COALESCE(SUM(ar.energyRecharge), 0), '%') AS energyRecharge,
                                CONCAT(COALESCE(SUM(ar.critRate), 0), '%') AS critRate,
                                CONCAT(COALESCE(SUM(ar.critDamage), 0), '%') as critDamage
    FROM ArmadiettoPersonaggi a JOIN Giocatore g ON a.uidGiocatore = g.uid
								JOIN Personaggio p ON a.nomePersonaggio = p.nome
                                LEFT JOIN Artefatto ar ON ar.personaggio = a.nomePersonaggio AND ar.proprietario = a.uidGiocatore
    WHERE g.nickname = searchname AND a.nomePersonaggio = searchcharacter
    GROUP BY a.nomePersonaggio;
END$$

-- Ricerca degli artefatti di un giocatore per statistica principale

CREATE PROCEDURE genshinDB.getArtifacts(IN searchname VARCHAR(20), IN searchstat VARCHAR(20))
BEGIN
	SELECT a.*
    FROM Artefatto a JOIN Giocatore g ON a.proprietario = g.uid
    WHERE g.nickname = searchname AND a.mainStat = searchstat;
END$$

-- Elenco dei nemici presenti nell'Abisso per piano in una determinata versione

CREATE PROCEDURE genshinDB.displayAbyss(IN versionfilter DECIMAL(3, 1))
BEGIN
	SELECT piano, camera, nemico, quantità
    FROM camera
    WHERE IDVersione = versionfilter
    ORDER BY piano ASC, camera ASC;
END$$

-- Conteggio dei giocatori raggruppati per Livello Avventura

CREATE PROCEDURE genshinDB.playerReport()
BEGIN
	SELECT livelloAvventura, COUNT(*) AS avventurieri
    FROM Giocatore
    GROUP BY livelloAvventura;
END$$

-- Elenco dei giocatori che compiono gli anni in data corrente

CREATE PROCEDURE genshinDB.getTodaysBirthdays()
BEGIN
	SELECT nickname, (YEAR(CURRENT_DATE) - YEAR(compleanno)) AS età
    FROM Giocatore
    WHERE DAY(compleanno) = DAY(CURRENT_DATE) AND MONTH(compleanno) = MONTH(CURRENT_DATE);
END$$
