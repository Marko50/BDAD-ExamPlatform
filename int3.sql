.mode columns
.headers on
.nullvalue NULL


CREATE VIEW DESENV AS SELECT TOTAL(Pergunta.cotacao) as total,Exame.EID AS EID from Exame 
LEFT JOIN Pergunta ON Pergunta.EID = Exame.EID
LEFT JOIN Desenvolvimento ON Desenvolvimento.ID = Pergunta.ID
WHERE Desenvolvimento.ID = Pergunta.ID
GROUP BY Exame.EID; --CERTO

CREATE VIEW MULT AS SELECT TOTAL(Pergunta.cotacao) as total,Exame.EID AS EID from Exame 
LEFT JOIN Pergunta ON Pergunta.EID = Exame.EID
LEFT JOIN EscolhaMultipla ON EscolhaMultipla.ID = Pergunta.ID
WHERE EscolhaMultipla.ID = Pergunta.ID
GROUP BY Exame.EID; --CERTO


SELECT Exame.EID FROM Exame, DESENV, MULT
WHERE DESENV.EID = MULT.EID AND DESENV.EID = Exame.EID AND DESENV.total > MULT.total;


DROP VIEW DESENV;
DROP VIEW MULT;