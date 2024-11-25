#-- NÚMERO 1
DROP SCHEMA IF EXISTS `NewtonLoc`;
CREATE SCHEMA `NewtonLoc`;
USE `NewtonLoc`;


CREATE TABLE `CLIENTES` (
`idCliente` INT NOT NULL AUTO_INCREMENT,
`nome` VARCHAR(45) NOT NULL,
`cpf` CHAR(11) NOT NULL,
`telefone` CHAR(11) NOT NULL,
`email` VARCHAR(45) NOT NULL,
`pontuacao` INT NOT NULL,
`tipo` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idCliente`)) ENGINE = InnoDB;


CREATE TABLE`CARROS` (
`idCarro` INT NOT NULL AUTO_INCREMENT,
`fabricante` VARCHAR(45) NOT NULL,
`modelo` VARCHAR(45) NOT NULL,
`cor` VARCHAR(15) NOT NULL,
`anoFabricacao` YEAR NOT NULL,
`potenciaMotor` DECIMAL(4,1) NOT NULL,
`categoria` VARCHAR(45) NOT NULL,
`quilometragem` BIGINT NOT NULL,
PRIMARY KEY (`idCarro`)) ENGINE = InnoDB;


CREATE TABLE`DIMENSOES` (
`idDimensao` INT AUTO_INCREMENT,
`altura_mm` DECIMAL(4,3) NOT NULL,
`largura_mm` DECIMAL(4,3) NOT NULL,
`comprimento_mm` DECIMAL(4,3) NOT NULL,
`peso_kg` INT NOT NULL,
`tanque_L` INT NOT NULL,
`entre_eixos_mm` DECIMAL(4,3) NOT NULL,
`porta_mala_L` INT NOT NULL,
`ocupante` INT NOT NULL,
`fk_idCarro` INT NOT NULL,
CONSTRAINT `fk_Dimensoes_Carros`
FOREIGN KEY (`fk_idCarro`) REFERENCES `CARROS` (`idCarro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY (`idDimensao`)) ENGINE = InnoDB;


CREATE TABLE `LOCACAO` (
`idLocacao` INT NOT NULL AUTO_INCREMENT,
`dataLocacao` DATE NOT NULL,
`valorDiaria` DOUBLE NOT NULL,
`fk_idCliente` INT NOT NULL,
`fk_idCarro` INT NOT NULL,
PRIMARY KEY (`idLocacao`),
CONSTRAINT `fk_Locacao_Clientes`
FOREIGN KEY (`fk_idCliente`)
REFERENCES `CLIENTES` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT `fk_Locacao_Carros`
FOREIGN KEY (`fk_idCarro`) REFERENCES `CARROS`(`idCarro`) ON DELETE NO ACTION ON UPDATE NO ACTION) ENGINE = InnoDB;



#-- NÚMERO 2
INSERT INTO dimensoes(altura_mm, largura_mm, comprimento_mm, peso_kg, 
tanque_L, entre_eixos_mm, porta_mala_L, ocupante, fk_idCarro) values
    (1.475, 1.656, 3.892, 1020, 55, 2.467, 285, 5, 6),
    (1.480, 1.760, 4.540, 1230, 60, 2.600, 470, 5, 4),
    (1.673, 1.844, 4.945, 1650, 55, 2.982, 0, 5, 1),
    (1.487, 1.765, 3.935, 1084, 54, 2.488, 270, 5, 3),
    (1.490, 1.730, 4.425, 1130, 45, 2.550, 473, 5, 2),
    (1.470, 1.720, 4.015, 993, 50, 2.530, 300, 5, 5),
    (1.471, 1.731, 4.163, 1034, 44, 2.551, 303, 5, 7);

#-- NÚMERO 3
#-- 1 - Qual o modelo do carro que já foi alugado
CREATE OR REPLACE VIEW 3View1 AS
SELECT modelo FROM locacao L
JOIN carros C
ON L.fk_idCarro = C.idCarro;
SELECT * FROM 3View1;

