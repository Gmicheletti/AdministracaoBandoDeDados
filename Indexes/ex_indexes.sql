-- Crie uma tabela de log no loja informatica, com as colunas:
-- id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, extra

CREATE TABLE IF NOT EXISTS LOG_LOJA(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    select_type TEXT NULL,
    table_ TEXT,
    partitions TEXT,
    type_ TEXT,
    possible_keys TEXT, 
    key_ TEXT,
    key_len TEXT,
    ref TEXT,
    rows_ TEXT,
    filtered TEXT,
    extra TEXT
)



-- Crie 10 selects, um desses deve ser um join
-- _____1
SELECT nome, cpf, email, telefone, limiteCredito FROM clientes WHERE limiteCredito >= 5000;

-- _____2
SELECT COUNT(tipo) FROM produtos WHERE tipo = 'Calçado';

-- _____3
SELECT * FROM produtos WHERE tipo = 'Roupa';

-- _____4
SELECT * FROM produtos WHERE estoque <= 5;

-- _____5
SELECT descricao, (precoVenda - precoCompra) AS lucro FROM produtos;

-- _____6
SELECT * FROM produtos WHERE descricao LIKE '%Nike%';

-- _____7
SELECT descricao, tipo, estoque, nome FROM produtos AS P 
JOIN fornecedores AS F 
ON P.fk_id_fornecedor = F.idFornecedor
WHERE F.nome = 'Bolas Brasil';

-- _____8
SELECT nome, email, telefone FROM clientes AS C
JOIN enderecos AS E
ON C.fk_id_endereco = E.idEndereco
WHERE E.bairro = 'Centro';

-- _____9
SELECT descricao FROM pedidos AS P
JOIN itemspedidos AS IP 
ON IP.fk_id_Pedido = P.idPedido
JOIN produtos AS PRO
ON IP.fk_id_Produto = PRO.idProduto
WHERE P.idPedido = 3;

-- _____10
SELECT descricao, nome FROM produtos AS P
JOIN fornecedores AS F
ON P.fk_id_fornecedor = F.idFornecedor
WHERE F.idFornecedor = 2;





-- Crie 15 indices nas tabelas
-- _____1
CREATE INDEX clietes_limiteCredito on clientes(limiteCredito ASC);

-- _____2
CREATE INDEX endereco_cep  on enderecos(cep ASC);

-- _____3
CREATE FULLTEXT INDEX clientes_nome on clientes(nome ASC);

-- _____4
CREATE FULLTEXT INDEX endereco_bairro on enderecos(bairro ASC);

-- _____5
CREATE FULLTEXT INDEX endereco_cidade on enderecos(cidade ASC);

-- _____6
CREATE FULLTEXT INDEX endereco_estado on enderecos(estado ASC);

-- _____7
CREATE INDEX produtos_tipo on produtos(tipo ASC);

-- _____8
CREATE INDEX produtos_estoque on produtos(estoque ASC);

-- _____9
CREATE FULLTEXT INDEX produtos_descricao on produtos(descricao ASC);

-- _____10
CREATE INDEX produtos_precoCompra on produtos(precoCompra ASC);

-- _____11
CREATE INDEX produtos_precoVenda on produtos(precoVenda ASC);

-- _____12
CREATE INDEX pedidos_dataPedido on pedidos(dataped ASC);

-- _____13
CREATE INDEX pedidos_valorTotoalPedido on pedidos(valorTotalPedido ASC);

-- _____14
CREATE INDEX itemspedidos_quantidade on itemspedidos(quantidade ASC);

-- _____15
CREATE FULLTEXT INDEX fornecedores_nome on fornecedores(nome ASC);



-- Ela deve receber os valores que o explain gera em cada select


