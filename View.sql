-- Criar view com aluno/exame/nota e criar trigger da view para ver se a nota < 0
CREATE VIEW CotEscolhasMultiplas AS SELECT Aluno.SID AS SID,TOTAL(Pergunta.cotacao) AS TotalEM,Exame.EID AS EID from Pergunta,Aluno,Exame 
LEFT JOIN EscolhaMultipla ON EscolhaMultipla.boolCheckBox = 'FALSE' AND EscolhaMultipla.ID = Pergunta.ID
LEFT JOIN Opcao On Opcao.ID = EscolhaMultipla.ID AND Opcao.boolCorreta = 'TRUE' LEFT JOIN AlunoOpcao On AlunoOpcao.OID = Opcao.OID 
WHERE Aluno.SID = AlunoOpcao.SID AND Exame.EID = Pergunta.EID GROUP BY Aluno.SID, Exame.EID; --CERTO

CREATE VIEW CotDesenvolvimento AS SELECT Aluno.SID AS SID, TOTAL(Resposta.cotacao) AS TotalDes,Exame.EID AS EID from Resposta,Aluno,Exame 
LEFT JOIN Pergunta ON Pergunta.EID = Exame.EID
LEFT JOIN Desenvolvimento ON Desenvolvimento.ID = Pergunta.ID  LEFT JOIN AlunoResposta ON AlunoResposta.RID = Resposta.RID 
WHERE Aluno.SID = AlunoResposta.SID AND AlunoResposta.RID = Resposta.RID AND Desenvolvimento.ID = Pergunta.ID AND Resposta.ID = Desenvolvimento.ID
GROUP BY Aluno.SID, Exame.EID; --CERTO


CREATE VIEW descontoEscolhasMultiplas AS SELECT Aluno.SID AS SID,TOTAL(EscolhaMultipla.desconto) AS TotalDesconto,Exame.EID AS EID 
from Aluno,EscolhaMultipla,Exame,Pergunta
LEFT JOIN Opcao ON Opcao.ID = EscolhaMultipla.ID AND Opcao.boolCorreta = 'FALSE' LEFT JOIN AlunoOpcao ON AlunoOpcao.OID = Opcao.OID
WHERE Aluno.SID = AlunoOpcao.SID AND Exame.EID = Pergunta.EID AND EscolhaMultipla.ID = Pergunta.ID 
GROUP BY Aluno.SID, Exame.EID; --CERTO


CREATE VIEW numCheckBoxOptions AS SELECT EscolhaMultipla.ID as ID,Exame.EID as EID,COUNT(Opcao.ID) as Numero from EscolhaMultipla,Exame,Opcao 
LEFT JOIN Pergunta ON Pergunta.EID = Exame.EID 
WHERE  EscolhaMultipla.ID = Opcao.ID AND Opcao.boolCorreta = 'TRUE' AND EscolhaMultipla.ID = Opcao.ID AND EscolhaMultipla.ID = Pergunta.ID AND EscolhaMultipla.boolCheckBox = 'TRUE'
GROUP BY EscolhaMultipla.ID, Exame.EID;

CREATE VIEW numCheckBoxOptionsCorrected AS SELECT Aluno.SID as SID,Exame.EID as EID,COUNT(Opcao.ID) as Numero from Opcao,Aluno,Exame 
LEFT JOIN Pergunta ON Pergunta.EID = Exame.EID LEFT JOIN EscolhaMultipla ON EscolhaMultipla.boolCheckBox = 'TRUE' AND EscolhaMultipla.ID = Pergunta.ID
LEFT JOIN AlunoOpcao On AlunoOpcao.OID = Opcao.OID 
WHERE Opcao.ID = EscolhaMultipla.ID AND Opcao.boolCorreta = 'TRUE' AND  Aluno.SID = AlunoOpcao.SID AND Exame.EID = Pergunta.EID 
GROUP BY Aluno.SID, Exame.EID; --CERTO

CREATE VIEW CotCheckBox 
AS SELECT Aluno.SID AS SID,(numCheckBoxOptionsCorrected.Numero*(Pergunta.cotacao/numCheckBoxOptions.Numero)) as VALOR ,Exame.EID AS EID 
from numCheckBoxOptions,numCheckBoxOptionsCorrected,Aluno,Exame,Pergunta 
WHERE numCheckBoxOptions.ID = Pergunta.ID AND numCheckBoxOptions.EID = Exame.EID AND numCheckBoxOptionsCorrected.EID = Exame.EID 
AND numCheckBoxOptionsCorrected.SID = Aluno.SID GROUP BY Aluno.SID, Exame.EID; --Certo


CREATE VIEW Notas 
AS SELECT Aluno.name AS Name, Exame.EID AS EID, (IFNULL(CotCheckBox.VALOR,0) + IFNULL(descontoEscolhasMultiplas.TotalDesconto,0) + IFNULL(CotDesenvolvimento.TotalDes,0) + IFNULL(CotEscolhasMultiplas.TotalEM,0)) AS Nota
FROM Aluno,Exame 
LEFT OUTER JOIN cotCheckBox ON cotCheckBox.SID = Aluno.SID AND cotCheckBox.EID = Exame.EID
LEFT OUTER JOIN descontoEscolhasMultiplas ON descontoEscolhasMultiplas.SID = Aluno.SID AND descontoEscolhasMultiplas.EID = Exame.EID
LEFT OUTER JOIN CotDesenvolvimento ON CotDesenvolvimento.SID = Aluno.SID AND CotDesenvolvimento.EID = Exame.EID
LEFT OUTER JOIN CotEscolhasMultiplas ON CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID
WHERE (cotCheckBox.SID = Aluno.SID AND cotCheckBox.EID = Exame.EID) OR (descontoEscolhasMultiplas.SID = Aluno.SID AND descontoEscolhasMultiplas.EID = Exame.EID)
OR (CotDesenvolvimento.SID = Aluno.SID AND CotDesenvolvimento.EID = Exame.EID) OR (CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID)
OR (CotEscolhasMultiplas.SID = Aluno.SID AND CotEscolhasMultiplas.EID = Exame.EID)
GROUP BY Aluno.SID,Exame.EID;  --Certo