#-- 2 - Qual o nome do cliente que já alugou um carro
CREATE OR REPLACE VIEW 3View2 AS
SELECT nome FROM clientes C 
JOIN locacao L 
ON C.idCliente = L.fk_idCliente;
SELECT * FROM 3View2;

#-- 3 - Qual o nome do cliente que alugou o carro com a diária mais alta.
CREATE OR REPLACE VIEW 3View3 AS
SELECT C.nome FROM clientes C
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente 
WHERE L.valorDiaria = (SELECT MAX(L.valorDiaria) FROM locacao L);
SELECT * FROM 3View3;

#-- 4 - Qual a categoria do carro que foi alugado por ultimo
CREATE OR REPLACE VIEW 3View4 AS
SELECT categoria FROM locacao L
JOIN carros C
ON L.fk_idCarro = C.idCarro
WHERE L.dataLocacao = (SELECT MAX(L.dataLocacao) FROM locacao L);
SELECT * FROM 3View4;

#-- 5 - Qual o nome do fabricante(s) que produziu o carro(s) mais potente(s)
CREATE OR REPLACE VIEW 3View5 AS
SELECT CA.fabricante FROM carros CA
WHERE CA.potenciaMotor = (SELECT MAX(CA.potenciaMotor)
FROM carros CA);
SELECT * FROM 3View5;

#-- 6 - Qual a cor da SUV locada no dia 2024-10-22
CREATE OR REPLACE VIEW 3View6 AS
SELECT cor FROM locacao L
JOIN carros C
ON L.fk_idCarro = C.idCarro
WHERE L.dataLocacao = '2024-10-22';
SELECT * FROM 3View6;

#-- 7 - Qual o modelo do carro, fabricante, cor que tem a menor diária
CREATE OR REPLACE VIEW 3View7 AS
SELECT CA.modelo, CA.fabricante, CA.cor FROM carros CA
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro 
WHERE L.valorDiaria = (SELECT MIN(L.valorDiaria) FROM locacao L);
SELECT * FROM 3View7;

#-- 8 - Qual o modelo do carro e categoria que não foi alugado ainda
CREATE OR REPLACE VIEW 3View8 AS
SELECT modelo, categoria FROM carros C
JOIN locacao L
ON L.fk_idCarro = C.idCarro
WHERE L.fk_idCarro IS NULL;
SELECT * FROM 3View8;

#-- 9 - Qual o nome do cliente que nunca alugou um carro do ano de fabricao 2013
CREATE OR REPLACE VIEW 3View9 AS
SELECT C.nome FROM clientes C 
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA
ON CA.idCarro = L.fk_idCarro
WHERE CA.anoFabricacao != 2013;
SELECT * FROM 3View9;

#-- 10 - Qual o nome do cliente que já alugou um carro SUV
CREATE OR REPLACE VIEW 3View10 AS
SELECT nome FROM locacao L
JOIN carros C
ON L.fk_idCarro = C.idCarro
JOIN clientes CLI
ON L.fk_idCliente = CLI.idCliente
WHERE C.categoria LIKE '%SUV%';
SELECT * FROM 3View10;

#-- 11 - Qual o nome do cliente que NÃO alugou um carro Sedan
CREATE OR REPLACE VIEW 3View11 AS
SELECT C.nome, CA.categoria FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.categoria NOT LIKE '%sedan%';
SELECT * FROM 3View11;


#-- 12 - Qual a categoria do cliente que já alugou um carro com mais de 3000 quilômetros rodados
CREATE OR REPLACE VIEW 3View12 AS
SELECT tipo FROM locacao L
JOIN carros C
ON L.fk_idCarro = C.idCarro
JOIN clientes CLI
ON L.fk_idCliente = CLI.idCliente
WHERE C.quilometragem > 3000;
SELECT * FROM 3View12;

