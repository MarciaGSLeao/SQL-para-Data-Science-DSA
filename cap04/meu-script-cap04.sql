# Retornar id do pedido e nome do cliente
# 1ª forma
SELECT id_pedido, nome_cliente
FROM tb_pedidos AS P
INNER JOIN tb_clientes AS C -- Inner Join ou apenas Join se refere à interseção
ON C.id_cliente = P.id_cliente;

SELECT id_pedido, nome_cliente
FROM tb_pedidos AS P
JOIN tb_clientes AS C
USING (id_cliente);

# 2ª forma
SELECT P.id_pedido, C.nome_cliente
FROM tb_pedidos P, tb_clientes C
WHERE C.id_cliente = P.id_cliente;

# Retornar id do pedido, nome do cliente e nome do vendedor
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM tb_pedidos P, tb_clientes C, tb_vendedor V
WHERE C.id_cliente = P.id_cliente AND P.id_vendedor = V.id_vendedor;

# Retornar todos os clientes, com ou sem pedido associado
# Left Join - indica que queremos todos os dados da tabela da esquerda mesmo sem correspondencia na tabela da direita
SELECT C.nome_cliente, P.id_pedido
FROM tb_clientes c
LEFT JOIN tb_pedidos p
on c.id_cliente = p.id_cliente;

SELECT C.nome_cliente, 
	CASE
		WHEN P.id_pedido IS NULL THEN '0'
        ELSE id_pedido
	END AS 'id_pedido'
FROM tb_clientes c LEFT JOIN tb_pedidos p
ON c.id_cliente = p.id_cliente
ORDER BY id_pedido;

# Retornar todos os clientes, com ou sem pedido associado
# Right Join - indica que queremos todos os dados da tabela da esquerda mesmo sem correspondencia na tabela da direita
SELECT C.nome_cliente, P.id_pedido
FROM tb_pedidos p
RIGHT JOIN tb_clientes c
on c.id_cliente = p.id_cliente;

SELECT C.nome_cliente, 
	CASE
		WHEN P.id_pedido IS NULL THEN '0'
        ELSE id_pedido
	END AS 'id_pedido'
FROM tb_pedidos p RIGHT JOIN tb_clientes c
ON c.id_cliente = p.id_cliente
ORDER BY id_pedido;

# Retornar a data do pedido, o nome do cliente, todos os vendedores, com ou sem pedido associado, e ordenar o resultado pelo nome do cliente.
SELECT P.DATA_PEDIDO, V.NOME_VENDEDOR
FROM tb_pedidos P RIGHT JOIN tb_vendedor V
ON P.id_vendedor = V.id_vendedor;

SELECT 
	CASE 
		WHEN P.DATA_PEDIDO IS NULL THEN 'S/P'
        ELSE P.DATA_PEDIDO
	END AS DATA_PEDIDO,
    CASE
		WHEN C.NOME_CLIENTE IS NULL THEN 'S/P'
        ELSE C.NOME_CLIENTE
	END AS NOME_CLIENTE, 
    V.NOME_VENDEDOR
FROM tb_pedidos P RIGHT JOIN tb_vendedor V
ON P.id_vendedor = V.id_vendedor
LEFT JOIN TB_CLIENTES C
ON C.id_cliente = P.id_cliente
ORDER BY C.NOME_CLIENTE;
