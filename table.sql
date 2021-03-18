CREATE DATABASE IF NOT EXISTS woofing;
USE woofing;

CREATE TABLE IF NOT EXISTS host_user (
    id INT NOT NULL AUTO_INCREMENT,
    activity_type VARCHAR(256),
    location_type VARCHAR(256),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS user (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(64),
    password VARCHAR(64),
    host_user_id INT,
    xp INT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE user ADD CONSTRAINT fk_user_host FOREIGN KEY (host_user_id) REFERENCES host_user(id);

CREATE TABLE IF NOT EXISTS address (
    id INT NOT NULL AUTO_INCREMENT,
    street_number VARCHAR(64),
    street VARCHAR(128),
    city VARCHAR(128),
    city_code VARCHAR(16),
    country VARCHAR (64),
    host_user_id INT,
    PRIMARY KEY (id, host_user_id)
);

ALTER TABLE address ADD CONSTRAINT fk_adress_host FOREIGN KEY (host_user_id) REFERENCES host_user(id);

CREATE TABLE IF NOT EXISTS work_site (
    id INT NOT NULL AUTO_INCREMENT,
    capacity INT,
    address_id INT NOT NULL,
    user_id INT,
    host_user_id INT,
    xp_given INT,
    PRIMARY KEY (id, address_id, host_user_id)
);

ALTER TABLE work_site ADD CONSTRAINT fk_work_site_host FOREIGN KEY (host_user_id) REFERENCES host_user(id);
ALTER TABLE work_site ADD CONSTRAINT fk_work_site_adress FOREIGN KEY (address_id) REFERENCES address(id);

CREATE TABLE IF NOT EXISTS inscription (
    id INT NOT NULL AUTO_INCREMENT,
    validated BINARY,
    work_site_id INT,
    user_id INT,
    PRIMARY KEY (id, user_id)
);

ALTER TABLE inscription ADD CONSTRAINT fk_inscription_work_site FOREIGN KEY (work_site_id) REFERENCES work_site(id);
ALTER TABLE inscription ADD CONSTRAINT fk_inscription_user FOREIGN KEY (user_id) REFERENCES user(id);

CREATE TABLE IF NOT EXISTS woofing (
    id INT NOT NULL AUTO_INCREMENT,
    work_description VARCHAR(256),
    xp_given INT,
    user_id INT NOT NULL,
    host_user_id INT NOT NULL,
    address_id INT,
    PRIMARY KEY (id, user_id, host_user_id)
);

ALTER TABLE woofing ADD CONSTRAINT fk_woofing_user FOREIGN KEY (user_id) REFERENCES user(id);
ALTER TABLE woofing ADD CONSTRAINT fk_woofing_host_user FOREIGN KEY (host_user_id) REFERENCES host_user(id);
ALTER TABLE woofing ADD CONSTRAINT fk_woofing_address FOREIGN KEY (address_id) REFERENCES address(id);

CREATE TABLE IF NOT EXISTS activity (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(64),
    description VARCHAR(256),
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS level (
    id INT NOT NULL AUTO_INCREMENT,
    xp INT,
    level INT,
    activity_id INT,
    user_id INT,
    PRIMARY KEY(id, activity_id, user_id)
);

ALTER TABLE level ADD CONSTRAINT fk_level_activity FOREIGN KEY (activity_id) REFERENCES activity(id);
ALTER TABLE level ADD CONSTRAINT fk_level_user FOREIGN KEY (user_id) REFERENCES user(id);

CREATE TABLE IF NOT EXISTS inscription_has_activity (
    inscription_id INT,
    activity_id INT,
    PRIMARY KEY (inscription_id, activity_id)
);

ALTER TABLE inscription_has_activity ADD CONSTRAINT fk_inscription_has_activity_inscription FOREIGN KEY (inscription_id) REFERENCES inscription(id);
ALTER TABLE inscription_has_activity ADD CONSTRAINT fk_inscription_has_activity_acitivity FOREIGN KEY (activity_id) REFERENCES activity(id);

CREATE TABLE IF NOT EXISTS activity_has_woofing (
    activity_id INT,
    woofing_id INT,
    PRIMARY KEY (activity_id, woofing_id)
);

ALTER TABLE activity_has_woofing ADD CONSTRAINT fk_activity_has_woofing_activity FOREIGN KEY (activity_id) REFERENCES activity(id);
ALTER TABLE activity_has_woofing ADD CONSTRAINT fk_activity_has_woofing_woofing FOREIGN KEY (woofing_id) REFERENCES woofing(id);