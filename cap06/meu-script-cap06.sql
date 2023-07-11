-- EXERCÍCIOS

# Total de vendas
select sum(valor_venda) as total from tb_vendas;

# Total de vendas por ano fiscal
select ano_fiscal, sum(valor_venda) as total_ano
from tb_vendas
group by ano_fiscal;

# Total de vendas por funcionário
select nome_funcionario, ano_fiscal, sum(valor_venda) as total_ano
from tb_vendas
group by nome_funcionario, ano_fiscal;

# Total de vendas por ano, por funcionário e total de vendas do ano
select
	ano_fiscal, 
    nome_funcionario,
    valor_venda,
    sum(valor_venda) over (partition by ano_fiscal) as total_ano
from tb_vendas
order by ano_fiscal;

# Total de vendas por ano, por funcionário e total de vendas geral
select
	ano_fiscal, 
    nome_funcionario,
    valor_venda,
    sum(valor_venda) over() as total_vendas_geral
from tb_vendas
order by ano_fiscal;

# Reescrevendo a query anterior usando subquery
select
	ano_fiscal, 
    nome_funcionario,
    valor_venda,
   (select sum(valor_venda) from tb_vendas) as faturamento_vendas_geral
from tb_vendas
order by ano_fiscal;
