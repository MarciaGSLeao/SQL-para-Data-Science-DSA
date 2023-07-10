-- EXERCÍCIOS

# Retornar quantidade de clientes por cidade.
select cidade_cliente, count(id_cliente) as total
from tb_clientes
GROUP BY cidade_cliente
ORDER BY total DESC;

# Retornar a média dos pedidos.
SELECT ROUND(AVG(valor_pedido), 2) AS media_valor
FROM tb_pedidos;

# Retornar a média dos pedidos por cidade
SELECT cidade_cliente AS CIDADE, ROUND(AVG(valor_pedido), 2) AS MÉDIA
FROM tb_pedidos P
INNER JOIN tb_clientes C
ON C.id_cliente = P.id_cliente
group by cidade_cliente
ORDER BY MÉDIA DESC;

# Retornar a média dos pedidos por cidade, inclusive as cidades que não houve venda
SELECT cidade_cliente AS CIDADE, 
		CASE 
			WHEN ROUND(AVG(valor_pedido), 2) > 0 THEN ROUND(AVG(valor_pedido), 2)
			ELSE 0
		END AS MÉDIA
FROM tb_pedidos P
RIGHT JOIN tb_clientes C
ON C.id_cliente = P.id_cliente
group by cidade_cliente
ORDER BY MÉDIA DESC;

# Retornar a soma de todos os pedidos
SELECT SUM(valor_pedido) AS FATURAMENTO
FROM tb_pedidos;

# Retornar a soma de todos os pedidos por cidade e por Estado
SELECT estado_cliente AS UF,
       cidade_cliente AS CIDADE, 
		CASE 
			WHEN SUM(valor_pedido) > 0 THEN SUM(valor_pedido)
			ELSE 0
		END AS FATURAMENTO
FROM tb_pedidos P
RIGHT JOIN tb_clientes C
ON C.id_cliente = P.id_cliente
group by estado_cliente, cidade_cliente
ORDER BY estado_cliente, FATURAMENTO DESC;

# Supondo que a comissão de cada vendedor seja de 10%, quanto cada vendedor ganhou de comissão nas vendas no estado do Ceará?
# Retorne 0 se não houve ganho de comissão.
SELECT 
	nome_vendedor AS VENDEDOR,
	CASE
		WHEN estado_cliente IS NULL THEN 'S/V'
		ELSE estado_cliente
	END AS UF,
	CASE 
		WHEN SUM(valor_pedido) > 0 THEN SUM(valor_pedido)
		ELSE 0
	END AS FATURAMENTO,
    CASE
		WHEN ROUND(SUM(valor_pedido)*0.1, 2) IS NULL THEN 0
        ELSE ROUND(SUM(valor_pedido)*0.1, 2) 
	END AS COMISSÃO
FROM tb_pedidos P INNER JOIN tb_clientes C RIGHT JOIN tb_vendedor V
ON C.id_cliente = P.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'CE'
GROUP BY nome_vendedor, estado_cliente
ORDER BY COMISSÃO DESC;

# Número de clientes que tiveram pedidos
SELECT COUNT(DISTINCT(id_cliente)) AS TOTAL
FROM tb_pedidos;

# Algum vendedor participou de vendas cujo valor do pedido tenha sido superior a 600 no estado de SP?
select nome_vendedor, estado_cliente, valor_pedido
from tb_clientes c inner join tb_pedidos p inner join tb_vendedor v
on c.id_cliente = p.id_cliente
and v.id_vendedor = p.id_vendedor
and valor_pedido > 600
and estado_cliente = 'SP';

# Algum vendedor participou de vendas em que a média do valor_pedido por estado do cliente foi superior a 800?
select estado_cliente, ROUND(AVG(valor_pedido),2) AS média, nome_vendedor
from tb_clientes c INNER join tb_pedidos p INNER JOIN tb_vendedor v
on c.id_cliente = p.id_cliente
AND P.id_vendedor = V.id_vendedor
GROUP BY estado_cliente, nome_vendedor
HAVING média > 800
ORDER BY nome_vendedor;

# Qual estado teve mais de 5 pedidos?
SELECT estado_cliente, COUNT(id_pedido) AS qtd_pedidos
FROM tb_clientes c INNER JOIN tb_pedidos p
ON c.id_cliente = p.id_cliente
GROUP BY estado_cliente
HAVING qtd_pedidos > 5;

# Usando ROLLUP
SELECT ano, SUM(faturamento) AS faturamento
FROM tb_vendas
GROUP BY ANO WITH rollup;

# Faturamento total por ano e paísavepoint
select 
	if(grouping(ano), 'Total de Todos os Anos', ano) as ano,
	if(grouping(pais), 'Total de Todos os Países', pais) as pais,
	if(grouping(produto), 'Total de Todos os Produtos', produto) as produto,
    sum(faturamento) as faturamento
from tb_vendas
group by ano, pais, produto with rollup;
