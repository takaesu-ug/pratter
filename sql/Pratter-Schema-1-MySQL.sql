-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Tue Dec 25 01:29:45 2012
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `follow`;

--
-- Table: `follow`
--
CREATE TABLE `follow` (
  `id` BIGINT unsigned NOT NULL auto_increment,
  `user_id` BIGINT unsigned NOT NULL DEFAULT 0,
  `target_user_id` BIGINT unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  INDEX (`user_id`),
  INDEX (`target_user_id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;

DROP TABLE IF EXISTS `tweet`;

--
-- Table: `tweet`
--
CREATE TABLE `tweet` (
  `id` BIGINT unsigned NOT NULL auto_increment,
  `user_id` BIGINT unsigned NOT NULL DEFAULT 0,
  `body` VARCHAR(150) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  INDEX (`user_id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;

DROP TABLE IF EXISTS `user`;

--
-- Table: `user`
--
CREATE TABLE `user` (
  `id` BIGINT unsigned NOT NULL auto_increment,
  `name` VARCHAR(255) NOT NULL,
  `pass` VARCHAR(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  INDEX (`name`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;

SET foreign_key_checks=1;

CREATE TABLE IF NOT EXISTS `dbix_class_schema_versions` (`version` varchar(10) NOT NULL, `installed` varchar(20) NOT NULL, PRIMARY KEY (`version`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8; 
INSERT INTO dbix_class_schema_versions (version, installed) VALUES (1, 'v20121225_012945.000');