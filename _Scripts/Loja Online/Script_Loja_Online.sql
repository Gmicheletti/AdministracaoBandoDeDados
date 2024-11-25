CREATE SCHEMA LOJA_ONLINE;
USE LOJA_ONLINE;
CREATE TABLE `ENDERECOS` (
  `idEndereco` int(11) PRIMARY KEY AUTO_INCREMENT,
  `Logradouro` varchar(100) NOT NULL,
  `numero` int(11) NOT NULL,
  `complemento` varchar(100) NOT NULL,
  `cep` int(11) NOT NULL,
  `bairro` varchar(30) NOT NULL,
  `cidade` varchar(30) NOT NULL,
  `estado` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `CLIENTES` (
  `idCliente` int(11) PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `limiteCredito` double NOT NULL,
  `fk_id_endereco` INT NOT NULL,
  FOREIGN KEY (fk_id_endereco) REFERENCES ENDERECOS(idEndereco)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `FORNECEDORES` (
  `idFornecedor` int(11) PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cnpj` BIGINT NOT NULL,
  `inscE` BIGINT NOT NULL,
  `telefone` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `fk_id_Endereco` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `PRODUTOS` (
  `idProduto` int(11) PRIMARY KEY AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `precoCompra` double NOT NULL,
  `precoVenda` double NOT NULL,
  `estoque` int(11) NOT NULL,
  `fk_id_fornecedor` int(11) NOT NULL,
  FOREIGN KEY (`fk_id_fornecedor`) REFERENCES `FORNECEDORES` (`idFornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `PAGAMENTOS` (
  `idPagamento` int(11) PRIMARY KEY AUTO_INCREMENT,
  `forma_pagamento` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `PEDIDOS` (
  `idPedido` int(11) PRIMARY KEY AUTO_INCREMENT,
  `fk_id_Cliente` int(11) NOT NULL,
  `fk_id_pagamento` int(11) NOT NULL,
  `dataped` date NOT NULL,
  `valorTotalPedido` double NOT NULL,
  FOREIGN KEY (`fk_id_pagamento`) REFERENCES `PAGAMENTOS` (`idPagamento`),
  FOREIGN KEY (`fk_id_Cliente`) REFERENCES `CLIENTES` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 
CREATE TABLE `ITEMSPEDIDOS`(
  `idiItemPedido` int(11) PRIMARY KEY AUTO_INCREMENT,
  `fk_id_Pedido` int(11) NOT NULL,
  `fk_id_Produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
ALTER TABLE `ITEMSPEDIDOS`
  ADD CONSTRAINT `itemspedidos_ibfk_1` FOREIGN KEY (`fk_id_Pedido`) REFERENCES `PEDIDOS` (`idPedido`),
  ADD CONSTRAINT `itemspedidos_ibfk_2` FOREIGN KEY (`fk_id_Produto`) REFERENCES `PRODUTOS` (`idProduto`);

