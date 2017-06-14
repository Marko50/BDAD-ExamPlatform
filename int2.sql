.mode columns
.headers on
.nullvalue NULL

CREATE VIEW NotasRounded
AS SELECT Aluno.name AS Name, Exame.EID AS EID, (ROUND(IFNULL(CotCheckBox.VALOR,0) + IFNULL(descontoEscolhasMultiplas.TotalDesconto,0) + IFNULL(CotDesenvolvimento.TotalDes,0) + IFNULL(CotEscolhasMultiplas.TotalEM,0))) AS Nota
FROM Aluno,Exame 
LEFT OUTER JOIN cotCheckBox ON cotCheckBox.SID = Aluno.SID AND cotCheckBox.EID = Exame.EID
LEFT OUTER JOIN descontoEscolhasMultiplas ON descontoEscolhasMultiplas.SID = Aluno.SID AND descontoEscolhasMultiplas.EID = Exame.EID
LEFT OUTER JOIN CotDesenvolvimento ON CotDesenvolvimento.SID = Aluno.SID AND CotDesenvolvimento.EID = Exame.EID
LEFT OUTER JOIN CotEscolhasMultiplas ON CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID
WHERE (cotCheckBox.SID = Aluno.SID AND cotCheckBox.EID = Exame.EID) OR (descontoEscolhasMultiplas.SID = Aluno.SID AND descontoEscolhasMultiplas.EID = Exame.EID)
OR (CotDesenvolvimento.SID = Aluno.SID AND CotDesenvolvimento.EID = Exame.EID) OR (CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID)
OR (CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID)
GROUP BY Aluno.SID,Exame.EID;



SELECT NotasRounded.Nota, 
       COUNT(NotasRounded.nota) AS 'Count'
FROM NotasRounded WHERE NotasRounded.EID = 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6'
GROUP BY NotasRounded.nota ORDER BY NotasRounded.nota;

DROP View NotasRounded;