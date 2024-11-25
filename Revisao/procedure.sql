
-- 1. Procedure com IN
-- Crie uma procedure que receba o ID de um produto e o novo preço de venda. A procedure deve atualizar o preço de venda na tabela PRODUTOS.

DELIMITER $$
CREATE PROCEDURE atualiza_preco_produto(IN idProduto INT, IN novoPrecoVenda DOUBLE)
BEGIN

UPDATE PRODUTOS AS P
SET preco_venda = novoPrecoVenda
WHERE P.idProduto = idProduto;

END $$
DELIMITER ;

call atualiza_preco_produto(1,25);



-- 2. Procedure com OUT
-- Crie uma procedure que conte o total de produtos em estoque e retorne esse valor em uma variável de saída.

DELIMITER $$
CREATE PROCEDURE countTotalEstoque(OUT totalEstoque INT)
BEGIN

SET totalEstoque = (SELECT SUM(quantidade) FROM PRODUTOS);

END $$
DELIMITER ;

call countTotalEstoque(@totalEstoque);
SELECT @totalEstoque;


-- 3. Procedure com IN e OUT
-- Crie uma procedure que receba o ID de uma venda e retorne o status de pagamento associado a ela.

DELIMITER $$
CREATE PROCEDURE statusPagamento(IN idVenda INT, OUT status VARCHAR(50))
BEGIN

SET status = (SELECT statusPagamento FROM VENDAS AS V WHERE V.idVenda = idVenda);

END $$
DELIMITER ;

call statusPagamento(1,@status);
SELECT @status;