#-- 13 - Qual o modelo do carro que tem a menor altura.
CREATE OR REPLACE VIEW 3View13 AS
SELECT fabricante,modelo,altura_mm FROM carros C
JOIN dimensoes D
ON D.fk_idCarro = C.idCarro
WHERE D.altura_mm = (SELECT MIN(D.altura_mm) FROM dimensoes D);
SELECT * FROM 3View13;

#--  14 - Qual o tamanho do porta mala do carro que é da categoria Hatch
CREATE OR REPLACE VIEW 3View14 AS
SELECT fabricante,modelo,porta_mala_L FROM carros C
JOIN dimensoes D
ON D.fk_idCarro = C.idCarro
WHERE C.categoria LIKE '%Hatch%';
SELECT * FROM 3View14;

#-- 15 – Você deve criar mais 10 sub Consultas nesse sistema.

#-- 1 contar quantos carros tem
CREATE OR REPLACE VIEW 3View15_1 AS
SELECT COUNT(idCarro) FROM carros;
SELECT * FROM 3View15_1;

#-- 2 contar quantos clientes tem
CREATE OR REPLACE VIEW 3View15_2 AS
SELECT COUNT(idCliente) FROM clientes;
SELECT * FROM 3View15_2;

#-- 3 contar quantas locacoes ja foram feitas
CREATE OR REPLACE VIEW 3View15_3 AS
SELECT COUNT(idLocacao) FROM locacoes;
SELECT * FROM 3View15_3;

#-- 4 selecionar o carro com maior quilometragem
CREATE OR REPLACE VIEW 3View15_4 AS
SELECT MAX(quilometragem) FROM carros;
SELECT * FROM 3View15_4;

#-- 5 selecionar o carro que possui o ano menor
CREATE OR REPLACE VIEW 3View15_5 AS
SELECT MIN(anoFabricacao) FROM carros;
SELECT * FROM 3View15_5;

#-- 6 selecionar o carro menos potente
CREATE OR REPLACE VIEW 3View15_6 AS
SELECT MIN(potenciaMotor) FROM carros;
SELECT * FROM 3View15_6;

#-- 7 selecionar o cliente com maior pontuação
CREATE OR REPLACE VIEW 3View15_7 AS
SELECT MAX(pontuacao) FROM clientes;
SELECT * FROM 3View15_7;

#-- 8 contar as locacoes do dia de hoje
CREATE OR REPLACE VIEW 3View15_8 AS
SELECT COUNT(idLocacao) FROM locacoes AS L
WHERE L.dataLocacao = NOW();
SELECT * FROM 3View15_8;

#-- 9 selecionar a locacao que obteve o maior valor de diaria
CREATE OR REPLACE VIEW 3View15_9 AS
SELECT MAX(valorDiaria) FROM locacoes;
SELECT * FROM 3View15_9;

#-- 10 selecionar o carro mais novo alugado em 2023
CREATE OR REPLACE VIEW 3View15_10 AS
SELECT MAX(anoFabricacao) FROM locacoes AS L
INNER JOIN carros AS C
ON L.fk_idCarro = C.idCarro
WHERE YEAR(L.dataLocacao) =  2023;
SELECT * FROM 3View15_10;




#-- NÚMERO 4
#-- Crie uma trigger para monitorar a tabela locação. Ela deve registrar os dados do usuário, data de inserção de um registro, e quais foram os dados novos inseridos. Para isso crie uma tabela chamada log.

CREATE TABLE IF NOT EXISTS LOG_LOCACAO(
	idLog INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idCliente INT NOT NULL,
    nomeCliente VARCHAR(45) NOT NULL,
    dataLocacao DATE NOT NULL,
    valorDiaria DOUBLE NOT NULL,
    fk_idCarro INT NOT NULL,
    nomeCarro VARCHAR(45) NOT NULL,

    FOREIGN KEY (fk_idCliente) REFERENCES CLIENTES(idCliente),
    FOREIGN KEY (fk_idCarro) REFERENCES CARROS(idCarro)

)


