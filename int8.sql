.mode columns
.headers on
.nullvalue NULL

-- Percentagem de Passagens
-- Numero de Passagens

Create VIEW Perguntas AS
SELECT Pergunta.EID as EID, Pergunta.ID as Pergunta, Pergunta.cotacao as Cotacao
FROM Pergunta, Exame WHERE Pergunta.EID = Exame.EID;

Create VIEW TotalExames AS
SELECT Exame.EID as EID, TOTAL(Perguntas.Cotacao) as total
FROM Exame LEFT JOIN Perguntas on Exame.EID = Perguntas.EID
GROUP BY Exame.EID;
--SELECT * from TotalExames;


Create View NPassagens As
SELECT Exame.EID As EID, IFNULL(COUNT(SubTotal.TOTAL),0) As Passagens
FROM Exame
LEFT JOIN 
(SELECT Notas.EID, COUNT(Notas.Nota) AS TOTAL from Notas LEFT JOIN TotalExames ON TotalExames.EID = Notas.EID Where Notas.Nota >= (TotalExames.Total /2) 
 GROUP BY Notas.EID)SubTotal
ON Exame.EID = SubTotal.EID
GROUP BY Exame.EID;
--select * from NPassagens;

--Where Notas.Nota >= (TotalExames.Total /2)

-- Numero de Total
Create View NTotal As
SELECT Notas.EID As EID, IFNULL(COUNT(Notas.Nota),0) As Total
FROM Notas
GROUP BY Notas.EID;
--select * from NTotal;


-- Query
Select NPassagens.EID, (100.0*NPassagens.Passagens/NTotal.Total) as PercentPassagens
From NPassagens, NTotal
Where NPassagens.EID = NTotal.EID
ORDER BY PercentPassagens;
-- (1 - este valor) para a percentagem de Chumbos

DROP VIEW NTotal;
DROP VIEW NPassagens;
DROP VIEW Perguntas;
DROP VIEW TotalExames;