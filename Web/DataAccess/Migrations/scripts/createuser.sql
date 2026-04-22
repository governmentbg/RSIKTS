DROP USER 'tbsoft2019'@'localhost' ;

CREATE USER 'tbsoft2019'@'localhost' IDENTIFIED BY 'P@ssw0rd01';

GRANT ALL PRIVILEGES ON * . * TO 'tbsoft2019'@'localhost';

FLUSH PRIVILEGES;