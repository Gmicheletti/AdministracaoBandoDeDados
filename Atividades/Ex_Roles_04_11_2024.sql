-- Usando o schema da loja informatica
-- apague todos usuarios menos:
/*mysql.infoschema
mysql.session
mysql.sys
root
*/
SELECT user, host FROM mysql.user;
DROP USER 'Cassio'@'localhost',
          'Marlon'@'localhost',
          'ZeIvaldo'@'localhost',
          'JoaoMarcelo'@'localhost',
          'William'@'localhost',
          'JoanaASCII'@'localhost',
          'KarenMouse'@'localhost',
          'TioTeclas'@'%',
          'Teclaudio'
          'RonanAsus'@'localhost',
          'MarcusTeras'@'localhost',
          'aux1'@'localhost',
          'aux2'@'localhost',
          'aux3'@'localhost',
          'aux4'@'localhost',
          'aux5'@'localhost';

# crie 5 roles.
# Role 1
#   apenas select no schema
USE lojainformatica;
CREATE ROLE 'role1'@'localhost';
GRANT SELECT ON lojainformatica.* TO 'role1'@'localhost';
SHOW GRANTS FOR 'role1'@'localhost';

# Role 2
#   apenas insert em clientes e create e drop
CREATE ROLE 'role2'@'localhost';
GRANT INSERT, CREATE, DROP ON lojainformatica.clientes TO 'role2'@'localhost';
SHOW GRANTS FOR 'role2'@'localhost';

# Role 3
#   apenas select no vendas
CREATE ROLE 'role3'@'localhost';
GRANT SELECT ON lojainformatica.vendas TO 'role3'@'localhost';
SHOW GRANTS FOR 'role3'@'localhost';

# Role 4
# apenas select,insert,update e delete no schema
CREATE ROLE 'role4'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON lojainformatica.* TO 'role4'@'localhost';
SHOW GRANTS FOR 'role4'@'localhost';

# Role 5
#   apenas upadate em vendas
CREATE ROLE 'role5'@'localhost';
GRANT UPDATE ON lojainformatica.vendas TO 'role5'@'localhost';
SHOW GRANTS FOR 'role5'@'localhost';

# Crie 10 usuarios
# aplique os roles aos usuario como quiser

CREATE USER 'Rosangela'@'localhost' IDENTIFIED BY '123456';
GRANT 'role5'@'localhost' TO 'Rosangela'@'localhost';
SET DEFAULT ROLE 'role5'@'localhost' TO 'Rosangela'@'localhost';
SHOW GRANTS FOR 'Rosangela'@'localhost';

CREATE USER 'Antonio'@'localhost' IDENTIFIED BY '89564';
GRANT 'role1'@'localhost' TO 'Antonio'@'localhost';
SET DEFAULT ROLE 'role1'@'localhost' TO 'Antonio'@'localhost';
SHOW GRANTS FOR 'Antonio'@'localhost';

CREATE USER 'GabriellaM'@'localhost' IDENTIFIED BY '654651';
GRANT 'role2'@'localhost' TO 'GabriellaM'@'localhost';
SET DEFAULT ROLE 'role2'@'localhost' TO 'GabriellaM'@'localhost';
SHOW GRANTS FOR 'GabriellaM'@'localhost';

CREATE USER 'Michel'@'localhost' IDENTIFIED BY '123456';
GRANT 'role4'@'localhost' TO 'Michel'@'localhost';
SET DEFAULT ROLE 'role4'@'localhost' TO 'Michel'@'localhost';
SHOW GRANTS FOR 'Michel'@'localhost';

CREATE USER 'Erick'@'localhost' IDENTIFIED BY '888888';
GRANT 'role2'@'localhost' TO 'Erick'@'localhost';
SET DEFAULT ROLE 'role2'@'localhost' TO 'Erick'@'localhost';
SHOW GRANTS FOR 'Erick'@'localhost';

CREATE USER 'GabriellaL'@'localhost' IDENTIFIED BY '698621';
GRANT 'role3'@'localhost' TO 'GabriellaL'@'localhost';
SET DEFAULT ROLE 'role3'@'localhost' TO 'GabriellaL'@'localhost';
SHOW GRANTS FOR 'GabriellaL'@'localhost';

CREATE USER 'Marley'@'localhost' IDENTIFIED BY '564512';
GRANT 'role3'@'localhost', 'role1'@'localhost' TO 'Marley'@'localhost';
SET DEFAULT ROLE 'role3'@'localhost', 'role1'@'localhost' TO 'Marley'@'localhost';
SHOW GRANTS FOR 'Marley'@'localhost';

CREATE USER 'Luna'@'localhost' IDENTIFIED BY '654946';
GRANT 'role3'@'localhost' TO 'Luna'@'localhost';
SET DEFAULT ROLE 'role3'@'localhost' TO 'Luna'@'localhost';
SHOW GRANTS FOR 'Luna'@'localhost';

CREATE USER 'Lola'@'localhost' IDENTIFIED BY '55555';
GRANT 'role1'@'localhost' TO 'Lola'@'localhost';
SET DEFAULT ROLE 'role1'@'localhost' TO 'Lola'@'localhost';
SHOW GRANTS FOR 'Lola'@'localhost';

CREATE USER 'Spike'@'localhost' IDENTIFIED BY '444444';
GRANT 'role5'@'localhost' TO Spike'@'localhost';
SET DEFAULT ROLE 'role5'@'localhost' TO Spike'@'localhost';
SHOW GRANTS FOR 'Spike'@'localhost';

# revogue os privilegios de select do role1 e insira create e drop 

REVOKE SELECT ON lojainformatica.* FROM 'role1'@'localhost';
GRANT INSERT, DROP ON lojainformatica.* TO 'role1'@'localhost';
SHOW GRANTS FOR 'role1'@'localhost';




