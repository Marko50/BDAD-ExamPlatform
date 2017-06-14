CREATE TRIGGER somaCotacao
BEFORE INSERT on Pergunta
when (((select SUM(IFNULL(Pergunta.cotacao,0)) from Pergunta WHERE Pergunta.EID = New.EID) + New.cotacao) > 20)
BEGIN
	SELECT RAISE(ROLLBACK, 'Um exame nao pode ter mais de 20 valores.');
END;
