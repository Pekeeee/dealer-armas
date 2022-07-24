INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_vendeur','traficante de armas',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_vendeur','traficante de armas',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_vendeur', 'traficante de armas', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('vendeur', 'traficante de armas', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('vendeur', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('vendeur', 1, 'capo', 'Obrero', 400, 'null', 'null'),
('vendeur', 2, 'consigliere', 'Ayudante', 600, 'null', 'null'),
('vendeur', 3, 'boss', 'Jefe', 1000, 'null', 'null');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 
('metaux', 'Metal', '100', '0', '1'), 
('canon', 'Cañon', '100', '0', '1'),
('meche', 'Mecha', '100', '0', '1'),
('mapa', 'Mapa', '1', '0', '1'),
('levier', 'Gatillo', '100', '0', '1');