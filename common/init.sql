CREATE DATABASE sequenzia COLLATE utf8_general_ci;

CREATE USER IF NOT EXISTS 'moe'@'%' IDENTIFIED WITH mysql_native_password BY 'imouto';

GRANT ALL ON *.* TO 'moe'@'%';
FLUSH PRIVILEGES;
