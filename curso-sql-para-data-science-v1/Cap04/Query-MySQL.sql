-- CRIAÇÃO DO BANCO DE DADOS
create database dsa_cap04;
use dsa_cap04;

-- CRIAÇÃO DAS TABELAS
create table tb_atletas (
	nome_atleta varchar(255),
	país_atleta varchar(100),
	esporte varchar(200)
);
create table tb_treinador (
	nome_treinador varchar(255),
	país_treinador varchar(255),
	esporte varchar(255),
	modalidade varchar(255)
);
create table tb_generos (
	esporte varchar(255),
	feminino int,
	masculino int,
	total int
);
create table tb_medalhas (
	ranking varchar(5),
	país_medalha varchar(255),
	ouro int,
	prata int,
	bronze int,
	total int,
	rank_total varchar(5)
);
create table tb_times (
	nome_times varchar(255),
	esporte varchar(255),
	país_times varchar(255),
	modalidade varchar(255)
);

-- INSERÇÃO DE DADOS NAS TABELAS
# SHOW VARIABLES LIKE 'secure_file_priv'; -- Foi necessário alterar as configuração de segurança no arquivo de configuração my.cnf (C:/ProgramData/MySQL/MySQL Server 8.0)
SHOW VARIABLES LIKE 'local_infile';
set global local_infile=true;

load data infile 'C:/Marcia/DSA/Cap04/archive/Athletes.csv' 
into table tb_atletas
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:/Marcia/DSA/Cap04/archive/EntriesGender.csv' 
into table tb_generos
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:/Marcia/DSA/Cap04/archive/Medals.csv' 
into table tb_medalhas
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:/Marcia/DSA/Cap04/archive/Teams.csv' 
into table tb_times
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:/Marcia/DSA/Cap04/archive/Coaches.csv' 
into table tb_treinador
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

-- VERIFICAÇÃO 
select * from tb_atletas;
select * from tb_generos;
select * from tb_medalhas;
select * from tb_times;
select * from tb_treinador;
