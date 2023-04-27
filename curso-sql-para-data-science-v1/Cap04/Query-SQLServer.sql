-- CRIAÇÃO DO BANCO DE DADOS
create database dsa_cap04
use dsa_cap04
go

-- CRIAÇÃO DAS TABELAS
create table tb_atletas (
	nome_atleta varchar(255),
	país_atleta varchar(100),
	esporte varchar(200)
)
create table tb_treinador (
	nome_treinador varchar(255),
	país_treinador varchar(255),
	esporte varchar(255),
	modalidade varchar(255)
)
create table tb_generos (
	esporte varchar(255),
	feminino int,
	masculino int,
	total int
)
create table tb_medalhas (
	[rank] varchar(5),
	país_medalha varchar(255),
	ouro int,
	prata int,
	bronze int,
	total int,
	rank_total varchar(5)
)
create table tb_times (
	nome_times varchar(255),
	esporte varchar(255),
	país_times varchar(255),
	modalidade varchar(255)
)
go

-- INSERÇÃO DE DADOS NAS TABELAS
begin transaction
bulk insert tb_atletas
from '\\VM-DELL\Users\VM_Dell\Downloads\Athletes.csv'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'
)
bulk insert tb_generos
from '\\VM-DELL\Users\VM_Dell\Downloads\EntriesGender.csv'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'
)
bulk insert tb_medalhas
from '\\VM-DELL\Users\VM_Dell\Downloads\Medals.csv'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'
)
bulk insert tb_times
from '\\VM-DELL\Users\VM_Dell\Downloads\Teams.csv'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'
)
bulk insert tb_treinador
from '\\VM-DELL\Users\VM_Dell\Downloads\Coaches.csv'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'
)
go

-- VERIFICAÇÃO 
select * from tb_atletas
select * from tb_generos
select * from tb_medalhas
select * from tb_times
select * from tb_treinador
go

-- CONFIRMAÇÃO DE INSERÇÃO
--commit

--=============================================================================================================================