-- # id, select_type, table_, partitions, type_, possible_keys, key_, key_len, ref, rows_, filtered, extra
-- #'1', 'SIMPLE', 'clientes', NULL, 'ALL', 'clietes_limiteCredito', NULL, NULL, NULL, '5', '60.00', 'Using where'
-- #'1', 'SIMPLE', 'produtos', NULL, 'ref', 'produtos_tipo', 'produtos_tipo', '202', 'const', '5', '100.00', 'Using index'
-- #'1', 'SIMPLE', 'produtos', NULL, 'ref', 'produtos_tipo', 'produtos_tipo', '202', 'const', '4', '100.00', NULL
-- #'1', 'SIMPLE', 'produtos', NULL, 'range', 'produtos_estoque', 'produtos_estoque', '4', NULL, '4', '100.00', 'Using index condition'
-- #'1', 'SIMPLE', 'produtos', NULL, 'ALL', NULL, NULL, NULL, NULL, '15', '100.00', NULL
-- #'1', 'SIMPLE', 'produtos', NULL, 'ALL', NULL, NULL, NULL, NULL, '15', '11.11', 'Using where'
-- #'1', 'SIMPLE', 'F', NULL, 'ALL', 'PRIMARY,fornecedores_nome', NULL, NULL, NULL, '3', '33.33', 'Using where'
-- #'1', 'SIMPLE', 'P', NULL, 'ref', 'produtos_fornecedores', 'produtos_fornecedores', '4', 'loja_online.F.idFornecedor', '5', '100.00', NULL
-- #'1', 'SIMPLE', 'E', NULL, 'ALL', 'PRIMARY,endereco_bairro', NULL, NULL, NULL, '10', '10.00', 'Using where'
-- #'1', 'SIMPLE', 'C', NULL, 'ref', 'fk_id_endereco', 'fk_id_endereco', '4', 'loja_online.E.idEndereco', '1', '100.00', NULL
-- #'1', 'SIMPLE', 'P', NULL, 'const', 'PRIMARY', 'PRIMARY', '4', 'const', '1', '100.00', 'Using index'
-- #'1', 'SIMPLE', 'IP', NULL, 'ref', 'itemspedidos_ibfk_1,itemspedidos_ibfk_2', 'itemspedidos_ibfk_1', '4', 'const', '2', '100.00', NULL
-- #'1', 'SIMPLE', 'PRO', NULL, 'eq_ref', 'PRIMARY', 'PRIMARY', '4', 'loja_online.IP.fk_id_Produto', '1', '100.00', NULL
-- #'1', 'SIMPLE', 'F', NULL, 'const', 'PRIMARY', 'PRIMARY', '4', 'const', '1', '100.00', NULL
-- #'1', 'SIMPLE', 'P', NULL, 'ref', 'produtos_fornecedores', 'produtos_fornecedores', '4', 'const', '6', '100.00', NULL



INSERT INTO LOG_LOJA(select_type, table_, partitions, type_, possible_keys, key_, key_len, ref, rows_, filtered, Extra) VALUES
('SIMPLE', 'clientes', NULL, 'ALL', 'clietes_limiteCredito', NULL, NULL, NULL, '5', '60.00', 'Using where'),
('SIMPLE', 'produtos', NULL, 'ref', 'produtos_tipo', 'produtos_tipo', '202', 'const', '5', '100.00', 'Using index'),
('SIMPLE', 'produtos', NULL, 'ref', 'produtos_tipo', 'produtos_tipo', '202', 'const', '4', '100.00', NULL),
('SIMPLE', 'produtos', NULL, 'range', 'produtos_estoque', 'produtos_estoque', '4', NULL, '4', '100.00', 'Using index condition'),
('SIMPLE', 'produtos', NULL, 'ALL', NULL, NULL, NULL, NULL, '15', '100.00', NULL),
('SIMPLE', 'produtos', NULL, 'ALL', NULL, NULL, NULL, NULL, '15', '11.11', 'Using where'),
('SIMPLE', 'F', NULL, 'ALL', 'PRIMARY,fornecedores_nome', NULL, NULL, NULL, '3', '33.33', 'Using where'),
('SIMPLE', 'P', NULL, 'ref', 'produtos_fornecedores', 'produtos_fornecedores', '4', 'loja_online.F.idFornecedor', '5', '100.00', NULL),
('SIMPLE', 'E', NULL, 'ALL', 'PRIMARY,endereco_bairro', NULL, NULL, NULL, '10', '10.00', 'Using where'),
('SIMPLE', 'C', NULL, 'ref', 'fk_id_endereco', 'fk_id_endereco', '4', 'loja_online.E.idEndereco', '1', '100.00', NULL),
('SIMPLE', 'P', NULL, 'const', 'PRIMARY', 'PRIMARY', '4', 'const', '1', '100.00', 'Using index'),
('SIMPLE', 'IP', NULL, 'ref', 'itemspedidos_ibfk_1,itemspedidos_ibfk_2', 'itemspedidos_ibfk_1', '4', 'const', '2', '100.00', NULL),
('SIMPLE', 'PRO', NULL, 'eq_ref', 'PRIMARY', 'PRIMARY', '4', 'loja_online.IP.fk_id_Produto', '1', '100.00', NULL),
('SIMPLE', 'F', NULL, 'const', 'PRIMARY', 'PRIMARY', '4', 'const', '1', '100.00', NULL),
('SIMPLE', 'P', NULL, 'ref', 'produtos_fornecedores', 'produtos_fornecedores', '4', 'const', '6', '100.00', NULL);