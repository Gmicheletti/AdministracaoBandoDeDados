-- Exercício 1: Role para Gerente de Vendas
-- Crie uma role chamada GerenteVendas que conceda as seguintes permissões:
    -- Inserir, atualizar e visualizar registros na tabela VENDAS.
    -- Inserir e visualizar registros na tabela ITENS_VENDA.
    -- Visualizar registros nas tabelas PRODUTOS e CLIENTES.

-- Após criar a role, atribua-a a um usuário chamado gerente_vendas.

-------------------------------------------------------------------------------


-- Exercício 2: Role para Analista de Estoque
-- Crie uma role chamada AnalistaEstoque com as seguintes permissões:
    -- Visualizar e atualizar registros na tabela PRODUTOS.
    -- Inserir registros na tabela ITENS_VENDA.
    -- Visualizar registros na tabela VENDAS.
-- Atribua essa role a um usuário chamado analista_estoque.

-------------------------------------------------------------------------------


-- Exercício 3: Role para Auditor
-- Crie uma role chamada Auditor que tenha apenas permissões de leitura:
    -- Visualizar todos os registros de todas as tabelas do banco de dados.
-- Atribua essa role a um usuário chamado auditor_sistema.