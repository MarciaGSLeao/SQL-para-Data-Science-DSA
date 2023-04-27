-- EXERCÍCIO 
-- Trabalhando  com  o  mesmo  datasetusado  neste  capítulo, crie  instruções  SQL  que respondam às perguntas abaixo:

-- 1-Quais embarcações possuem pontuação de risco igual a 310? - 2 registros
select * from tb_navios where pontuacao_risco = 310;

-- 2-Quais embarcações têm classificação de risco A e índice de conformidade maior ou igual a 95%? - 259 registros
select * from tb_navios where classificacao_risco = 'A' and indice_conformidade >= 95;

-- 3-Quais embarcações têm classificação de risco C ou D e índice de conformidade menor ou igual a 95%? - 98 registros 
select * from tb_navios where classificacao_risco in ('C', 'D') and indice_conformidade <= 95;

-- 4-Quais embarcações têm classificação de risco A ou pontuação de risco igual a 0? - 261 registros 
select * from tb_navios where classificacao_risco = 'A' or pontuacao_risco = 0;

-- 5-[DESAFIO]Quais embarcações foram inspecionadas em Dezembro de 2016? - 7 registros
select * from tb_navios where temporada like '%Dezembro 2016';