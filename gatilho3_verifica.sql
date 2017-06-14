select * from AlunoOpcao;
insert into Aluno (SID, name) values ('fd020136-f60d-4dc0-bbd8-b6e8d98b593d', 'Angela Long');
insert into Exame ( EID, duracao, Data, Password, boolInstantEnd) values ('bccb5ea3-63ab-41e7-9a12-c1b46528a7e6', 60, '25/05/2017', 'hR6WprGtY', 'FALSE');
insert into Pergunta (descricao, ID, cotacao ,EID) values ('Represente o número decimal -129 em complemento para 2 com 8 bits.', 'de829dff-62be-4e10-9638-b143e37d782b', 1.00, 'bccb5ea3-63ab-41e7-9a12-c1b46528a7e6');
insert into EscolhaMultipla(ID, boolCheckBox, desconto) values('de829dff-62be-4e10-9638-b143e37d782b', 'FALSE',-1);
insert into Opcao (OID, descricao, boolCorreta, ID) values ('1', '100000012', 'FALSE',  'de829dff-62be-4e10-9638-b143e37d782b');
insert into Opcao (OID, descricao, boolCorreta, ID) values ('2', 'Não é possível representar', 'TRUE', 'de829dff-62be-4e10-9638-b143e37d782b');
insert into Opcao (OID, descricao, boolCorreta, ID) values ('3', '111111112', 'FALSE', 'de829dff-62be-4e10-9638-b143e37d782b');
insert into Opcao (OID, descricao, boolCorreta, ID) values ('4', '100000002', 'FALSE', 'de829dff-62be-4e10-9638-b143e37d782b');
insert into AlunoOpcao (SID, OID) values ((select SID from Aluno where name = 'Angela Long') , '2'); --Certa 
insert into AlunoOpcao (SID, OID) values ((select SID from Aluno where name = 'Angela Long') , '3'); --Certa 
select * from AlunoOpcao;