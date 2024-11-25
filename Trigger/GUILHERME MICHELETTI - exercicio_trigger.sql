USE BANCO;


/*
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome_cliente VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS conta(
	id_conta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    num_conta VARCHAR(255) NOT NULL,
    saldo FLOAT NOT NULL,
    fk_cliente_conta INT NOT NULL,
    
	CONSTRAINT fk_cliente_conta FOREIGN KEY (fk_cliente_conta)
    REFERENCES cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS depositante(
	id_depositante INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_cliente_depos INT NOT NULL,
    
	CONSTRAINT fk_cliente_depos FOREIGN KEY (fk_cliente_depos)
    REFERENCES cliente(id_cliente)
);
*/

/*
INSERT INTO cliente(nome_cliente) VALUES
('Guilherme Micheletti'),
('Lucas Rodrigues'),
('Jefferson Caetano'),
('Lorena Nobre'),
('Carlos Jardel');
*/

/*
INSERT INTO conta(num_conta, saldo, id_cliente) VALUES
('0001', 100.00, 1),
('0002', 0.00, 1),
('0003', 300.00, 2),
('0004', 0.00, 3),
('0005', 0.50, 4),
('0006', 0.00, 5),
('0007', 0.00, 5);
*/

/*
INSERT INTO depositante(fk_cliente_depos) VALUES
(1),
(2),
(4);
*/


DROP TRIGGER deleteConta;


DELIMITER $$
CREATE TRIGGER deleteConta
BEFORE DELETE ON conta
FOR EACH ROW
BEGIN
	IF(old.saldo = 0) THEN
		DELETE FROM depositante WHERE fk_cliente_depos = old.id_cliente;
	END IF;
END $$
DELIMITER ;

DELETE FROM conta WHERE id_cliente = 1;