DELIMITER $$
CREATE TRIGGER LOG_LOCACAO
AFTER INSERT ON locacao
FOR EACH ROW
BEGIN
DECLARE carroInfo VARCHAR(100);
DECLARE clienteInfo VARCHAR(100);

SET carroInfo = (SELECT modelo FROM CARROS WHERE idCarro = new.fk_idCarro);
SET clienteInfo = (SELECT nome FROM CLIENTES WHERE idCliente = new.fk_idCliente);

INSERT INTO LOG_LOCACAO(fk_idCliente, nomeCliente, dataLocacao, valorDiaria, fk_idCarro, nomeCarro) 
VALUES(new.fk_idCliente, clienteInfo, new.dataLocacao, new.valorDiaria, new.fk_idCarro, carroInfo);
END $$
DELIMITER ;

INSERT INTO LOCACAO(dataLocacao, valorDiaria, fk_idCliente, fk_idCarro)
VALUES('2024-10-22', 100, 1, 1);


#-- NÚMERO 5
#-- Analise o database e suas tabelas para implementar uma trigger que possa fazer a gestão da quilometragem dos carros que foram alugados. Exemplo: Aluguei um gol com quilometragem de 2344 quilômetros e só posso rodar 1000 quilômetros, se ao entregar o carro ele estiver com quilometragem de mais que 3344, meu valor do quilometro deve subir pra 30% a mais. Você deve mudar o que for preciso para atender a demanda passada. Se achar necessário, use uma tabela pra devolução com os valores extras nela.

CREATE TABLE IF NOT EXISTS DEVOLUCAO(
    idDevolucao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dataDevolucao DATE NOT NULL,
    valorDiariaAjustada DOUBLE NULL,
    kmDevolvida INT NOT NULL,
    fk_idLocacao INT NOT NULL,

    FOREIGN KEY (fk_idLocacao) REFERENCES LOCACAO(idLocacao)
);


DROP TRIGGER CHECK_DEVOLUCAO;

DELIMITER $$
CREATE TRIGGER CHECK_DEVOLUCAO
BEFORE INSERT ON DEVOLUCAO
FOR EACH ROW
BEGIN

    DECLARE kmAnterior INT;
    DECLARE kmResult INT;
    DECLARE valorDiaria DOUBLE;

    SET kmAnterior = (
        SELECT quilometragem FROM LOCACAO L
        JOIN CARROS C
        ON C.idCarro = L.fk_idCarro
        WHERE L.idLocacao = new.fk_idLocacao 
        );

    SET valorDiaria = (SELECT valorDiaria FROM LOCACAO WHERE idLocacao = new.fk_idLocacao);

    SET kmResult = new.kmDevolvida - kmAnterior;

    IF(kmResult > 1000) THEN
        SET new.valorDiariaAjustada = valorDiaria + (valorDiaria * 0.30);
    ELSE
        SET new.valorDiariaAjustada = valorDiaria;
    END IF;
    

END $$
DELIMITER ;


INSERT INTO DEVOLUCAO(dataDevolucao, kmDevolvida, fk_idLocacao)
VALUES(NOW(), 13200, 1);


#-- NÚMERO 6
#--Crie 10 usuários com senha para acessar (Roles) conforme as restrições abaixo (Você decide quem acessa o que) cada acesso é uma Role

#-- Acesso1 - Apenas para dar select em todas as tabelas.
CREATE ROLE nivel_1;
GRANT SELECT ON newtonloc.* TO nivel_1;
SHOW GRANTS FOR nivel_1;

#-- Acesso2 - Apenas Select e insert na tabela de carros
CREATE ROLE nivel_2;
GRANT SELECT, INSERT ON newtonloc.carros TO nivel_2;
SHOW GRANTS FOR nivel_2;

