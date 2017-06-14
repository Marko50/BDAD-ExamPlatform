CREATE TRIGGER onlyOne
BEFORE INSERT ON AlunoOpcao
WHEN ((SELECT EscolhaMultipla.ID from EscolhaMultipla,Opcao,AlunoOpcao 
WHERE AlunoOpcao.SID = New.SID AND AlunoOpcao.OID = Opcao.OID AND Opcao.ID = EscolhaMultipla.ID 
INTERSECT 
SELECT EscolhaMultipla.ID from EscolhaMultipla,Opcao WHERE New.OID = Opcao.OID AND Opcao.ID = EscolhaMultipla.ID) 
= 
(SELECT EscolhaMultipla.ID from EscolhaMultipla,Opcao WHERE New.OID = Opcao.OID AND Opcao.ID = EscolhaMultipla.ID))
BEGIN
	SELECT RAISE(ROLLBACK, 'Ja foi bloqueada uma opcao para esta pergunta!');
END;