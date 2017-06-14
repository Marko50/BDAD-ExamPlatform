.mode columns
.headers on
.nullvalue NULL


SELECT Exame.boolInstantEnd as InstantEnd,  AVG(Notas.nota) AS 'AVG'
FROM Notas, Exame WHERE Notas.EID = Exame.EID
GROUP BY Exame.boolInstantEnd;
