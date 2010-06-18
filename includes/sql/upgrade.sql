UPDATE `%PRE%config` SET `value` = '1.2.2' WHERE `%PRE%config`.`name` = 'version' AND `%PRE%config`.`value` = '1.2.1' LIMIT 1 ;
UPDATE `%PRE%navbar` SET `visual` = 'Knowledge Base' WHERE `%PRE%navbar`.`link` = 'support' LIMIT 1 ;
UPDATE `%PRE%navbar` SET `icon` = 'report_magnify.png' WHERE `%PRE%navbar`.`icon` = 'monitor.png' LIMIT 1 ;
ALTER TABLE `%PRE%packages` ADD `is_hidden` INT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `%PRE%packages` ADD `is_disabled` INT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `%PRE%users` ADD `firstname` varchar(50) NOT NULL;
ALTER TABLE `%PRE%users` ADD `lastname` varchar(50) NOT NULL;
ALTER TABLE `%PRE%users` ADD `address` varchar(50) NOT NULL;
ALTER TABLE `%PRE%users` ADD `city` varchar(50) NOT NULL;
ALTER TABLE `%PRE%users` ADD `zip` varchar(7) NOT NULL;
ALTER TABLE `%PRE%users` ADD `state` varchar(55) NOT NULL;
ALTER TABLE `%PRE%users` ADD `country` varchar(2) NOT NULL;
ALTER TABLE `%PRE%users` ADD `phone` varchar(15) NOT NULL;
ALTER TABLE `%PRE%users` ADD `status` INT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `%PRE%user_packs` ADD  `username` VARCHAR( 50 ) NOT NULL AFTER `userid`;
INSERT INTO `%PRE%acpnav` (`id` , `visual` , `icon` , `link`) VALUES (20,  'Logs',  'report.png',  'logs');
INSERT INTO `%PRE%clientnav` (`id`, `visual`, `icon`, `link`) VALUES (8, 'Tickets', 'page_white_text.png', 'tickets');
INSERT INTO `%PRE%templates` (`id`, `name`, `acpvisual`, `subject`, `content`, `description`) VALUES (17, 'cancelacc', 'Account Cancelled', 'Cancelled', '<p><span style="font-weight: bold;">Your account has been cancelled!<br /><span style="font-weight: normal;">This now means that your client username and password no longer work and your web hosting package no longer exists. All your files, databases, records have been removed and aren''t retrievable.<br /><br /><span style="font-weight: bold;">Reason for termination: </span>%REASON%</span></span></p>', 'This is the email the client recives when their account has been cancelled by admin or when they manually deleted it in the client control panel.<br /><br />\r\n\r\nEmail Variables:<br />\r\n%REASON% - The reason why their account has been terminated');
CREATE TABLE IF NOT EXISTS `%PRE%users_bak` ( `id` mediumint(9) NOT NULL auto_increment, `user` varchar(50) NOT NULL, `email` varchar(50) NOT NULL, `password` varchar(50) NOT NULL, `salt` varchar(50) NOT NULL, `signup` varchar(20) NOT NULL, `ip` text NOT NULL, `firstname` varchar(50) NOT NULL, `lastname` varchar(50) NOT NULL, `address` varchar(50) NOT NULL, `city` varchar(50) NOT NULL, `zip` varchar(7) NOT NULL,  `state` varchar(55) NOT NULL, `country` varchar(2) NOT NULL, `phone` varchar(15) NOT NULL, `status` varchar(1) NOT NULL default '0', PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
CREATE TABLE IF NOT EXISTS `%PRE%user_packs_bak` (`id` mediumint(9) NOT NULL auto_increment, `userid` varchar(5) NOT NULL, `username` varchar(50) NOT NULL, `domain` varchar(50) NOT NULL, `pid` varchar(5) NOT NULL, `signup` varchar(20) NOT NULL, `status` varchar(1) NOT NULL, `additional` text NOT NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
CREATE TABLE IF NOT EXISTS `%PRE%logs` (`id` mediumint(9) NOT NULL auto_increment, `uid` varchar(5) NOT NULL, `loguser` varchar(50) NOT NULL, `logtime` varchar(20) NOT NULL, `message` text NOT NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
DELETE FROM `%PRE%acpnav` WHERE `id` = 17;
UPDATE `%PRE%templates` SET  `description` =  'This is the email a client gets when they first go though the order form and complete it. This email should contain all they''re details.<br /><br />Template Variables:<br />%USER% - Client Username<br />%PASS% - Client Password<br />%EMAIL% - Client Email<br />%DOMAIN% - The clients package url<br />%PACKAGE% - The package the client signed up for' WHERE  `%PRE%templates`.`id` =3;
UPDATE `%PRE%templates` SET  `description` =  'This is the email a client gets when they first go though the order form and complete it but are awaiting the admin. This email should contain all they''re details.<br /><br />Template Variables:<br />%USER% - Client Username<br />%PASS% - Client Password<br />%EMAIL% - Client Email<br />%DOMAIN% - The clients package url<br />%PACKAGE% - The package the client signed up for' WHERE  `%PRE%templates`.`id` =7;
ALTER TABLE  `%PRE%packages` CHANGE  `name`  `name` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
--Converting all tables and their fields to utf8_general_ci
ALTER TABLE  `%PRE%acpnav` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%acpnav` CHANGE `id` `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT, CHANGE `visual` `visual` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `icon` `icon` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `link` `link` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%articles` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%articles` CHANGE `name` `name` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `content` `content` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%cats` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%cats` CHANGE `name` `name` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `description` `description` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%clientnav` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%clientnav` CHANGE `visual` `visual` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `icon` `icon` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `link` `link` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%config` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%config` CHANGE `name` `name` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `value` `value` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%invoices` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%invoices` CHANGE `due` `due` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `notes` `notes` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `uniqueid` `uniqueid` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%logs` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%logs` CHANGE `uid` `uid` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `loguser` `loguser` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `logtime` `logtime` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `message` `message` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%navbar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%navbar` CHANGE `icon` `icon` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `visual` `visual` VARCHAR(70) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `link` `link` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `%PRE%packages` DEFAULT  CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%packages` CHANGE `name` `name` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `backend` `backend` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `description` `description` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `type` `type` VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `server` `server` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `additional` `additional` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%resources` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%resources` CHANGE `resource_name` `resource_name` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `resource_value` `resource_value` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%servers` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%servers` CHANGE `name` `name` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `host` `host` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `user` `user` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `accesshash` `accesshash` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `type` `type` VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%staff` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%staff` CHANGE `user` `user` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `email` `email` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `name` `name` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `password` `password` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `salt` `salt` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `perms` `perms` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%subdomains` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%subdomains` CHANGE `subdomain` `subdomain` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `server` `server` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%supportnav` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%supportnav` CHANGE `visual` `visual` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `icon` `icon` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `link` `link` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%templates` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%templates` CHANGE `name` `name` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `acpvisual` `acpvisual` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `subject` `subject` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `content` `content` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `description` `description` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%tickets` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%tickets` CHANGE `title` `title` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `content` `content` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `urgency` `urgency` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `time` `time` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%types` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%types` CHANGE `name` `name` VARCHAR(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `visual` `visual` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%users` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%users` CHANGE `user` `user` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `email` `email` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `password` `password` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `salt` `salt` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `signup` `signup` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `%PRE%users` CHANGE `ip` `ip` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `firstname` `firstname` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `lastname` `lastname` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `address` `address` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `city` `city` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `%PRE%users` CHANGE `zip` `zip` VARCHAR(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `state` `state` VARCHAR(55) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `country` `country` VARCHAR(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `phone` `phone` VARCHAR(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%users_bak` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%users_bak` CHANGE `user` `user` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `email` `email` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `password` `password` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `salt` `salt` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `signup` `signup` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `ip` `ip` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `firstname` `firstname` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `lastname` `lastname` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `%PRE%users_bak` CHANGE `address` `address` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `city` `city` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `zip` `zip` VARCHAR(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `state` `state` VARCHAR(55) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `country` `country` VARCHAR(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `phone` `phone` VARCHAR(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `status` `status` VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0';
ALTER TABLE  `%PRE%user_packs` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%user_packs` CHANGE `userid` `userid` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `username` `username` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `domain` `domain` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `pid` `pid` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `signup` `signup` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `status` `status` VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `additional` `additional` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `%PRE%user_packs_bak` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `%PRE%user_packs_bak` CHANGE `userid` `userid` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `username` `username` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `domain` `domain` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `pid` `pid` VARCHAR(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `signup` `signup` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `status` `status` VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, CHANGE `additional` `additional` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
