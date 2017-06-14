CREATE TRIGGER cotacaoResposta
BEFORE INSERT ON Resposta
WHEN (NEW.cotacao > (Select Pergunta.cotacao from Pergunta,Desenvolvimento WHERE New.ID = Desenvolvimento.ID AND Desenvolvimento.ID = Pergunta.ID))
BEGIN
	SELECT RAISE(ROLLBACK, 'Esta resposta tem uma cotacao atribuida maior que a Pergunta');
END;