#-- Acesso3 - Total no Sistema e database.
CREATE ROLE nivel_3;
GRANT ALL ON newtonloc.* TO nivel_3;
SHOW GRANTS FOR nivel_3;

#-- Acesso4 - Create, alter e drop em tabelas e schema.
CREATE ROLE nivel_4;
GRANT CREATE, ALTER, DROP ON newtonloc.* TO nivel_4;
SHOW GRANTS FOR nivel_4;

#-- Acesso5 - Total ao schema.
CREATE ROLE nivel_5;
GRANT ALL ON newtonloc.* TO nivel_5;
SHOW GRANTS FOR nivel_5;

#--
CREATE USER 'Cassio' IDENTIFIED BY '11111';
GRANT nivel_5 TO 'Cassio'@'%';
SET DEFAULT ROLE nivel_5 TO 'Cassio'@'%';
SHOW GRANTS FOR 'Cassio'@'%';

CREATE USER 'Marlon'@'%' IDENTIFIED BY '22222';
GRANT nivel_1 TO 'Marlon'@'%';
SET DEFAULT ROLE nivel_1 TO 'Marlon'@'%';
SHOW GRANTS FOR 'Marlon'@'%';

CREATE USER 'ZéIvaldo'@'localhost' IDENTIFIED BY '333333';
GRANT nivel_2 TO 'ZeIvaldo'@'%';
SET DEFAULT ROLE nivel_2 TO 'ZeIvaldo'@'%';
SHOW GRANTS FOR 'ZeIvaldo'@'%';

CREATE USER 'JoãoMarcelo' IDENTIFIED BY '44444';
GRANT nivel_3 TO 'JoaoMarcelo'@'%';
SET DEFAULT ROLE nivel_3 TO 'JoaoMarcelo'@'%';
SHOW GRANTS FOR 'JoaoMarcelo Marcelo'@'%';

CREATE USER 'William' IDENTIFIED BY '55555';
GRANT nivel_4 TO 'William'@'%';
SET DEFAULT ROLE nivel_4 TO 'William'@'%';
SHOW GRANTS FOR 'William'@'%';

CREATE USER 'Romero'@'localhost' IDENTIFIED BY '66666';
GRANT nivel_5 TO 'Romero'@'%';
SET DEFAULT ROLE nivel_5 TO 'Romero'@'%';
SHOW GRANTS FOR 'Romero'@'%';

CREATE USER 'MatheusHenrique' IDENTIFIED BY '77777';
GRANT nivel_3 TO 'MatheusHenrique'@'%';
SET DEFAULT ROLE nivel_3 TO 'MatheusHenrique'@'%';
SHOW GRANTS FOR 'MatheusHenrique'@'%';

CREATE USER 'MatheusPereira'@'%' IDENTIFIED BY '88888';
GRANT nivel_1 TO 'MatheusPereira'@'%';
SET DEFAULT ROLE nivel_1 TO 'MatheusPereira'@'%';
SHOW GRANTS FOR 'MatheusPereira'@'%';

CREATE USER 'Lautaro' IDENTIFIED BY '99999';
GRANT nivel_1 TO 'Lautaro'@'%';
SET DEFAULT ROLE nivel_1 TO 'Lautaro'@'%';
SHOW GRANTS FOR 'Lautaro'@'%';

CREATE USER 'Dineno'@'localhost' IDENTIFIED BY '123456789';
GRANT nivel_4 TO 'Dineno'@'%';
SET DEFAULT ROLE nivel_4 TO 'Dineno'@'%';
SHOW GRANTS FOR 'Dineno'@'%';



#-- NÚMERO 7
#-- Entre os usuários criados acima, altere as permissões de 5. A sua escolha.
REVOKE nivel_4 FROM 'Dineno'@'%';
GRANT nivel_1 TO 'Dineno'@'%';
SET DEFAULT ROLE nivel_1 TO 'Dineno'@'%';
SHOW GRANTS FOR 'Dineno'@'%';

