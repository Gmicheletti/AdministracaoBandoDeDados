CREATE OR REPLACE VIEW view_clientesOuro AS
SELECT * FROM CLIENTES
WHERE categoria = 'Ouro';
SELECT * FROM view_clientesOuro;

CREATE OR REPLACE VIEW view_clientesPrata AS
SELECT * FROM CLIENTES
WHERE categoria = 'Prata';
SELECT * FROM view_clientesPrata;

CREATE OR REPLACE VIEW view_clientesBronze AS
SELECT * FROM CLIENTES
WHERE categoria = 'Bronze';
SELECT * FROM view_clientesBronze;

-- 1. View: vw_total_vendas_por_cliente
-- Mostra o total de vendas realizadas por cada cliente.
-- Colunas: nome_cliente, total_vendas.

CREATE OR REPLACE VIEW vw_total_vendas_por_cliente AS
SELECT C.nome, SUM(V.totalVenda) FROM CLIENTES AS C
INNER JOIN VENDAS AS V
ON V.fkCliente = C.idCliente
GROUP BY C.nome;
SELECT * FROM vw_total_vendas_por_cliente;

-- 2. View: vw_vendas_detalhadas
-- Exibe os detalhes de cada venda, incluindo cliente, data, total da venda e status de pagamento.
-- Colunas: id_venda, data_venda, nome_cliente, total_venda, status_pagamento.

CREATE OR REPLACE VIEW vw_vendas_detalhadas AS
SELECT V.idvenda, V.dataVenda, C.nome, V.totalVenda, V.statusPagamento FROM CLIENTES AS C
INNER JOIN VENDAS AS V
ON V.fkCliente = C.idCliente;
SELECT * FROM vw_vendas_detalhadas;

-- 3. View: vw_itens_por_venda
-- Lista os itens vendidos em cada venda, com quantidade e valor total de cada item.
-- Colunas: id_venda, produto, quantidade, valor_unitario, valor_total_item.

CREATE OR REPLACE VIEW vw_itens_por_venda AS
SELECT IV.fkVendas, P.nome, IV.quantidade, IV.valorUnitario, IV.valorTotaL FROM ITENS_VENDA AS IV
INNER JOIN PRODUTOS AS P
ON P.idProduto = IV.fkProdutos
ORDER BY IV.fkVendas;
SELECT * FROM vw_itens_por_venda;

-- 4. View: vw_estoque_produtos
-- Mostra a situação atual do estoque de produtos, com quantidade disponível e valor estimado total (quantidade * preço de venda).
-- Colunas: nome_produto, quantidade_disponivel, valor_total_estoque.

CREATE OR REPLACE VIEW vw_estoque_produtos AS
SELECT P.nome, P.quantidade, P.quantidade * P.preco_venda FROM PRODUTOS AS P
ORDER BY P.quantidade ASC;
SELECT * FROM vw_estoque_produtos;

-- 5. View: vw_vendas_por_estado
-- Agrupa o total de vendas por estado, permitindo analisar o desempenho geográfico.
-- Colunas: estado, total_vendas.

CREATE OR REPLACE VIEW vw_vendas_por_estado AS
SELECT C.estado, COUNT(V.idVenda) AS Count FROM CLIENTES AS C
INNER JOIN VENDAS AS V
ON V.fkCliente = C.idCliente
GROUP BY C.estado
ORDER BY Count DESC;
SELECT * FROM vw_vendas_por_estado;

-- 6. View: vw_clientes_por_categoria
-- Lista os clientes agrupados por suas categorias (bronze, prata, ouro).
-- Colunas: categoria, nome_cliente, estado.

-- 7. View: vw_produtos_mais_vendidos
-- Exibe os produtos mais vendidos, ordenados pela quantidade total vendida.
-- Colunas: nome_produto, quantidade_vendida.

-- 8. View: vw_valor_total_vendas_por_data
-- Mostra o valor total de vendas por data.
-- Colunas: data_venda, valor_total_vendas.

-- 9. View: vw_vendas_pendentes
-- Lista todas as vendas que ainda estão com o status de pagamento pendente.
-- Colunas: id_venda, data_venda, nome_cliente, total_venda.

-- 10. View: vw_lucro_por_produto
-- Calcula o lucro bruto por produto, considerando o preço de compra e o preço de venda.
-- Colunas: nome_produto, lucro_unitario, quantidade_vendida, lucro_total.