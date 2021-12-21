create database dsa_cap02;

use dsa_cap02;

create table tb_navios(
	nome_navio varchar(200),
	mes_ano varchar(20),
	classificacao_risco varchar(20),
	indice_conformidade float,
	pontuacao_risco int,
	temporada varchar(200)
);

-- Carga massiva
-- SHOW VARIABLES LIKE 'secure_file_priv'; -- Foi necessário alterar as configuração de segurança no arquivo de configuração my.cnf (C:\ProgramData\MySQL\MySQL Server 8.0)
SHOW VARIABLES LIKE 'local_infile';
set global local_infile=true;

/* load data infile 'C:/Marcia/DSA/Cap02/DADOS_ABERTOS_INSPECAO_NAVIO.txt' 
into table tb_navios
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

truncate table tb_navios; */

load data infile 'C:/Marcia/DSA/Cap02/DADOS_ABERTOS_INSPECAO_NAVIO.csv'
into table tb_navios
fields terminated by ';'
lines terminated by '\n'
ignore 1 rows;

select * from tb_navios

-- EXERCÍCIO 
-- Trabalhando  com  o  mesmo  datasetusado  neste  capítulo, crie  instruções  SQL  que respondam às perguntas abaixo:

-- 1-Quais embarcações possuem pontuação de risco igual a 310? - 2 registros
select * from tb_navios where pontuacao_risco = 310

-- 2-Quais embarcações têm classificação de risco A e índice de conformidade maior ou igual a 95%? - 259 registros 
select * from tb_navios where classificacao_risco = 'A' and indice_conformidade >= 95

-- 3-Quais embarcações têm classificação de risco C ou D e índice de conformidade menor ou igual a 95%? - 98 registros 
select * from tb_navios where classificacao_risco in ('C', 'D') and indice_conformidade <= 95

-- 4-Quais embarcações têm classificação de risco A ou pontuação de risco igual a 0? - 261 registros 
select * from tb_navios where classificacao_risco = 'A' or pontuacao_risco = 0

-- 5-[DESAFIO]Quais embarcações foram inspecionadas em Dezembro de 2016? - 7 registros
select * from tb_navios where temporada like '%Dezembro 2016'


