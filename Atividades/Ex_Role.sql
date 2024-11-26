-- Atividade - ROLES
-- 5 usuarios locais com senha.

CREATE USER 'Cassio'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'Marlon'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'ZeIvaldo'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'JoaoMarcelo'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'William'@'localhost' IDENTIFIED BY '123456';

-- 5 Roles diferentes usando qualquer nome.

CREATE ROLE 'aux1'@'localhost',
            'aux2'@'localhost', 
            'aux3'@'localhost', 
            'aux4'@'localhost', 
            'aux5'@'localhost'; 

-- Aplique 5 privilegios diferentes em cada role cada usuario criado deve ter um role.

GRANT SELECT, INSERT ON lojainformatica.clientes TO 'aux1'@'localhost';
SHOW GRANTS FOR 'aux1'@'localhost';

GRANT SELECT ON lojainformatica.produtos TO 'aux2'@'localhost';
SHOW GRANTS FOR 'aux2'@'localhost';

GRANT INSERT ON lojainformatica.produtos TO 'aux3'@'localhost';
SHOW GRANTS FOR 'aux3'@'localhost';

GRANT SELECT ON lojainformatica.* TO 'aux4'@'localhost';
SHOW GRANTS FOR 'aux4'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON lojainformatica.produtos TO 'aux5'@'localhost';
SHOW GRANTS FOR 'aux5'@'localhost';

-- crie um usuario chamado Admin que tenha acesso a todos os roles criados.

CREATE USER 'Admin'@'localhost' IDENTIFIED BY '123456';

GRANT 'aux1'@'localhost',
      'aux2'@'localhost',
      'aux3'@'localhost',
      'aux4'@'localhost',
      'aux5'@'localhost' TO 'admin'@'localhost';

SHOW GRANTS FOR 'admin'@'localhost';
