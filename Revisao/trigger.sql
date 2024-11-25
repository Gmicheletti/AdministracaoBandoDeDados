-- 1. Trigger para Atualizar Estoque Após Venda
-- Crie uma trigger que, ao inserir um novo item na tabela ITENS_VENDA, subtraia a quantidade vendida do estoque correspondente na tabela PRODUTOS.

-- 2. Trigger para Impedir Venda com Estoque Insuficiente
-- Crie uma trigger que impeça a inserção de um item na tabela ITENS_VENDA se a quantidade solicitada for maior do que o estoque disponível na tabela PRODUTOS.

DELIMITER $$
CREATE TRIGGER atualizaEstoque
BEFORE INSERT ON ITENS_VENDA
FOR EACH ROW
BEGIN

DECLARE qtdeProduto INT;

SET qtdeProduto = (SELECT quantidade FROM PRODUTOS AS P
					WHERE P.idProduto = NEW.fkProdutos);

IF(qtdeProduto >= NEW.quantidade) THEN
	UPDATE PRODUTOS
	SET quantidade = qtdeProduto - NEW.quantidade
	WHERE idProduto = NEW.fkProdutos;
ELSE
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente!';
END IF;

END $$
DELIMITER ;

INSERT INTO ITENS_VENDA (fkVendas, fkProdutos, quantidade, valorUnitario, valorTotal) VALUES  (1, 1, 52, 15.00, 30.00);
INSERT INTO ITENS_VENDA (fkVendas, fkProdutos, quantidade, valorUnitario, valorTotal) VALUES  (1, 1, 2, 15.00, 30.00);



-- 3. Trigger para Registrar Mudanças no Status de Pagamento
-- Crie uma trigger que, ao atualizar o campo statusPagamento na tabela VENDAS, registre a alteração em uma tabela de histórico (HISTORICO_PAGAMENTO), com:
-- ID da venda.
-- Status anterior.
-- Novo status.
-- Data e hora da mudança.

CREATE TABLE HISTORICO_PAGAMENTO(
	idHistorico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fkVenda INT NOT NULL,
    statusAnterior VARCHAR(50) NOT NULL,
    statusNovo VARCHAR(50) NOT NULL,
    dataHora DATETIME NOT NULL,
    
    FOREIGN KEY (fkVenda) REFERENCES VENDAS(idVenda)
);


DELIMITER $$
CREATE TRIGGER historicoPagamento
BEFORE UPDATE ON VENDAS
FOR EACH ROW
BEGIN

INSERT HISTORICO_PAGAMENTO(fkVenda, statusAnterior, statusNovo, dataHora)
VALUES(NEW.idVenda, OLD.statusPagamento, NEW.statusPagamento, NOW());

END $$
DELIMITER ;

UPDATE VENDAS AS V SET statusPagamento = 'Pago' WHERE V.idVenda = 2;