insert into Exame ( EID, duracao, Data, Password, boolInstantEnd) values ('bccb5ea3-63ab-41e7-9a12-c1b46528a7e6', 60, '25/05/2017', 'hR6WprGtY', 'FALSE');
select * from Resposta;
insert into Pergunta (descricao, ID, cotacao ,EID) values ('Represente o número decimal -129 em complemento para 2 com 8 bits.', 'de829dff-62be-4e10-9638-b143e37d782b', 5, 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6');
insert into Desenvolvimento(ID) values ('de829dff-62be-4e10-9638-b143e37d782b');
insert into Resposta (RID, cotacao, descricao, Data, ID) values ('1' , 5, 'RIP MPCP', '10:43 PM', 'de829dff-62be-4e10-9638-b143e37d782b');
insert into Resposta (RID, cotacao, descricao, Data, ID) values ('2' , 6, 'RIP MPCP', '10:43 PM', 'de829dff-62be-4e10-9638-b143e37d782b');
select * from Resposta;