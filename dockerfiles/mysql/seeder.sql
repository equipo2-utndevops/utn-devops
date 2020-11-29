-- Establish db_test data base
create database `db_devops` default character set utf8 collate utf8_general_ci;
 
use db_devops;
 
-- Create team_members tables
DROP TABLE IF EXISTS `team_members`;


CREATE TABLE `team_members` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `team_members` (`id`, `nombre`) VALUES
(1, 'Alejandro Barrios'),
(2, 'Daniel Katib'),
(3, 'Facundo Juarez'),
(4, 'Gabriela Bejarano'),
(5, 'Javier Altszyler'),
(6, 'Jesus Rodriguez'),
(7, 'Leonardo Manucci'),
(8, 'Maximiliano Florentin'),
(9, 'Sebastian Ayale');

ALTER TABLE `team_members` ADD PRIMARY KEY (`id`);

ALTER TABLE `team_members`  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

