USE woofing;
DELIMITER $$

-- Ajouter des données

CREATE OR REPLACE PROCEDURE add_new_user(user_name VARCHAR(64), pwd VARCHAR(64))
BEGIN
    INSERT INTO user(username, password, xp) VALUES (user_name, pwd, 0);
END

CREATE OR REPLACE PROCEDURE add_new_host(activity_t VARCHAR(256), location_t VARCHAR(256), user_id)
-- Rechercher un chantier :

-- Rechercher un chantier en fonction de la date

CREATE OR REPLACE PROCEDURE search_worksite_by_date(IN min_date DATE)
BEGIN
    SELECT * FROM work_site WHERE starting_date >= min_date;
END $$

-- Rechercher un chantier en fonction des activitées proposé (recherche par host)

CREATE OR REPLACE PROCEDURE search_workiste_by_host_user(IN host_id INT)
BEGIN
    SELECT * FROM work_site WHERE host_user_id=host_id;
END $$

-- Rechercher un chantier en fonction de l'exp donnée

CREATE OR REPLACE PROCEDURE search_worksite_by_xp()
BEGIN
    SELECT * FROM work_site ORDER BY xp_given DESC;
END $$

DELIMITER ;