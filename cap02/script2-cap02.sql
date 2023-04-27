# Em Abril de 2018 alguma embarcação teve índice de conformidade de 100% e pontuação de risco igual a 0?

select nome_navio, classificacao_risco, mes_ano, indice_conformidade, pontuacao_risco, temporada
from tb_navios
where mes_ano = '04/2018' and indice_conformidade = 100 and pontuacao_risco = 0;
