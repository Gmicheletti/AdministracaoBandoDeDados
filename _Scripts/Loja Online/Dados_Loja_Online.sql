
INSERT INTO `ENDERECOS` ( `Logradouro`, `numero`, `complemento`, `cep`, `bairro`, `cidade`, `estado`) VALUES
('Rua das flores', 1223, 'Ap 102', 31222255, 'Centro', 'Belo horizonte', 'Mg'),
('Av das Palmeiras', 13, 'Ap 202', 39452275, 'Centro', 'Belo horizonte', 'Mg'),
('Rua Centro Alto', 45, 'Galpao 3', 2122299, 'Londres', 'Betim', 'Mg'),
('Av das Naçoes', 988, 'Loja3', 45343434, 'Centro', 'Contagem', 'Mg'),
('Rua Florentina', 88, 'Ap 301', 319090988, 'Alto Vera', 'Sao Paulo', 'Sp'),
('Av Vargem Grande', 345, 'Q10', 66643434, 'Marcondes', 'Salvador', 'Ba'),
('Av das Graças', 188, 'Loja12', 42323456, 'Centro', 'Rio de Janeiro', 'Mg'),
('Rua dos Lobos', 77, 'AP1002', 51232322, 'Centro', 'Sao Paulo', 'Sp'),
('Av Nacional', 128, 'Galpão 09', 56444342, 'Centro', 'Contagem', 'Mg'),
('Av Miami', 453, 'Loja10', 45345431, 'Centro', 'Belo Horizonte', 'Mg');

INSERT INTO `CLIENTES` ( `nome`, `email`, `cpf`, `telefone`, `limiteCredito`,`fk_id_endereco`) VALUES
('Marta Castro', 'mcastro@gmail.com', '68637571255', '3193324422', 4000,1),
('Maria de Almeida', 'almeidam@gmail.com', '14496682320', '31972344312', 4500,2),
('Helena Carla', 'hcarla2@gmail.com', '44637478723', '31932422121', 5000,3),
('Jorge Mario', 'jmjm@gmail.com', '81262962323', '31909877678', 5000,4),
('Tecláudio Screen', 'teclas@gmail.com', '87181183052', '31952133212', 8000,5);


INSERT INTO `FORNECEDORES` (`nome`, `cnpj`, `inscE`, `telefone`, `email`,`fk_id_endereco`) VALUES
('Marte Roupas', 2332222230001, '1234323296', '31983233234', 'mr@gmail.com',6),
('Bolas Brasil', 9850339290002, '3662282950', '31987654443', 'bolasb@hotmail.com',7),
('Calcados Mart',3432222220001, '1142167976', '31978900987', 'calcmart@gmail.com',8);



INSERT INTO `produtos` ( `descricao`, `tipo`, `precoCompra`, `precoVenda`, `estoque`,`fk_id_fornecedor`) VALUES
('Camisa Nike p101', 'Roupa', 79.9, 149.9, 10,1),
('Camisa Nike m201', 'Roupa', 89.9, 159.9, 20,1),
('Camisa Adidas mA90', 'Roupa', 99.9, 189.9, 1,1),
('Camisa Adidas gA80', 'Roupa', 109.9, 199.9, 5,1),
('Tênis Nike Air n33', 'Calçado', 179.9, 349.9, 23,3),
('Tênis Nike Air n42', 'Calçado', 210.8, 389.3, 25,3),
('Tênis Nike Air n39', 'Calçado', 129.5, 299.9, 15,3),
('Tênis Adidas Topz n34', 'Calçado', 279.5, 549.9, 5,3),
('Tênis Adidas Topz n38', 'Calçado', 299.9, 589.9, 10,3),
('Bola Adidas Campo', 'Bola', 179.9, 249.9, 23,2),
('Bola Nike Basquete', 'Bola', 110.8, 289.3, 25,2),
('Bola Nike Futsal', 'Bola', 129.5, 239.9, 15,2),
('Peso 5k Andoid', 'Peso', 59.5, 139.9, 5,2),
('Peso 4k Legace', 'Peso', 50.9, 139.9, 10,2),
('Peso 6k Legace', 'Peso', 69.5, 149.2, 17,2);


INSERT INTO `PAGAMENTOS` (`forma_pagamento`) VALUES
('PIX'),('CARTAO_CREDITO'),('BOLETO');

INSERT INTO `PEDIDOS` (`fk_id_Cliente`,`fk_id_pagamento`,`dataped`,`valorTotalPedido`) VALUES
(1,1,'2024-08-21',149.90),# 1 UNIDADE Camisa Nike p101
(2,1,'2024-08-21',298.40),# 2 UNIDADES Peso 6k Legace
(3,1,'2024-08-21',599.80);# 1 UNIDADE Tênis Nike Air n33 + 1 UNIDADE Bola Adidas Campo

INSERT INTO `ITEMSPEDIDOS` (`fk_id_Pedido`,`fk_id_Produto`,`quantidade`) VALUES
(1,1,1), # 1 UNIDADE Camisa Nike p101
(2,15,2), # 2 UNIDADES Peso 6k Legace
(3,5,1), # 1 UNIDADE Tênis Nike Air n33
(3,10,1); # 1  UNIDADE Bola Adidas Campo








