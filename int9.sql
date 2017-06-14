.mode columns
.headers on
.nullvalue NULL

SELECT '2017-05-25' as FirstDate, '2017-05-30' as SecondDate, COUNT(Exame.EID) AS NumberOfExams FROM Exame WHERE Exame.Data BETWEEN '2017-05-25' AND '2017-05-30';