REVOKE nivel_1 FROM 'Lautaro'@'%';
GRANT nivel_2 TO 'Lautaro'@'%';
SET DEFAULT ROLE nivel_2 TO 'Lautaro'@'%';
SHOW GRANTS FOR 'Lautaro'@'%';

REVOKE nivel_1 FROM 'MatheusPereira'@'%';
GRANT nivel_3 TO 'MatheusPereira'@'%';
SET DEFAULT ROLE nivel_3 TO 'MatheusPereira'@'%';
SHOW GRANTS FOR 'MatheusPereira'@'%';

REVOKE nivel_5 FROM 'Romero'@'%';
GRANT nivel_2 TO 'Romero'@'%';
SET DEFAULT ROLE nivel_2 TO 'Romero'@'%';
SHOW GRANTS FOR 'Romero'@'%';

REVOKE nivel_1 FROM 'Marlon'@'%';
GRANT nivel_5 TO 'Marlon'@'%';
SET DEFAULT ROLE nivel_5 TO 'Marlon'@'%';
SHOW GRANTS FOR 'Marlon'@'%';



#-- NÚMERO 8
#-- Crie um índice para cada uma das tabelas acima.
-- _____1
CREATE INDEX carros_quilometragem on carros(quilometragem ASC);

-- _____2
CREATE INDEX cliente_pontuacao  on clientes(pontuacao ASC);

-- _____3
CREATE INDEX devolucao_data on devolucao(dataDevolucao ASC);

-- _____4
CREATE INDEX dimensoes_tanque_L on dimensoes(tanque_L ASC);

-- _____5
CREATE INDEX locacao_valorDiaria on locacao(valorDiaria ASC);

-- _____6
CREATE INDEX log_locacao_nomeCliente on log_locacao(nomeCliente ASC);



#-- NÚMERO 9
#-- Crie 20 perguntas e 20 respostas onde as respostas devem ser todas com Join.

#-- 1 - Mostre os dados completos dos clientes que fizeram locações, com o valor e modelo do carro.
SELECT C.*, L.valorDiaria, CA.modelo FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro;

#-- 2 - Mostre o nome, emails dos clientes e os modelos dos carros alugados.
SELECT C.nome, C.email, CA.modelo FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro;

#-- 3 - Liste o nome e CPF dos clientes que alugaram carros.
SELECT C.nome, C.cpf FROM clientes AS C 
INNER JOIN locacao AS L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro;

#-- 4 - Liste o nome dos clientes que alugaram carros com potência igual a 2.0.
SELECT C.nome, CA.modelo FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.potenciaMotor = 2.0;

#-- 5 - Liste os dados fabricante, modelo, categoria, de todos os carros alugados junto com o nome do cliente e a data da locação.
SELECT CA.fabricante, CA.categoria, CA.modelo, C.nome, L.dataLocacao FROM carros AS CA
INNER JOIN locacao AS L
ON CA.idCarro = L.fk_idCarro
INNER JOIN clientes AS C 
ON C.idCliente = L.fk_idCliente;

#-- 6 - Exiba o nome dos clientes que já alugaram carros com porta malas maior que 300 litros
SELECT C.nome FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro
INNER JOIN dimensoes AS D
ON CA.idCarro = D.fk_idCarro
WHERE D.porta_mala_L > 300
GROUP BY C.nome; 

#-- 7 - Retorne o nome do cliente e a data da locação de todos os carros alugados anteriormente.
SELECT C.nome, L.dataLocacao FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente;

#-- 8 - Quais os nomes dos clientes que alugaram carros da cor branco?
SELECT C.nome FROM clientes AS C
INNER JOIN locacao AS L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.cor = 'Branco';

#-- 9 - Mostre o nome dos clientes e a quantidade de locações que eles já fizeram.
SELECT C.nome, COUNT(L.idLocacao) FROM clientes AS C 
LEFT JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
GROUP BY C.nome;

