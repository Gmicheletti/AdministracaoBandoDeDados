/* Exercicio 1
Crie uma Stored Procedure que calcule a média de quatro números 
inteiros informados como parâmetro. Retorne o resultado da 
operação e armazene os números e o resultado em uma tabela. 
Além dos números a tabela deve ter um ID como chave primaria, 
conter a data e o usuário que realizou a operação.
*/

USE loja_online;

DELIMITER $$
CREATE PROCEDURE pc01(IN n1 INT, IN n2 INT, IN n3 INT, IN n4 INT, IN in_data DATE, IN usuario VARCHAR(255))
BEGIN
DECLARE media_calc FLOAT;
CREATE TABLE IF NOT EXISTS mediaNumb(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    n1 INT NOT NULL,
    n2 INT NOT NULL,
    n3 INT NOT NULL,
    n4 INT NOT NULL,
    media FLOAT NOT NULL,
    in_data DATE NOT NULL,
    usuario VARCHAR(255) NOT NULL
);

SET media_calc = (n1 + n2 + n3 + n4)/4;

INSERT INTO mediaNumb(n1, n2, n3, n4, media, in_data, usuario) VALUES (n1, n2, n3, n4, media_calc, in_data, usuario);

END $$
DELIMITER ;

call pc01(2, 2, 2, 2, NOW(), 'Guilherme');



/* Exercicio 2
Crie uma Stored Procedure que some quantos clientes tem no 
cadastro da loja_online  e quantos fornecedores tambem estão
cadastrados. Crie a tabela colaboradores e insira 5 tuplas. 

*/

USE loja_online;

DELIMITER $$
CREATE PROCEDURE pc02(OUT nCLI INT, OUT nFOR INT, IN nomeColaborador VARCHAR(255))
BEGIN

SET nCLI = (SELECT COUNT(*) FROM clientes);
SET nFOR = (SELECT COUNT(*) FROM fornecedores);

CREATE TABLE IF NOT EXISTS colaboradores(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomeColab VARCHAR(255) NOT NULL
);

INSERT INTO colaboradores(nomeColab) VALUES (nomeColaborador);
END $$
DELIMITER ;

call pc02(@clientes, @fornecedores, 'Guilherme');
call pc02(@clientes, @fornecedores, 'Jefferson');
call pc02(@clientes, @fornecedores, 'Lorena');
call pc02(@clientes, @fornecedores, 'Lucas');
call pc02(@clientes, @fornecedores, 'Carlos');
SELECT @clientes, @fornecedores;




/* Exercicio 3
Crie uma Stored Procedure para resolver o problema de Mariana, 
ela quis usar uma fita para embrulhar um pacote. Após uma rápida 
medição notou que bastavam 45cm (quarenta e cinto centímetros) 
para embrulhar tal pacote. A papelaria aonde ela foi só vendia a fita por 
4.00 reais a cada metro. Quanto Mariana teve que pagar para ter o tamanho necessário de fita?  
Observe a tabela abaixo:
Metro Decímetro Centímetro Milímetro 
m        dm        cm         mm 
1m       0,1m     0,01m      0,001m
*/


DELIMITER $$
CREATE PROCEDURE pc03(OUT val FLOAT)
BEGIN

DECLARE result;
SET result = (4 * 45)/100;
END $$
DELIMITER ;

call pc03(@result);
SELECT @result;


/* Exercicio 4
 Crie uma Stored Procedure que leia um número e calcule o seu 
quadrado, ou seja, o produto de um número por si mesmo depois 
acrescente a esse numero a raiz quadrada de 81. Obs: deve-se 
fazer a conta da raiz quadrada na procedure também. 
*/

DELIMITER $$
CREATE PROCEDURE pc04(OUT result FLOAT, IN numb INT)
BEGIN

SET result = (numb * numb) + SQRT(81);

END $$
DELIMITER ;

call pc04(@result, 2);
SELECT @result;


/* Exercicio 5
 No Brasil a taxa de imposto de um determinado carro é de 52%, na 
Argentina 21%, Crie uma Stored Procedure que apresente o custo 
total do carro em ambos os países. OBS: os valores apresentados 
são em reais para ambos os países.  
 Dados para calcular os valores: 
                   BRASIL                  ARGENTINA 
CUSTO TOTAL          ?                        ? 
CUSTO FABRICA      11000                    8000 
IMPOSTOS %          52                       21 
DISTRIBUIÇÃO_CUSTO 2450                     1100 
CONCESSIONÁRIA %    3.5                      1.5

*/

DELIMITER $$
CREATE PROCEDURE pc05(OUT carBR FLOAT, OUT carARG FLOAT)
BEGIN

SET carBR = (11000 * 0.52) + (11000 * 0.035) + 11000 + 2450;
SET carARG = (8000 * 0.21) + (8000 * 0.015) + 8000 + 1100;

END $$
DELIMITER ;

call pc05(@carBR, @carARG);
SELECT @carBR, @carARG;



/* Exercicio 6

Crie uma stored procedure onde se deve criar a tabela de 
Cardápio com os preços abaixo, crie também uma tabela consumo. 
Crie outra stored procedure que insere o consumo do cliente. Leia o 
código do cliente, código do produto o preço unitário a quantidade 
desse produto consumida e soma total de consumo do cliente. 
Exemplo id=1,cliente= joao , quantidade=2 refrigerantes, 
precounitario = 3 totalconsumido=6 
Cardapio: 
Hambúrguer................. R$ 3,00 
Cheeseburger.............. R$ 2,50 
Fritas............................ R$ 2,50 
Refrigerante................. R$ 1,00 
Milkshake..................... R$ 3,00 

*/

DELIMITER $$
CREATE PROCEDURE pc06(IN p_idCliente INT, IN p_idProduto INT, IN p_qtdeProduto INT)
BEGIN
DECLARE p_precoUnitario FLOAT;
DECLARE p_valTotal FLOAT;

CREATE TABLE IF NOT EXISTS cardapio(
    idProduto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomeProduto VARCHAR(255) NOT NULL,
    valProduto FLOAT NOT NULL
);

INSERT INTO cardapio(nomeProduto, valProduto) VALUES
('Hambúrguer', 3.00),
('Cheeseburger', 2.50),
('Fritas', 2.50),
('Refrigerante', 1.00),
('Milkshake', 3.00);

CREATE TABLE IF NOT EXISTS consumo(
    idConsumo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idProduto INT NOT NULL,
    qtdeProduto INT NOT NULL,
    precoUnitario FLOAT NOT NULL,
    valTotal FLOAT NOT NULL,
    
	CONSTRAINT idProduto FOREIGN KEY (idProduto)
    REFERENCES cardapio(idProduto)
);

SET p_precoUnitario = (SELECT valProduto FROM cardapio WHERE idProduto = p_idProduto);
SET p_valTotal = p_precoUnitario * p_qtdeProduto;

INSERT INTO consumo(idCliente, idProduto, qtdeProduto, precoUnitario, valTotal)
VALUES (p_idCliente, p_idProduto, p_qtdeProduto, p_precoUnitario, p_valTotal);

END $$
DELIMITER ;

call pc06(1, 1, 2);