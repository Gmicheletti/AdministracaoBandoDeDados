-- 1. Função: fn_total_vendas_cliente
-- Crie uma função que receba o ID de um cliente e retorne o total de vendas realizadas por ele.
-- Exemplo de Uso: SELECT fn_total_vendas_cliente(1);

DELIMITER $$
 CREATE FUNCTION fn_total_vendas_cliente(idCliente INT)
 RETURNS INT DETERMINISTIC
 BEGIN
 
 DECLARE result INT;
 
 SET result = (SELECT COUNT(idVenda) FROM VENDAS AS V
                WHERE V.fkCliente = idCliente);
 
 RETURN result;
 
 END $$
 DELIMITER ;
 SELECT fn_total_vendas_cliente(2)

-- 2. Função: fn_calcular_estoque_total
-- Crie uma função que retorne o valor total do estoque (quantidade disponível × preço de compra de todos os produtos).
-- Exemplo de Uso: SELECT fn_calcular_estoque_total();

DELIMITER $$
CREATE FUNCTION fn_calcular_estoque_total()
RETURNS INT DETERMINISTIC
BEGIN

DECLARE result INT;

SET result = (SELECT SUM(quantidade * preco_compra) FROM PRODUTOS);

RETURN result;

END $$
DELIMITER ;

SELECT fn_calcular_estoque_total();

-- 3. Função: fn_lucro_produto
-- Crie uma função que receba o ID de um produto e calcule o lucro bruto por unidade vendida (preço de venda - preço de compra).
-- Exemplo de Uso: SELECT fn_lucro_produto(3);

DELIMITER $$
CREATE FUNCTION fn_lucro_produto(idProduto INT)
RETURNS DOUBLE DETERMINISTIC 
BEGIN
DECLARE result DOUBLE;

SET result = (SELECT preco_venda - preco_compra FROM PRODUTOS AS P
                WHERE P.idProduto = idProduto);

RETURN result;

END $$
DELIMITER ;

SELECT fn_lucro_produto(3);

-- 4. Função: fn_quantidade_produtos_vendidos
-- Crie uma função que receba o ID de um produto e retorne a quantidade total vendida dele.
-- Exemplo de Uso: SELECT fn_quantidade_produtos_vendidos(5);

DELIMITER $$
CREATE FUNCTION fn_quantidade_produtos_vendidos(idProduto INT)
RETURNS INT DETERMINISTIC
BEGIN

DECLARE result INT;

SET result = (SELECT SUM(quantidade) FROM ITENS_VENDA AS IV
                WHERE IV.fkProdutos = idProduto);

RETURN result;

END $$
DELIMITER ;

SELECT fn_quantidade_produtos_vendidos(5);

-- 5. Função: fn_status_pagamento
-- Crie uma função que receba o ID de uma venda e retorne se o pagamento está "Pago" ou "Pendente".
-- Exemplo de Uso: SELECT fn_status_pagamento(8);

DELIMITER $$
CREATE FUNCTION fn_status_pagamento(idVenda INT)
RETURNS VARCHAR(50) DETERMINISTIC 
BEGIN

DECLARE result VARCHAR(50);

SET result = (SELECT statusPagamento FROM VENDAS AS V
                WHERE V.idVenda = idVenda);

RETURN result;
END $$
DELIMITER ;
SELECT fn_status_pagamento(8);

-- 6. Função: fn_categoria_cliente
-- Crie uma função que receba o ID de um cliente e retorne sua categoria (bronze, prata ou ouro).
-- Exemplo de Uso: SELECT fn_categoria_cliente(2);

DELIMITER $$
CREATE FUNCTION fn_categoria_cliente(idCliente INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN

DECLARE result VARCHAR(50);

SET result = (SELECT categoria FROM CLIENTES AS C
                WHERE C.idCliente = idCliente);

RETURN result;
END $$
DELIMITER ;

SELECT fn_categoria_cliente(2);

-- 7. Função: fn_total_vendas_data
-- Crie uma função que receba uma data como parâmetro e retorne o valor total de vendas realizadas nesse dia.
-- Exemplo de Uso: SELECT fn_total_vendas_data('2024-11-15');

DELIMITER $$
CREATE FUNCTION fn_total_vendas_data(dataVenda DATE)
RETURNS DOUBLE DETERMINISTIC
BEGIN

DECLARE result DOUBLE;

SET result = (SELECT SUM(totalVenda) FROM VENDAS AS V
                WHERE V.dataVenda = dataVenda);

RETURN result;
END $$
DELIMITER ;

SELECT fn_total_vendas_data('2024-11-15');

-- 8. Função: fn_produtos_em_falta
-- Crie uma função que retorne o número de produtos com quantidade em estoque igual a zero.
-- Exemplo de Uso: SELECT fn_produtos_em_falta();

DELIMITER $$
CREATE FUNCTION fn_produtos_em_falta()
RETURNS INT DETERMINISTIC
BEGIN

DECLARE result INT;

SET result = (SELECT COUNT(idProduto) FROM PRODUTOS AS P
                WHERE P.quantidade = 0);

RETURN result;

END $$
DELIMITER ;
SELECT fn_produtos_em_falta();

-- 9. Função: fn_vendas_por_estado
-- Crie uma função que receba o nome de um estado e retorne o valor total de vendas realizadas para clientes desse estado.
-- Exemplo de Uso: SELECT fn_vendas_por_estado('São Paulo');

DELIMITER $$
CREATE FUNCTION fn_vendas_por_estado(estado VARCHAR(50))
RETURNS DOUBLE DETERMINISTIC
BEGIN

DECLARE result DOUBLE;

SET result = (SELECT SUM(V.totalVenda) FROM VENDAS AS V 
                INNER JOIN CLIENTES AS C
                ON V.fkCliente = C.idCliente
                WHERE C.estado = estado);

RETURN result;


END $$
DELIMITER ;

SELECT fn_vendas_por_estado('São Paulo');


-- 10. Função: fn_produto_mais_vendido
-- Crie uma função que retorne o nome do produto mais vendido até agora.
-- Exemplo de Uso:SELECT fn_produto_mais_vendido();

DELIMITER $$
CREATE FUNCTION fn_produto_mais_vendido()
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN

DECLARE result VARCHAR(50);

SET result = (SELECT P.nome FROM PRODUTOS AS P
				INNER JOIN ITENS_VENDA AS IV
                ON P.idProduto = IV.fkProdutos
                GROUP BY P.idProduto
                ORDER BY SUM(IV.quantidade) DESC
                LIMIT 1
                );

RETURN result;

END $$
DELIMITER ;

SELECT fn_produto_mais_vendido();