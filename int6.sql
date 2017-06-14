.mode columns
.headers on
.nullvalue NULL

-- 3) Top 3 notas de um determinado exame (s/ limit);
SELECT Notas.Name, Notas.EID, Notas.nota FROM Notas
  where Notas.Nota >=(select max(Notas.nota)   from Notas
  where Notas.Nota < (select max(Notas.Nota)   from Notas
  where Notas.Nota < (select max(Notas.Nota)   from Notas
  where Notas.Nota < (select max(Notas.Nota) from Notas)))) and Notas.EID = 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6';

-- (c/ limit)
/*
SELECT Notas.Name, Notas.EID, Notas.Nota
FROM Notas
Where Notas.EID = 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6'
ORDER BY Notas.Nota DESC LIMIT 0,3;
*/