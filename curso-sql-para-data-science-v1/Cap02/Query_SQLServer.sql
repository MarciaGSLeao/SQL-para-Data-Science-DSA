create database dsa_cap02
go

use dsa_cap02
go

create table tb_navios(
	nome_navio varchar(200),
	mes_ano varchar(20),
	classificacao_risco varchar(20),
	indice_conformidade float,
	pontuacao_risco int,
	temporada varchar(200)
)
go


-- Inserção em Massa
bulk insert tb_navios
from '\\VM-DELL\Users\VM_Dell\Downloads\DADOS_ABERTOS_INSPECAO_NAVIO.csv'  -- Caminho do arquivo no Servidor em que está instalado o SGBD (VM no Dell).
with(
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'  -- Não consegui usando o valor '\n'. Alternei para '0x0a' e o comando bulk processou. Muuuuuuito estranho. Fonte da pesquisa: 'https://isolution.pro/pt/q/so68956216/sql-server-bcp-bulk-insert-pipe-delimitado-com-arquivo-de-formato-de-qualificador-de-texto'
)
go

select * from tb_navios

/* EXERCÍCIO */
/* Trabalhando  com  o  mesmo  datasetusado  neste  capítulo, crie  instruções  SQL  que respondam às perguntas abaixo:

1-Quais embarcações possuem pontuação de risco igual a 310? - 2 registros */
select * from tb_navios where pontuacao_risco = 310

/*2-Quais embarcações têm classificação de risco A e índice de conformidade maior ou igual a 95%? - 259 registros */
select * from tb_navios where classificacao_risco = 'A' and indice_conformidade >= 95

/*3-Quais embarcações têm classificação de risco C ou D e índice de conformidade menor ou igual a 95%? - 98 registros */
select * from tb_navios where classificacao_risco in ('C', 'D') and indice_conformidade <= 95

/*4-Quais embarcações têm classificação de risco A ou pontuação de risco igual a 0? - 261 registros */
select * from tb_navios where classificacao_risco = 'A' or pontuacao_risco = 0

/*5-[DESAFIO]Quais embarcações foram inspecionadas em Dezembro de 2016? - 7 registros*/
select * from tb_navios where temporada like '%Dezembro 2016'