#-- 10 - Mostre o nome dos clientes e os fabricantes dos carros que alugaram.
SELECT C.nome, CA.fabricante FROM clientes AS C 
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro;

#-- 11 - Mostre a categoria e o modelo dos carros Sedan que foram locados juntamente com os nomes dos clientes.
SELECT CA.categoria, CA.modelo, C.nome FROM carros AS CA
INNER JOIN locacao AS L
ON CA.idCarro = L.fk_idCarro
INNER JOIN clientes AS C 
ON C.idCliente = L.fk_idCliente
WHERE CA.categoria = 'Sedan';

#-- 12 - Liste o modelo dos carros locados e suas dimensões.
SELECT CA.modelo, D.altura_mm, D.largura_mm, D.comprimento_mm FROM carros AS CA 
INNER JOIN locacao AS L
ON CA.idCarro = L.fk_idCarro
INNER JOIN dimensoes AS D
ON D.fk_idCarro = L.fk_idCarro
ORDER BY CA.modelo ASC;

#-- 13 - Mostre os modelos de carros e o número de vezes que cada um foi alugado.
SELECT CA.modelo, COUNT(L.idLocacao) FROM carros AS CA 
LEFT JOIN locacao AS L 
ON CA.idCarro = L.fk_idCarro
GROUP BY CA.modelo;

#-- 14 - Qual o total de quilometragem dos carros que já foram alugados?
USE newtonloc;
SELECT SUM(CA.quilometragem) FROM carros AS CA 
INNER JOIN locacao AS L 
ON CA.idCarro = L.fk_idCarro;

#-- 15 - Qual o total de clientes que realizaram um alugel?
SELECT COUNT(idCliente) FROM locacao AS L
INNER JOIN clientes AS C
ON L.fk_idCliente = C.idCliente;

#-- 16 - Qual o total de carros da frota?
SELECT COUNT(idCarro) FROM carros;

#-- 17 - Liste o valor da diária dos carros alugados e nome do cliente.
SELECT C.nome, L.valorDiaria FROM clientes AS C
INNER JOIN locacao AS L 
ON C.idCliente = L.fk_idCliente;

#-- 18 - Liste o modelo do carro, a cor e o nome dos clientes que fizeram locações.
SELECT CA.modelo, CA.cor, C.nome FROM carros AS CA 
INNER JOIN locacao AS L 
ON CA.idCarro = L.fk_idCarro 
INNER JOIN clientes AS C 
ON C.idCliente = L.fk_idCliente;

#-- 19 - Quais os fabricantes e modelos de carros que já foram locados
SELECT CA.fabricante, CA.modelo, C.nome FROM clientes AS C 
INNER JOIN locacao AS L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros AS CA 
ON CA.idCarro = L.fk_idCarro
ORDER BY C.nome ASC;

#-- 20 - Exiba o modelo, a quilometragem e a potência de motor.
SELECT modelo, quilometragem, potenciaMotor FROM carros;


#-- NÚMERO 10
#-- Crie 10 procedures com tema livre.

#-- 1
DROP PROCEDURE IF EXISTS lucroProdutos;
DELIMITER $$
CREATE PROCEDURE lucroProdutos(IN valorCompra FLOAT, IN valorVenda FLOAT, OUT lucro FLOAT)
BEGIN

SET lucro = valorVenda - valorCompra;

END $$
DELIMITER ;

call lucroProdutos(2, 5, @lucro);
SELECT @lucro;


#-- 2
DROP PROCEDURE IF EXISTS mediaNotas;
DELIMITER $$
CREATE PROCEDURE mediaNotas(IN nota1 FLOAT, IN nota2 FLOAT, OUT media FLOAT)
BEGIN

SET media = (nota1 + nota2)/2;

END $$
DELIMITER ;

call mediaNotas(10, 10, @media);
SELECT @media;

