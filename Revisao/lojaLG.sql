CREATE SCHEMA IF NOT EXISTS LojaLG;

USE LojaLG;

-- CRIA AS TABELAS --

CREATE TABLE IF NOT EXISTS PRODUTOS(
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    preco_compra DOUBLE NOT NULL,
    preco_venda DOUBLE NOT NULL,
    quantidade INT NOT NULL
);

CREATE TABLE IF NOT EXISTS CLIENTES(
	idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    idade INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS VENDAS(
	idVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dataVenda DATE NOT NULL,
    totalVenda DOUBLE NOT NULL,
    fkCliente INT NOT NULL,
    statusPagamento VARCHAR(50) NOT NULL,
    FOREIGN KEY (fkCliente) REFERENCES CLIENTES(idCliente)
);

CREATE TABLE IF NOT EXISTS ITENS_VENDA(
	idItemVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fkVendas INT NOT NULL,
    fkProdutos INT NOT NULL,
    quantidade INT NOT NULL,
    valorUnitario DOUBLE NOT NULL,
    valorTotal DOUBLE NOT NULL,
    
    FOREIGN KEY (fkProdutos) REFERENCES PRODUTOS(idProduto),
    FOREIGN KEY (fkVendas) REFERENCES VENDAS(idVenda)
);


-- CRIA OS ITENS NO BANCO -- 

INSERT INTO PRODUTOS (nome, preco_compra, preco_venda, quantidade)
VALUES 
('Arroz Tio João', 20.00, 25.00, 50),
('Feijão Camil', 15.00, 20.00, 40),
('Açúcar União', 10.00, 12.00, 60),
('Café Pilão', 8.00, 10.00, 80),
('Óleo de Soja Soya', 7.50, 9.00, 100),
('Leite Parmalat', 4.00, 5.50, 70),
('Pão de Forma Wickbold', 10.00, 12.00, 50),
('Margarina Qualy', 6.00, 7.50, 90),
('Refrigerante Coca-Cola 2L', 9.00, 12.00, 120),
('Biscoito Trakinas', 3.00, 4.50, 150),
('Macarrão Renata', 4.50, 6.00, 60),
('Molho de Tomate Pomarola', 3.50, 5.00, 70),
('Sabão em Pó Omo', 15.00, 20.00, 50),
('Detergente Ypê', 2.00, 3.00, 80),
('Desinfetante Veja', 5.00, 6.50, 90),
('Papel Higiênico Neve', 18.00, 22.00, 40),
('Shampoo Seda', 10.00, 12.00, 30),
('Condicionador Seda', 10.00, 12.00, 30),
('Sabonete Dove', 2.50, 4.00, 100),
('Escova de Dentes Oral-B', 6.00, 7.50, 60),
('Creme Dental Colgate', 3.00, 4.50, 80),
('Arroz Integral Tio João', 22.00, 28.00, 40),
('Suco Tang', 1.50, 2.50, 200),
('Achocolatado Nescau', 8.00, 10.00, 60),
('Iogurte Danone', 2.50, 4.00, 80),
('Queijo Polenghi', 5.00, 6.50, 50),
('Presunto Sadia', 15.00, 18.00, 40),
('Manteiga Aviação', 18.00, 22.00, 30),
('Cereal Nesfit', 12.00, 15.00, 50),
('Água Mineral Bonafont 1,5L', 3.00, 4.50, 100);


INSERT INTO CLIENTES (nome, idade, categoria, estado)
VALUES 
('Anitta', 30, 'Ouro', 'Rio de Janeiro'),
('Neymar Jr.', 32, 'Prata', 'São Paulo'),
('Bruna Marquezine', 29, 'Bronze', 'Rio de Janeiro'),
('Ivete Sangalo', 52, 'Ouro', 'Bahia'),
('Gusttavo Lima', 35, 'Ouro', 'Goiás'),
('Juliette Freire', 34, 'Prata', 'Paraíba'),
('Paulo Gustavo', 42, 'Ouro', 'Rio de Janeiro'),
('Larissa Manoela', 23, 'Prata', 'Paraná'),
('Whindersson Nunes', 29, 'Bronze', 'Piauí'),
('Alok', 32, 'Prata', 'Distrito Federal');


INSERT INTO VENDAS (dataVenda, totalVenda, fkCliente, statusPagamento)
VALUES 
('2024-11-01', 30.00, 1, 'Pago'),
('2024-11-02', 50.00, 2, 'Pendente'),
('2024-11-03', 75.00, 3, 'Pago'),
('2024-11-04', 100.00, 4, 'Pago'),
('2024-11-05', 120.00, 5, 'Pendente'),
('2024-11-06', 45.00, 6, 'Pago'),
('2024-11-07', 65.00, 7, 'Pago'),
('2024-11-08', 90.00, 8, 'Pendente'),
('2024-11-09', 110.00, 9, 'Pago'),
('2024-11-10', 25.00, 10, 'Pago'),
('2024-11-11', 80.00, 1, 'Pago'),
('2024-11-12', 60.00, 2, 'Pendente'),
('2024-11-13', 85.00, 3, 'Pago'),
('2024-11-14', 95.00, 4, 'Pago'),
('2024-11-15', 130.00, 5, 'Pendente'),
('2024-11-16', 70.00, 6, 'Pago'),
('2024-11-17', 55.00, 7, 'Pago'),
('2024-11-18', 105.00, 8, 'Pendente'),
('2024-11-19', 40.00, 9, 'Pago'),
('2024-11-20', 120.00, 10, 'Pago');


INSERT INTO ITENS_VENDA (fkVendas, fkProdutos, quantidade, valorUnitario, valorTotal)
VALUES 
(1, 1, 2, 15.00, 30.00),
(2, 2, 2, 25.00, 50.00),
(10, 4, 1, 25.00, 25.00),
(19, 10, 2, 20.00, 40.00);
(5, 3, 1, 35.00, 35.00),
(5, 4, 2, 20.00, 40.00),
(5, 5, 1, 20.00, 20.00),
(5, 6, 1, 25.00, 25.00),
(15, 8, 1, 15.00, 15.00),
(15, 9, 2, 10.00, 20.00),
(15, 10, 1, 25.00, 25.00),
(15, 11, 2, 10.00, 20.00),
(4, 5, 2, 20.00, 40.00),
(4, 6, 1, 30.00, 30.00),
(4, 9, 3, 10.00, 30.00),
(14, 12, 1, 35.00, 35.00),
(14, 15, 2, 30.00, 60.00),
(14, 17, 1, 25.00, 25.00),
(3, 3, 1, 35.00, 35.00),
(3, 4, 2, 20.00, 40.00),
(6, 8, 3, 15.00, 45.00),
(11, 7, 2, 30.00, 60.00);


















------------------------------OUTROS-------------------------------

CREATE SCHEMA IF NOT EXISTS LojaLG;

USE LojaLG;

CREATE TABLE IF NOT EXISTS ITENS_VENDA(
	idItemVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fkVendas INT NOT NULL,
    fkProdutos INT NOT NULL,
    quantidade INT NOT NULL,
    valorUnitario DOUBLE NOT NULL,
    valorTotal DOUBLE NOT NULL,
    
    FOREIGN KEY (fkProdutos) REFERENCES PRODUTOS(idProduto),
    FOREIGN KEY (fkVendas) REFERENCES VENDAS(idVenda)
);


INSERT INTO PRODUTOS (nome, preco_compra, preco_venda, quantidade)
VALUES 
('Arroz Tio João', 20.00, 25.00, 50),
('Feijão Camil', 15.00, 20.00, 40);


------------------------------VIEW-------------------------------

CREATE OR REPLACE VIEW vw_total_vendas_por_cliente AS
SELECT C.nome, SUM(V.totalVenda) FROM CLIENTES AS C
INNER JOIN VENDAS AS V
ON V.fkCliente = C.idCliente
GROUP BY C.nome;
SELECT * FROM vw_total_vendas_por_cliente;


------------------------------FUNCTION-------------------------------

DELIMITER -$-$
 CREATE FUNCTION fn_total_vendas_cliente(idCliente INT)
 RETURNS INT DETERMINISTIC
 BEGIN
 
 DECLARE result INT;
 
 SET result = (SELECT COUNT(idVenda) FROM VENDAS AS V
                WHERE V.fkCliente = idCliente);
 
 RETURN result;
 
 END -$-$
 DELIMITER -;
 SELECT fn_total_vendas_cliente(2)

------------------------------PROCEDURE-------------------------------

DELIMITER -$-$
CREATE PROCEDURE statusPagamento(IN idVenda INT, OUT status VARCHAR(50))
BEGIN

SET status = (SELECT statusPagamento FROM VENDAS AS V WHERE V.idVenda = idVenda);

END -$-$
DELIMITER -;

call statusPagamento(1,@status);
SELECT @status;

------------------------------TRIGGER-------------------------------

DELIMITER -$-$
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

END -$-$
DELIMITER -;

INSERT INTO ITENS_VENDA (fkVendas, fkProdutos, quantidade, valorUnitario, valorTotal) VALUES  (1, 1, 52, 15.00, 30.00);
INSERT INTO ITENS_VENDA (fkVendas, fkProdutos, quantidade, valorUnitario, valorTotal) VALUES  (1, 1, 2, 15.00, 30.00);

------------------------------INDEXES-------------------------------

CREATE INDEX itens_venda_fks ON ITENS_VENDA(fkVendas, fkProdutos);

CREATE UNIQUE INDEX nome_preco_uniq ON PRODUTOS(nome, preco_compra); 

DROP INDEX idx_dataVenda ON VENDAS;

SHOW INDEX FROM ITENS_VENDA;

EXPLAIN SELECT * FROM PRODUTOS WHERE nome = 'Tio João';

------------------------------ROLES-------------------------------

    CREATE ROLE 'GerenteVendas'@'%';
    GRANT INSERT, UPDATE, SELECT ON lojaLG.VENDAS TO 'GerenteVendas'@'%';
    GRANT INSERT, SELECT ON lojaLG.ITENS_VENDA TO 'GerenteVendas'@'%';
    GRANT SELECT ON lojaLG.PRODUTOS TO 'GerenteVendas'@'%';
    GRANT SELECT ON lojaLG.CLIENTES TO 'GerenteVendas'@'%';
    SHOW GRANTS FOR 'GerenteVendas'@'%';

    SELECT * FROM mysql.user;

-- Após criar a role, atribua-a a um usuário chamado gerente_vendas.

    CREATE USER 'Lucas'@'%' IDENTIFIED BY '123456';
    GRANT 'GerenteVendas'@'%' TO 'Lucas'@'%';
    SET DEFAULT ROLE 'GerenteVendas'@'%' TO 'Lucas'@'%';
    SHOW GRANTS FOR 'Lucas'@'%';


-- REMOVER PERMISSAO
    REVOKE 'GerenteVendas'@'%' FROM 'Lucas'@'%';