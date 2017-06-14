.mode columns
.headers on
.nullvalue NULL

SELECT Notas.EID as Exame, AVG(Notas.Nota) as Media, COUNT(Notas.nota) as NumAlunos, MAX(Notas.nota) as MelhorNota, MIN(Notas.nota) as PiorNota
FROM Notas WHERE Notas.EID = 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6';