/* # CRIAÇÃO DA TABELA
CREATE TABLE `cap02`.`tb_navios` (
  `nome_navio` VARCHAR(50) NULL,
  `mes_ano` VARCHAR(10) NULL,
  `classificacao_risco` VARCHAR(15) NULL,
  `indice_conformidade` VARCHAR(15) NULL,
  `pontuacao_risco` INT NULL,
  `temporada` VARCHAR(200) NULL);
*/
select max(pontuacao_risco) from tb_navios;
select min(pontuacao_risco) from tb_navios;

SELECT nome_navio, classificacao_risco, indice_conformidade, temporada
FROM cap02.tb_navios
WHERE classificacao_risco in ('A', 'B') and indice_conformidade > 90 # Classificação D é considerada a pior de acordo com o discionário de dados.
ORDER BY indice_conformidade
LIMIT 10;
