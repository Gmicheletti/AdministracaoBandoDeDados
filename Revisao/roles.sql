-- Exercício 1: Role para Gerente de Vendas
-- Crie uma role chamada GerenteVendas que conceda as seguintes permissões:
    -- Inserir, atualizar e visualizar registros na tabela VENDAS.
    -- Inserir e visualizar registros na tabela ITENS_VENDA.
    -- Visualizar registros nas tabelas PRODUTOS e CLIENTES.

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
-------------------------------------------------------------------------------


-- Exercício 2: Role para Analista de Estoque
-- Crie uma role chamada AnalistaEstoque com as seguintes permissões:
    -- Visualizar e atualizar registros na tabela PRODUTOS.
    -- Inserir registros na tabela ITENS_VENDA.
    -- Visualizar registros na tabela VENDAS.

    CREATE ROLE 'AnalistaEstoque'@'Localhost';
    GRANT SELECT, UPDATE ON lojaLG.PRODUTOS TO 'AnalistaEstoque'@'Localhost';
    GRANT INSERT ON lojaLG.ITENS_VENDA TO 'AnalistaEstoque'@'Localhost';
    GRANT SELECT ON lojaLG.VENDAS TO 'AnalistaEstoque'@'Localhost';
    SHOW GRANTS FOR 'AnalistaEstoque'@'Localhost';

-- Atribua essa role a um usuário chamado analista_estoque.
    CREATE USER 'Jefferson'@'Localhost' IDENTIFIED BY RANDOM PASSWORD;
    GRANT 'AnalistaEstoque'@'Localhost' TO 'Jefferson'@'Localhost';
    SET DEFAULT ROLE 'AnalistaEstoque'@'Localhost' TO 'Jefferson'@'Localhost';
    SHOW GRANTS FOR 'Jefferson'@'Localhost';

    -- REMOVER PERMISSAO
    REVOKE 'AnalistaEstoque'@'Localhost' FROM 'Jefferson'@'Localhost';


-------------------------------------------------------------------------------


-- Exercício 3: Role para Auditor
-- Crie uma role chamada Auditor que tenha apenas permissões de leitura:
    -- Visualizar todos os registros de todas as tabelas do banco de dados.

    CREATE ROLE Auditor;
    GRANT ALL ON LojaLG.* TO Auditor;
    SHOW GRANTS FOR Auditor;

-- Atribua essa role a um usuário chamado auditor_sistema.
    CREATE USER 'Marcelo' IDENTIFIED BY 'root123';
    GRANT Auditor TO 'Marcelo';
    SET DEFAULT ROLE Auditor TO 'Marcelo';
    SHOW GRANTS FOR 'Marcelo';

-- REMOVER PERMISSAO
    REVOKE Auditor FROM 'Marcelo';