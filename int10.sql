.mode columns
.headers on
.nullvalue NULL

SELECT COUNT(Aluno.SID) AS Alunos 
from Aluno
WHERE NOT EXISTS(select * from Notas where Aluno.name = Notas.name);
