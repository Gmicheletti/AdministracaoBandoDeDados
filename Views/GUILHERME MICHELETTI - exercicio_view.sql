# 1 Crie uma view que apresente o total de pedidos do dia 2024-08-21
CREATE OR REPLACE VIEW VEX1 AS
SELECT COUNT(pedidos.idPedido) AS NUMERO_PEDIDOS
FROM pedidos WHERE pedidos.dataped = '2024/08/21';
SELECT * FROM vex1;

# 2 Crie uma view que apresente o total de pedidos já realizados(total)
CREATE OR REPLACE VIEW VEX2 AS
SELECT COUNT(pedidos.idPedido) AS Todos_Pedidos
from pedidos;
SELECT * FROM vex2;

# 3 Crie uma view que apresente o nome dos clientes que ja fizeram um pedido
CREATE OR REPLACE VIEW VEX3 AS
SELECT C.nome
FROM clientes AS C
JOIN pedidos AS P
ON (C.idCliente = P.fk_id_Cliente);
SELECT * FROM VEX3;

# 4 Crie uma view que apresente os produtos que já foram PEDIDOS
CREATE OR REPLACE VIEW VEX4 AS
SELECT PRO.idProduto,PRO.descricao, PRO.tipo, PED.dataped
FROM pedidos AS PED
JOIN itemspedidos AS ITPED
ON (PED.idPedido = ITPED.fk_id_Pedido)
JOIN produtos AS PRO
ON (ITPED.fk_id_Produto = PRO.idProduto);
SELECT * FROM VEX4;

# 5 Crie uma view que apresente o lucro que rendeu um produto qualquer
CREATE OR REPLACE VIEW VEX5 AS
SELECT P.idProduto, P.descricao,
((P.precoVenda - P.precoCompra)*IP.quantidade) AS lucro
FROM PRODUTOS AS P
JOIN ITEMSPEDIDOS AS IP
ON P.idProduto = IP.fk_id_Produto
JOIN PEDIDOS AS PED
ON IP.fk_id_Pedido = PED.idPedido;
SELECT * FROM VEX5;

# 6 Crie uma view que apresente qual o maior pedido em valor
CREATE OR REPLACE VIEW VEX6 AS
SELECT *
FROM PEDIDOS
WHERE valorTotalPedido = (SELECT MAX(valorTotalPedido) FROM PEDIDOS);
SELECT * FROM VEX6;

# 7 Crie uma view que apresente qual o menor pedido em valor
CREATE OR REPLACE VIEW VEX7 AS
SELECT *
FROM PEDIDOS
WHERE valorTotalPedido = (SELECT MIN(valorTotalPedido) FROM PEDIDOS);
SELECT * FROM VEX7;

# 8 Crie uma view que apresente qual o endereco do cliente Teclaudio
CREATE OR REPLACE VIEW VEX8 AS
SELECT Logradouro, numero, complemento, cep, bairro, cidade, estado
FROM ENDERECOS AS END
JOIN CLIENTES AS CLI
ON END.idEndereco = CLI.fk_id_endereco 
WHERE CLI.nome LIKE '%Teclaudio%';
SELECT * FROM VEX8

# 9 Crie uma view que apresente qual endereco dos clientes que ja fizeram compras
CREATE OR REPLACE VIEW VEX9 AS
SELECT CLI.nome, END.Logradouro, END.numero, END.complemento, END.cep, END.bairro, END.cidade, END.estado
FROM ENDERECOS AS END
JOIN CLIENTES AS CLI
ON END.idEndereco = CLI.fk_id_endereco 
JOIN PEDIDOS AS PED
ON CLI.idCliente = PED.fk_id_cliente;
SELECT * FROM VEX9

# 10 Crie uma view que apresente quais pedidos foram pagos em pix
CREATE OR REPLACE VIEW VEX10 AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS AS PED
JOIN PAGAMENTOS AS PAG
ON PED.fk_id_pagamento = PAG.idPagamento 
WHERE PAG.forma_pagamento LIKE '%PIX%';
SELECT * FROM VEX10

# 11 Crie uma view que apresente quais pedidos foram pagos em cartao
CREATE OR REPLACE VIEW VEX11 AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS AS PED
JOIN PAGAMENTOS AS PAG
ON PED.fk_id_pagamento = PAG.idPagamento 
WHERE PAG.forma_pagamento LIKE '%CARTAO_CREDITO%';
SELECT * FROM VEX11

# 12 Crie uma view que apresente quais itens foram pedidos no pedido do Marta Castro
CREATE OR REPLACE VIEW VEX12 AS
SELECT IP.quantidade, PROD.descricao FROM ITEMSPEDIDOS AS IP
JOIN PEDIDOS AS PED
ON IP.fk_id_pedido = PED.idPedido
JOIN PRODUTOS AS PROD
ON IP.fk_id_Produto = PROD.idProduto
JOIN CLIENTES AS CLI
WHERE CLI.nome LIKE '%Marta Castro%';
SELECT * FROM  VEX12

# 13 Crie uma view que apresente qual fornecedor fabricou os produtos do pedido da Helena Carla
CREATE OR REPLACE VIEW VEX13 AS
SELECT FORN.nome, FORN.telefone, FORN.email FROM ITEMSPEDIDOS AS IP
JOIN PEDIDOS AS PED
ON IP.fk_id_pedido = PED.idPedido
JOIN PRODUTOS AS PROD
ON IP.fk_id_Produto = PROD.idProduto
JOIN FORNECEDORES AS FORN
ON PROD.fk_id_fornecedor = FORN.idFornecedor
JOIN CLIENTES AS CLI
WHERE CLI.nome LIKE '%Helena Carla%'
GROUP BY FORN.nome;
SELECT * FROM  VEX13

# 14 Crie uma view que apresente qual o nome do fornecedor que fabrica as Camisas comercializadas pela loja
CREATE OR REPLACE VIEW VEX14 AS
SELECT FORN.nome FROM PRODUTOS AS PROD
JOIN FORNECEDORES AS FORN
ON PROD.fk_id_fornecedor = FORN.idFornecedor
WHERE PROD.descricao LIKE '%Camisa%'
GROUP BY FORN.nome;
SELECT * FROM VEX14

# 15 Crie uma view que apresente qual a quantidade em estoque do produto comprado pela Maria de Almeida
CREATE OR REPLACE VIEW VEX15 AS
SELECT PROD.estoque, PROD.descricao FROM ITEMSPEDIDOS AS IP
JOIN PEDIDOS AS PED
ON IP.fk_id_pedido = PED.idPedido
JOIN PRODUTOS AS PROD
ON IP.fk_id_Produto = PROD.idProduto
JOIN CLIENTES AS CLI
ON PED.fk_id_cliente = CLI.idCliente
WHERE CLI.nome LIKE '%Maria de Almeida%';
SELECT * FROM  VEX15


# 16 Crie uma view que apresente o total de produtos fabricados pela Marte Roupas
CREATE OR REPLACE VIEW VEX16 AS
SELECT COUNT(PROD.idProduto) FROM PRODUTOS AS PROD
JOIN FORNECEDORES AS FORN
WHERE FORN.nome LIKE '%Marte Roupas%';

SELECT * FROM VEX16