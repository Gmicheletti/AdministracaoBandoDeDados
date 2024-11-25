-- Exercício 1: Índice em uma tabela com muitos registros
-- A tabela CLIENTES possui muitos registros e é frequentemente consultada pelo campo estado.
-- Crie um índice no campo estado para melhorar a performance das consultas que filtram clientes por estado.

CREATE INDEX clientes_estado ON CLIENTES(estado ASC);

-- Exercício 2: Índice composto para otimizar buscas
-- A tabela ITENS_VENDA possui os campos fkVendas e fkProdutos.
-- Crie um índice composto para otimizar consultas que frequentemente buscam registros com base nesses dois campos (como consultas que analisam quais produtos foram vendidos em uma venda específica).

CREATE INDEX itens_venda_fks ON ITENS_VENDA(fkVendas, fkProdutos);

-- Exercício 3: Índice único para evitar duplicidade
-- Na tabela PRODUTOS, nenhum produto pode ter o mesmo nome e preco_compra.
-- Crie um índice único que garanta que combinações desses dois campos sejam sempre únicas.

CREATE UNIQUE INDEX nome_preco_uniq ON PRODUTOS(nome, preco_compra); 

-- Exercício 4: Remoção de índices desnecessários
-- Na tabela VENDAS, foi criado um índice no campo dataVenda, mas ele não está sendo utilizado em consultas.
-- Remova o índice chamado idx_dataVenda dessa tabela.

DROP INDEX idx_dataVenda ON VENDAS;


--------- VERIFICAR INDICES CRIADOS ----------
SHOW INDEX FROM ITENS_VENDA;

---------- EXPLAIN ----------
EXPLAIN SELECT * FROM PRODUTOS WHERE nome = 'Tio João';