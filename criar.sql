PRAGMA foreign_keys = off;
.mode columns
.headers on

BEGIN TRANSACTION;

-- Table: Aluno -- Povoada
CREATE TABLE Aluno (SID STRING PRIMARY KEY, name STRING NOT NULL); 

-- Table: AlunoOpcao -- Povoada
CREATE TABLE AlunoOpcao (SID STRING REFERENCES Aluno (SID), OID STRING REFERENCES Opcao (OID), PRIMARY KEY(SID,OID));

-- Table: AlunoResposta -- Povoada
CREATE TABLE AlunoResposta (SID STRING REFERENCES Aluno (SID), RID STRING REFERENCES Resposta (RID), PRIMARY KEY(SID,RID));;

-- Table: AlunoUC -- Povoada
CREATE TABLE AlunoUC (SID STRING REFERENCES Aluno (SID), UCID STRING REFERENCES  UnidadeCurricular (UCID), PRIMARY KEY(SID, UCID));

-- Table: Curso -- Povoada
CREATE TABLE Curso (CID STRING PRIMARY KEY, name STRING NOT NULL, UID STRING REFERENCES Universidade (UID));

-- Table: Desenvolvimento -- Povoada
CREATE TABLE Desenvolvimento (ID STRING REFERENCES Pergunta (ID) PRIMARY KEY);

-- Table: Escolha Multipla -- Povoada
CREATE TABLE EscolhaMultipla (ID STRING  REFERENCES Pergunta (ID) PRIMARY KEY , boolCheckBox BOOLEAN, desconto REAL);

-- Table: Exame -- Povoada
CREATE TABLE Exame (EID STRING PRIMARY KEY, duracao INTEGER NOT NULL CHECK (30 < duracao < 180), Data DATE, Password STRING NOT NULL CHECK (length(Password) >= 7), boolInstantEnd BOOLEAN);

-- Table: ExameProfessor -- Povoada
CREATE TABLE ExameProfessor (PID STRING REFERENCES Professor (PID), EID STRING REFERENCES Exame (EID), PRIMARY KEY(PID,EID));

-- Table: Opcao -- Povoada
CREATE TABLE Opcao (OID STRING PRIMARY KEY , descricao STRING NOT NULL, boolCorreta BOOLEAN, ID STRING REFERENCES EscolhaMultipla (ID));

-- Table: Pergunta - Povoada
CREATE TABLE Pergunta (descricao STRING NOT NULL, ID STRING PRIMARY KEY , cotacao REAL CHECK (cotacao <= 20), EID STRING REFERENCES Exame(EID));


-- Table: Professor -- Povoada
CREATE TABLE Professor (PID STRING PRIMARY KEY, name STRING NOT NULL);

-- Table: Resposta - Povoada
CREATE TABLE Resposta (RID STRING PRIMARY KEY, cotacao REAL NOT NULL CHECK (cotacao >= 0), descricao STRING NOT NULL, Data DATE, ID STRING REFERENCES Desenvolvimento(ID));

-- Table: Unidade Curricular -- Povoada
CREATE TABLE UnidadeCurricular (UCID STRING PRIMARY KEY, name STRING NOT NULL, CID STRING REFERENCES Curso (CID));

-- Table: Universidade -- Povoada
CREATE TABLE Universidade (UID STRING PRIMARY KEY, name STRING NOT NULL);

--Table: Tentativa
CREATE TABLE Tentativa(SID STRING REFERENCES Aluno(SID), OID STRING REFERENCES Opcao(OID), data DATE NOT NULL, PRIMARY KEY(SID,OID));

.read View.sql

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
