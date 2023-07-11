-- RESOLUÇÃO DE EXERCÍCIOS

/* FAZENDO A IMPORTAÇÃO DOS DADOS VIA LINHA DE COMANDO.
# Execute:
SET GLOBAL local_infile = true;


# Carrega os dados
LOAD DATA INFILE 'C:/Marcia/Cursos/DSA/SQL-para-Data-Science-DSA/cap06/exercicio-tb_bikes/csv/2012Q1-capitalbikeshare-tripdata.csv'
INTO TABLE `cap06`.`tb_bikes`
CHARACTER SET UTF8
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Se não conseguir executar via linha de comando, verificar e desabilitar temporariamente a variável 'secure_file_priv' no arquivo my.ini para conseguir executar a importação dos dados.
*/

# Duração total do aluguel das bikes (em horas)
select
	ceil(sum(duracao_segundos)/60/60) as duracao_total_horas
from tb_bikes;

# Duração total do aluguel das bikes (em horas), ao longo do tempo (soma acumulada)
select
	duracao_segundos,
    round(sum(duracao_segundos/60/60) over (order by data_inicio), 2) as duracao_acumulada_em_hr
	-- ceil(sum(duracao_segundos)/60/60) as duracao_total_horas
from tb_bikes;

# Duração total do aluguel das bikes (em horas), ao longo do tempo, por estação de início do aluguel da bike,
# quando a data de início foi inferior a '2012-01-08'
select
	estacao_inicio,
    round((duracao_segundos/60/60), 2) as duracao_em_horas,
    sum(round(duracao_segundos/60/60, 2)) over (partition by estacao_inicio order by data_inicio)  as duracao_em_horas_acumulada
from tb_bikes
where data_inicio < '2012-01-08';