#-- 3
DROP PROCEDURE IF EXISTS calcLitros;
DELIMITER $$
CREATE PROCEDURE calcLitros(IN largura FLOAT, IN altura FLOAT, IN comprimento FLOAT,  OUT litros FLOAT)
BEGIN

SET litros = (largura * altura * comprimento) / 1000;

END $$
DELIMITER ;

call calcLitros(20, 30, 50, @litros);
SELECT @litros;

#-- 4
DROP PROCEDURE IF EXISTS calcComprimentoCircunferencia;
DELIMITER $$
CREATE PROCEDURE calcComprimentoCircunferencia(IN raio FLOAT, OUT comprimento FLOAT)
BEGIN

SET comprimento = 2 * 3.14 * raio;

END $$
DELIMITER ;

call calcComprimentoCircunferencia(5, @comprimento);
SELECT @comprimento;


#-- 5
DROP PROCEDURE IF EXISTS calcIdade;
DELIMITER $$
CREATE PROCEDURE calcIdade(IN ano INT, OUT idade INT)
BEGIN

SET idade = year(now()) - ano;

END $$
DELIMITER ;

call calcIdade(1994, @idade);
SELECT @idade;

#-- 6
DROP PROCEDURE IF EXISTS calcCombustivel;
DELIMITER $$
CREATE PROCEDURE calcCombustivel(IN valGasolina FLOAT, IN valAlcool FLOAT, OUT result TEXT)
BEGIN

DECLARE calc FLOAT;

SET calc = valGasolina * 0.7;

IF(valAlcool > calc) THEN
SET result = 'Abasteça com gasolina';
END IF;

IF(valAlcool <= calc)THEN
SET result = 'Abasteça com álcool';
END IF;

END $$
DELIMITER ;

call calcCombustivel(4.00, 2.90, @result);
SELECT @result;

#-- 7
DROP PROCEDURE IF EXISTS contaDeEnergia;
DELIMITER $$
CREATE PROCEDURE contaDeEnergia(IN consumo FLOAT, OUT valor DECIMAL(5, 2))
BEGIN

IF(consumo <= 30) THEN
SET valor = consumo * 0.23784;
END IF;

IF(consumo >= 31 && consumo <= 100 ) THEN
SET valor = consumo * 0.40773;
END IF;

IF(consumo >= 101 && consumo <= 220 ) THEN
SET valor = consumo * 0.628565;
END IF;

IF(consumo >220) THEN
SET valor = consumo * 0.67955;
END IF;

END $$
DELIMITER ;

call contaDeEnergia(34, @valor);
SELECT @valor;

#-- 8
DROP PROCEDURE IF EXISTS valorMetroQuadrado;
DELIMITER $$
CREATE PROCEDURE valorMetroQuadrado(IN custoMetro FLOAT, IN largura FLOAT, IN altura FLOAT, OUT result FLOAT)
BEGIN


SET result = (largura * altura) * custoMetro;

END $$
DELIMITER ;

call valorMetroQuadrado(10, 2, 2, @result);
SELECT @result;

#-- 9
DROP PROCEDURE IF EXISTS calcHipotenusa;
DELIMITER $$
CREATE PROCEDURE calcHipotenusa(IN ladoA FLOAT, IN ladoB FLOAT, OUT hipotenusa FLOAT)
BEGIN

SET hipotenusa = SQRT((ladoA * ladoA)+(ladoB * ladoB));

END $$
DELIMITER ;

call calcHipotenusa(3, 4, @hipotenusa);
SELECT @hipotenusa;

#-- 10
DROP PROCEDURE IF EXISTS calcDistanciaPercorrida;
DELIMITER $$
CREATE PROCEDURE calcDistanciaPercorrida(IN tempo INT, IN velocidade FLOAT, OUT distancia FLOAT)
BEGIN

SET distancia = tempo  * velocidade;

END $$
DELIMITER ;

call calcDistanciaPercorrida(60, 50, @distancia);
SELECT @distancia;