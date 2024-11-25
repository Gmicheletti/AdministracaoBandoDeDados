------------- SELECT ------------------
-- Lista todos os usuários criados no Mysql
SELECT user from mysql.user;

-- Lista os usuários e o acessos
-- 'usuario'@'localhost' = acesso local
-- 'usuario'@'%' = acesso remoto
SELECT user,host from mysql.user;

-- Lista os usuários e todos os seus privilégios
SELECT * from mysql.user;

-- Lista o nome do usuário logado
SELECT user();


------------- CREATE ------------------
-- Cria um usuario com senha no servidor com acesso local
CREATE USER 'Ana'@'localhost' IDENTIFIED BY '1234';

-- Cria um usuario com senha no servidor com acesso remoto
CREATE USER 'Ana'@'%' IDENTIFIED BY '1234';
-- OU
CREATE USER 'Ana' IDENTIFIED BY '1234';

-- Cria um usuario sem senha
CREATE USER 'Ana'@'localhost'; -- Acesso local
CREATE USER 'Ana'@'%'; -- Acesso remoto
CREATE USER 'Ana'; -- Acesso remoto

-- Cria multiplos usuarios com senha randomica
CREATE USER 
    'user1'@'localhost' IDENTIFIED BY RANDOM PASSWORD, -- Acesso local
    'user2'@'%' IDENTIFIED BY RANDOM PASSWORD, -- Acesso remoto
    'user3' IDENTIFIED BY RANDOM PASSWORD; -- Acesso remoto


------------- DROP (DELETE) ------------------
DROP USER 'maria'@'localhost';


------------- RENAME ------------------
RENAME USER 'maria'@'localhost' TO 'maria_silva'@'localhost'; -- Acesso local
RENAME USER 'maria'@'%' TO 'maria_silva'@'%'; -- Acesso remoto
RENAME USER 'maria' TO 'maria_silva'; -- Acesso remoto


------------- SENHAS ------------------
-- Para inserir uma senha para um usuário criado sem senha ou para alterar a senha de um usuário, o comando é o mesmo
ALTER USER 'maria'@'localhost' IDENTIFIED BY  '123123';

-- Alterando para varios usuarios
ALTER USER 
    'user1'@'localhost' IDENTIFIED BY '111', -- Acesso local
    'user2'@'%' IDENTIFIED BY '222', -- Acesso remoto
    'user3' IDENTIFIED BY '333'; -- Acesso remoto

-- Senha expira em 90 dias
CREATE USER 'gui'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'gui'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY; 

-- Senha nunca expira
CREATE USER 'gui'@'localhost' PASSWORD EXPIRE NEVER;
ALTER USER 'gui'@'localhost' PASSWORD EXPIRE NEVER;

-- Define como default o tempo que a senha expira
CREATE USER 'gui'@'localhost' PASSWORD EXPIRE DEFAULT;
ALTER USER 'gui'@'localhost' PASSWORD EXPIRE DEFAULT; 

-- Não pode reutilizar as utlimas 5 senhas utilizadas
CREATE USER 'gui'@'localhost' PASSWORD HISTORY 5;
ALTER USER 'gui'@'localhost' PASSWORD HISTORY 5;

-- Não pode reutilizar uma senha dentro de 365 dias
CREATE USER 'gui'@'localhost' PASSWORD REUSE INTERVAL 365 DAY;
ALTER USER 'gui'@'localhost' PASSWORD REUSE INTERVAL 365 DAY;

-- Para alterar a senha, deverá inserir a senha atual
CREATE USER 'gui'@'localhost' PASSWORD REQUIRE CURRENT;
ALTER USER 'gui'@'localhost' PASSWORD REQUIRE CURRENT;

-- Para alterar a senha, inserir a senha atual é opcional
CREATE USER 'gui'@'localhost' PASSWORD REQUIRE CURRENT OPTIONAL;
ALTER USER 'gui'@'localhost' PASSWORD REQUIRE CURRENT OPTIONAL;

-- Número de 5 tentativas de login e bloqueio de 5 dias
CREATE USER 'gui'@'localhost' IDENTIFIED BY '123456'
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 5;