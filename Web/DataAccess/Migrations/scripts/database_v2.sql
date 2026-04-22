-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия на сървъра:            10.1.38-MariaDB - mariadb.org binary distribution
-- ОС на сървъра:                Win64
-- HeidiSQL Версия:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дъмп на структурата на БД votingregister
CREATE DATABASE IF NOT EXISTS `votingregister` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `votingregister`;

-- Дъмп структура за таблица votingregister.aspnetroleclaims
CREATE TABLE IF NOT EXISTS `aspnetroleclaims` (
  `Id` int(11) NOT NULL,
  `RoleId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ClaimType` longtext COLLATE utf8_unicode_ci,
  `ClaimValue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetroleclaims: ~0 rows (приблизително)
DELETE FROM `aspnetroleclaims`;
/*!40000 ALTER TABLE `aspnetroleclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetroleclaims` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetroles
CREATE TABLE IF NOT EXISTS `aspnetroles` (
  `Id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NormalizedName` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ConcurrencyStamp` longtext COLLATE utf8_unicode_ci,
  `Discriminator` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetroles: ~3 rows (приблизително)
DELETE FROM `aspnetroles`;
/*!40000 ALTER TABLE `aspnetroles` DISABLE KEYS */;
INSERT INTO `aspnetroles` (`Id`, `Name`, `NormalizedName`, `ConcurrencyStamp`, `Discriminator`) VALUES
	('026d07a6-ae81-45a6-a01e-0b0d48232352', 'Администратор', 'АДМИНИСТРАТОР', 'f304cea6-6a16-4a37-af25-23ced85a0f20', NULL),
	('6364ca55-a3e9-4919-a1b6-9a6d0634e711', 'ОИК/РИК', 'ОИК/РИК', 'fdeb3337-ccbf-47c1-a38c-69fec9c54723', NULL),
	('d6a22e53-3f5d-4cd4-90bf-30f7d77fee20', 'Оператор', 'ОПЕРАТОР', '4a4bd877-7fa3-4312-8252-c7a4f1d3a61e', NULL);
/*!40000 ALTER TABLE `aspnetroles` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetuserclaims
CREATE TABLE IF NOT EXISTS `aspnetuserclaims` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ClaimType` longtext COLLATE utf8_unicode_ci,
  `ClaimValue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetuserclaims: ~0 rows (приблизително)
DELETE FROM `aspnetuserclaims`;
/*!40000 ALTER TABLE `aspnetuserclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserclaims` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetuserlogins
CREATE TABLE IF NOT EXISTS `aspnetuserlogins` (
  `LoginProvider` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ProviderKey` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ProviderDisplayName` longtext COLLATE utf8_unicode_ci,
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetuserlogins: ~0 rows (приблизително)
DELETE FROM `aspnetuserlogins`;
/*!40000 ALTER TABLE `aspnetuserlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserlogins` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetuserroles
CREATE TABLE IF NOT EXISTS `aspnetuserroles` (
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `RoleId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetuserroles: ~22 rows (приблизително)
DELETE FROM `aspnetuserroles`;
/*!40000 ALTER TABLE `aspnetuserroles` DISABLE KEYS */;
INSERT INTO `aspnetuserroles` (`UserId`, `RoleId`) VALUES
	('0264cf8d-1437-405e-981b-e4c161b91e0a', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('0d7bc87d-69bb-4b6d-a0bb-7f64eeb05ccf', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('28a78b41-8cb0-41ed-aaab-3996de19f747', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('2af4ccff-d3ae-43f8-8faa-5f4f22a2ce1f', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('305ac9e7-8a94-43d3-9233-040d21c6dbc9', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('3c64a971-e74f-4ce8-910a-5cf3a84212e9', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('3d391af3-d54b-438a-a4f8-3b36b4bb1f3f', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('452e5f44-3599-4940-9e64-e2437b7e5bc4', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('46e85934-8386-46ed-9b14-bb77ca5694d6', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('530f5e77-5371-45a4-9dd2-9e08395bcf57', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('600651e3-c3c8-433a-8b19-36785eb562fa', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('7780fe39-6cf5-4955-82d8-9226050679f0', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('78752568-4ac7-4809-8eab-491a00c3bb9c', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('7b33da3b-8347-47cc-b7c5-7f4340d81bce', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('881d7629-e62b-4142-981f-aac7016f538d', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('987577a2-5ca1-4cad-bae0-df58a3598cbb', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('a4905182-408b-4afd-850c-ffe46d0157b7', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('c5fdb7ed-ab63-47b1-bf76-b67847378bbc', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('e4a646df-ea45-4501-94cd-b9766bcc77c6', '6364ca55-a3e9-4919-a1b6-9a6d0634e711'),
	('edd2e70d-b73b-4bd9-a75c-748ed81b464b', '026d07a6-ae81-45a6-a01e-0b0d48232352'),
	('f1b51a37-1200-43be-bd17-2a9926e07e5e', 'd6a22e53-3f5d-4cd4-90bf-30f7d77fee20'),
	('f7ab7308-5809-41eb-a587-c926412631f7', '026d07a6-ae81-45a6-a01e-0b0d48232352');
/*!40000 ALTER TABLE `aspnetuserroles` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetusers
CREATE TABLE IF NOT EXISTS `aspnetusers` (
  `Id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `UserName` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NormalizedUserName` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NormalizedEmail` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EmailConfirmed` bit(1) NOT NULL,
  `PasswordHash` longtext COLLATE utf8_unicode_ci,
  `SecurityStamp` longtext COLLATE utf8_unicode_ci,
  `ConcurrencyStamp` longtext COLLATE utf8_unicode_ci,
  `PhoneNumber` longtext COLLATE utf8_unicode_ci,
  `PhoneNumberConfirmed` bit(1) NOT NULL,
  `TwoFactorEnabled` bit(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` bit(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `Discriminator` longtext COLLATE utf8_unicode_ci,
  `Administrative_Rajon` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ot_Partiq` int(5) DEFAULT NULL,
  `Names` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `FK_aspnetusers_wntoa_RajonNkod` (`Administrative_Rajon`),
  KEY `EmailIndex` (`NormalizedEmail`(255)),
  KEY `FK_aspnetusers_sila_PartiqIdParty` (`Ot_Partiq`),
  CONSTRAINT `FK_aspnetusers_sila_PartiqIdParty` FOREIGN KEY (`Ot_Partiq`) REFERENCES `wnsila` (`ID_Party`),
  CONSTRAINT `FK_aspnetusers_wntoa_RajonNkod` FOREIGN KEY (`Administrative_Rajon`) REFERENCES `wntoa` (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetusers: ~22 rows (приблизително)
DELETE FROM `aspnetusers`;
/*!40000 ALTER TABLE `aspnetusers` DISABLE KEYS */;
INSERT INTO `aspnetusers` (`Id`, `UserName`, `NormalizedUserName`, `Email`, `NormalizedEmail`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `ConcurrencyStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEnd`, `LockoutEnabled`, `AccessFailedCount`, `Discriminator`, `Administrative_Rajon`, `Ot_Partiq`, `Names`) VALUES
	('0264cf8d-1437-405e-981b-e4c161b91e0a', 'user_ban', 'USER_BAN', 'trbien@abv.bg', 'TRBIEN@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEEMEsdKaucUKiDjJIETkKpjjAZkx6BXDKcjE7iJ8iwEPunVOttsOS/VCm1J3wrtQUw==', 'RRSMHQSNYCKSUBXGDSDYF2F67E6PUPSD', '2582afd9-fec9-416c-b43b-319274fd662d', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '24', NULL, 'Н Н Н'),
	('0d7bc87d-69bb-4b6d-a0bb-7f64eeb05ccf', 'edimitrova', 'EDIMITROVA', 'user1@sso.bg', 'USER1@SSO.BG', b'0', 'AQAAAAEAACcQAAAAEDdasuVhGInZ2zIYNh88GrlbKr1p4xvLBeMTcTAU2qIK8ZHc5x/Oke5LH3NdPexlQA==', '6CQD34B4YOVQNAW35OFE6753RBK2BZ3D', '93ff8b9d-acb7-41dc-838c-f2060a9c863e', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Емилия Димитрова'),
	('28a78b41-8cb0-41ed-aaab-3996de19f747', 'rambol', 'RAMBOL', 'test4@test', 'TEST4@TEST', b'0', 'AQAAAAEAACcQAAAAEBnZgsnYevI26wq4gavgxe3t/Y5a7ZJK0ifPLTngkAeUQ3ba8xMa62KDuITRu3CsZA==', 'MHY77UQB453XTHQCMMV4JQF3RDQUHVEP', '32f9ea40-e206-414d-8555-6b43ede1e4aa', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '23', NULL, 'Лачко Лачев Мачев'),
	('2af4ccff-d3ae-43f8-8faa-5f4f22a2ce1f', 'user_vz', 'USER_VZ', 'Raro@abv.bg', 'RARO@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEOqoASaKB4E/xghVxVPvIP1m2MTAkATqeNcEUIkyu5eT387CcTcAlYiU3mmSjsTeew==', 'OL37UFOFFG5JBR4SGDLII62H4DPCAHYX', '1f2e9642-fa55-45e6-a131-b69226fda9d8', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '03', NULL, 'Калинка Шопова Каракостова'),
	('305ac9e7-8a94-43d3-9233-040d21c6dbc9', 'Test_vzr', 'TEST_VZR', 'Testop@abv.bg', 'TESTOP@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEB/AUH+6L+VSM7QehMJmDrEvDt+eRTdlkY5qRlfm+67XBNyY21b9Rlh1t0EbfcFeEw==', 'D2A6PWELZ7I5IX5XJUJ3A6ZBLN2FYCEC', 'a4c3c554-c49d-4c34-a80e-498ff8d51bb6', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Оператор ВЗР'),
	('3c64a971-e74f-4ce8-910a-5cf3a84212e9', 'mpramatarova', 'MPRAMATAROVA', 'pramatarova_maria@hotmail.com', 'PRAMATAROVA_MARIA@HOTMAIL.COM', b'0', 'AQAAAAEAACcQAAAAEIih8XImvNNzJ/GJjdOSEGesU96RJGqtoaW/7+0j545pId9cxTYSqRLJDPTVsh1JGg==', 'PNZSIEHTS7XXU3Y632H2L64WGLVTUFH4', '9f65dc36-95a7-4e12-9100-d6b5bc0cb476', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Мария Петрова Праматарова - ОИК'),
	('3d391af3-d54b-438a-a4f8-3b36b4bb1f3f', 'dgerasimova', 'DGERASIMOVA', 'd_gerasimova@sofia.bg', 'D_GERASIMOVA@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEB6JVm8s9Rd13vEUo5DiHDNYWoFUUaZvlNVlpn8WgEhrJdgteLl6PPsqIlpgVwuVhQ==', '3VMRKHAUNQDS5TFBJREFJLM2CH3DBZU7', '072b30c5-3e23-4934-8f12-00d1f986d199', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Димитрина Герасимова'),
	('452e5f44-3599-4940-9e64-e2437b7e5bc4', 'krasi99', 'KRASI99', 'krassimir.kirilov@gmail.com', 'KRASSIMIR.KIRILOV@GMAIL.COM', b'0', 'AQAAAAEAACcQAAAAEFFcVBDnqwO9UYX3SOcwChnKtAcE8MhtUR7DM4X1jV2HgUzoj6+D2OC4ah0Zh/cOFA==', 'N5WHGLX75JU6BHASCQDM5QQA5C6UBFY3', 'f4de0343-6756-49cf-8a05-b02451c39b32', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '02', NULL, 'Krasimir'),
	('46e85934-8386-46ed-9b14-bb77ca5694d6', 'dsokolova', 'DSOKOLOVA', 'd.sokolova@sofia.bg', 'D.SOKOLOVA@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEOxseNqXEOzol38VsqTOs1ei3WuytvkD8DKnMX5+YJ57eEsmVaM3RGFqMfMnvVGoJQ==', 'O734BHLJD2PVLASHMY7YJCPYLPP3S24J', '86d7b254-8b5b-4e32-be4e-4c540a835eab', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '12', NULL, 'Даниела Георгиева Соколова'),
	('530f5e77-5371-45a4-9dd2-9e08395bcf57', 'ylubomirova', 'YLUBOMIROVA', 'apon_slatina@so-slatina.org', 'APON_SLATINA@SO-SLATINA.ORG', b'0', 'AQAAAAEAACcQAAAAEPrCY2Z/ZgSyTgfGeKYF6bHSMZCZr5SQ/ZcDuFfCQqneAYAeiADZMS+rGIBHlggrnA==', 'WWUIOAFQXYLLJBHJYXJLG3KNKINMATTH', '6e577b78-b8a5-43ba-9bd9-c48817bdab8e', '0887383744', b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '07', NULL, 'Янка Любомирова'),
	('600651e3-c3c8-433a-8b19-36785eb562fa', 'anikolova', 'ANIKOLOVA', 'nikol_ad@abv.bg', 'NIKOL_AD@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEA7NBS5L0iWo4Q9N41H1qix1iq75rTgj4cfWS2IGKPgrZU4CM0PKFS8CNqiqeotDkg==', '5BMRRZ57GGEDG4HNJWKY35D7DY2CYXHX', 'adf5562e-da0d-47fd-85e3-344d025c9249', '0888441463', b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '01', NULL, 'Анна Николова'),
	('7780fe39-6cf5-4955-82d8-9226050679f0', 'user_srd', 'USER_SRD', 'bam@abv.bg', 'BAM@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEE0lTm80zT5QePM1hxkRMwAI1NPDsyOe3xg1C4mjWwMHRtbuhuhc7tiYZ6pO2Ttc2Q==', 'H3GAKYHMW3XMX2IIHSXXDMZKXFY44U6V', '5a850c19-c7eb-48a9-bb24-467130f6187c', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '01', NULL, 'Трендафил И Тотков'),
	('78752568-4ac7-4809-8eab-491a00c3bb9c', 'krasi66', 'KRASI66', 'krassimir_kirilov@abv.bg', 'KRASSIMIR_KIRILOV@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEHo6i6Qjt0kSCcP5si/O2f5Yf9nP9XH5HdoaaIs37tGak9yiln1AuVM6CtjiaMmumQ==', 'YDB2WGUJO3RGVCKRFAOTDHCALWN3XTIY', '02191888-5a6f-459d-b1be-1a868b2fcca3', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Красимир Стоянов'),
	('7b33da3b-8347-47cc-b7c5-7f4340d81bce', 'mechopuh', 'MECHOPUH', 'user3@sso.bg', 'USER3@SSO.BG', b'0', 'AQAAAAEAACcQAAAAEOeV5QU3tz2MDUQEa6GBLq/+ZVMrrjm1K9Bhzmnt+/PYWcvoj1+6G2zc5mLTikCQHQ==', '6D5YNTUWPX2P7KXP47Z6LM2BLCHCQA5U', 'f6b0eaca-6416-42f9-baa8-153c7bd300cc', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Николай Ковачев'),
	('881d7629-e62b-4142-981f-aac7016f538d', 'bmileva_krs', 'BMILEVA_KRS', 'KRS@abv.bg', 'KRS@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEAlF+MGzyFJ87zDlvfXhvOMYSAf1Ne1G0sTVsPi/9YBgilEg4kM1cmaXvpnbcYOtww==', 'CIJ2P2CPKQRCYVSJH7MNDLS2IHW4GGXG', '71814513-7ace-4a24-b7ad-e65bb5e88d41', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '02', NULL, 'Бойка Милева - KRS'),
	('987577a2-5ca1-4cad-bae0-df58a3598cbb', 'mtaseva', 'MTASEVA', 'mtasseva@abv.bg', 'MTASSEVA@ABV.BG', b'0', 'AQAAAAEAACcQAAAAEMfWcX0jRWJUMOATPGyG7MGcmUgqRMqer2z5zO/QantIKyRHifh361oyVSwCP+C4gQ==', 'RW22XJVDGO4H7VXG2GOA6UT7OPJZL4PL', '645c5b66-6804-4d83-b421-a3911ee5b335', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', '19', NULL, 'Мара Тасева'),
	('a4905182-408b-4afd-850c-ffe46d0157b7', 'bmileva', 'BMILEVA', 'b.mileva@sofia.bg', 'B.MILEVA@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEMAwC5KpB9Y7QqA6TgKadPN9QBGwOc3Dg8CcXXQbqjPqN3LeBOQTrDrLoHtVxC3x/A==', 'KFSB7CCZDO7U5L2PVP2CJFYDGXEPY36D', '5c2fffd8-f198-4d04-b656-2c2f5a598b97', '9377 347', b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Бойка Милева'),
	('c5fdb7ed-ab63-47b1-bf76-b67847378bbc', 'ynikodimova', 'YNIKODIMOVA', 'y.nikodimova@sofia.bg', 'Y.NIKODIMOVA@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEGL0Bmho7/vJvHbQOyFN6nleaCJg3/uZcx7i+btdvSD6KfCDaGar9dqRVgmT91Tt4g==', 'P6YERFO6NGQ5JJPKHLOS7RQ6NIMYJIRA', '8299a2a0-c244-48b5-a596-f07ba2c342e5', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Янка Никодимова'),
	('e4a646df-ea45-4501-94cd-b9766bcc77c6', 'test11', 'TEST11', 'test11@test.bg', 'TEST11@TEST.BG', b'0', 'AQAAAAEAACcQAAAAEItTOeg1tKpweuqgAGjN1GNh7vTr5nhzuXR7RQlBjhzLy9RqlHQPf/I4KvsnLV7Q9w==', 'NJSOYS5I6XJ2WZJY3APJDHUFRF6VWRUU', 'adde8782-6d81-4e6d-a2e7-63dda412837d', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, 1, 'test11'),
	('edd2e70d-b73b-4bd9-a75c-748ed81b464b', 'administrator', 'ADMINISTRATOR', 'n.kovachev@sofia.bg', 'N.KOVACHEV@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEOztCXwP1+Ljocd3OsultpHOqs3FIhoVukjNHa3UolBQrPVtLgtaLmMVlcrsZrxu7Q==', 'UONBUJ4PGWWFIQOTIMWAEUVCZLKEZNFA', '93c44d81-828a-4de4-874a-8b93bba0e888', '1111111111', b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Николай Ковачев'),
	('f1b51a37-1200-43be-bd17-2a9926e07e5e', 'gloper', 'GLOPER', 'T@sofia.bg', 'T@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAELk5qGs6xYUWJBbDJMy76mZt51iuejew1tL9WeTln0c9XwYx5l93wM10aAzzU3mKyA==', '2VJEOS2FEHKVXPII5GOK7VOJSPMJZ2KF', '3dbc49b4-f125-4f91-a5a4-0a3d2be43e21', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Глобале Оператор'),
	('f7ab7308-5809-41eb-a587-c926412631f7', 'venera', 'VENERA', 'v.milova@sofia.bg', 'V.MILOVA@SOFIA.BG', b'0', 'AQAAAAEAACcQAAAAEEnvx2OoWHXplkI+A+SNaMzGWJEy2a0o/7/7ba4HfEzic26CrEv0D+GLQYRW1akOdg==', 'K3RT7HUFMQIF23Q4UN6KUOYRWP7VASUK', '537e5cb3-21e7-40d9-84f7-5e7527029869', NULL, b'0', b'0', NULL, b'1', 0, 'SSOUserIdentity', NULL, NULL, 'Венера Милова');
/*!40000 ALTER TABLE `aspnetusers` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.aspnetusertokens
CREATE TABLE IF NOT EXISTS `aspnetusertokens` (
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `LoginProvider` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Value` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.aspnetusertokens: ~0 rows (приблизително)
DELETE FROM `aspnetusertokens`;
/*!40000 ALTER TABLE `aspnetusertokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetusertokens` ENABLE KEYS */;

-- Дъмп структура за процедура votingregister.calculateBonuses
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `calculateBonuses`(
   prmUSER          varchar(128) 
   ,prmIdLiceIzb    int
   ,prmDummy        varchar(30)
)
BEGIN
  DECLARE v_code_rolia,v_idsik,v_tur, v_hasmaxincome,v_vidsik INTEGER DEFAULT 0;
  DECLARE v_toa varchar(2) default "";
  DECLARE v_izb_alias varchar(6) default "MI2019";
  DECLARE v_sik varchar(3) default "000";
  DECLARE v_IME      varchar(250);
  DECLARE v_egn      varchar(10);
  
  SET NAMES 'utf8';
    
   
  SELECT i.Code_rolia, i.IZB_Alias, i.TUR, s.TOA, i.ID_SIK, s.SIK
        ,CONCAT(TO_BASE64(AES_ENCRYPT(UPPER(l.IM1),prmDummy)),' ',
               IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(l.IM2),prmDummy)),''),' ',
               IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(l.IM3),prmDummy)),''))        
        ,ifnull(i.hasmaxincome,0), ifnull(v.Idcodeposition,101)
        ,TO_BASE64(AES_ENCRYPT(UPPER(l.EGN),prmDummy))
    INTO v_code_rolia, v_izb_alias,v_tur,v_toa,v_idsik,v_sik, v_ime, v_hasmaxincome, v_vidsik,v_egn
    FROM n_lica_izbori i 
          inner join n_lica l on i.id_lice = l.id
          inner join siks s on i.Id_Sik = s.Id_sek
            left join  siks_vidove v on v.Id_Sik = s.Id_sek and v.Vid_codetable=1
    WHERE i.Id = prmIdLiceIzb;
       
  DELETE FROM n_lice_pari_zaplashtane
    WHERE ID_Lice = prmIdLiceIzb;
    
  DELETE FROM n_lice_pari_zanap
    WHERE ID_Lice = prmIdLiceIzb;
    
  IF v_sik != "000"  AND v_code_rolia < 410 AND v_vidsik < 104 THEN 
          
    
    INSERT INTO n_lice_pari_zaplashtane(`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
      SELECT prmIdLiceIzb,  o.Vid_codetable, o.Idcodeposition, Pari, now()
          FROM  siks_vidove v 
                inner join  normi_roli o 
                    ON v.Vid_codetable = o.Vid_codetable_1 
                        and v.Idcodeposition = o.Idcodeposition_1 
          where v.id_sik = v_idsik
             and v.Vid_codetable  = 1
             AND o.Vid_codetable  = 4
             AND o.idcodeposition = v_code_rolia
             AND o.Izb_allias     = v_izb_alias
             and o.tur            = v_tur
             AND o.status         = 1;
          
      
    INSERT INTO n_lice_pari_zaplashtane(`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
        SELECT prmIdLiceIzb,  v.Vid_codetable, v.Idcodeposition, Pari, now()
          FROM  siks_vidove v 
                inner join  normi_priznaci o 
                    ON v.Vid_codetable = o.Vid_codetable and v.Idcodeposition = o.Idcodeposition
          where v.id_sik = v_idsik
             and v.Vid_codetable = 2
             AND o.Izb_allias = v_izb_alias
             and o.tur = v_tur
             AND o.status=1;

    
    INSERT INTO n_lice_pari_zaplashtane (`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
        SELECT prmIdLiceIzb,  d.Vidcodetable, d.Idcodeposition, Pari, now()
          FROM n_lica_dopylnenie d
                inner join n_lica_izbori i on d.Id_Lice = i.ID
                inner join normi_operacii o on d.vidcodetable = o.vid_codetable and d.idcodeposition = o.idcodeposition
          WHERE i.ID        = prmIdLiceIzb
            AND o.Izb_allias = v_izb_alias
            AND o.TUR        = v_tur
            AND o.status     = 1;

    IF v_hasmaxincome = 0 THEN
        if fnGetLiceBirthYear(v_egn) > 1959 THEN   
            
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = v_izb_alias
                      AND CAST(nred AS UNSIGNED integer) between 2 and 10
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        ELSE
            
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = v_izb_alias
                      AND (CAST(nred AS UNSIGNED integer) =1 OR CAST(nred AS UNSIGNED integer) between 4 and 10)
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        END IF;            
    END IF;   
  END IF;    
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.check4DoublicateEgn
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `check4DoublicateEgn`(prmEGN varchar(10),prmVid integer, prmID int, prmToa varchar(2),prmDummy varchar(128))
BEGIN
  DECLARE retval varchar(100) default "";
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  
  SELECT CONCAT(s.AA_BB_CC, ' ', w.Short_name)
     INTO @v_fullsikcode
     FROM n_lica l
          left join n_lica_izbori i on l.id = i.id_lice AND i.TUR = @v_tur
              inner join wnsila w on w.ID_Party = i.id_sila
              inner join siks s on i.id_sik = s.Id_sek
     WHERE l.id <> prmID
       and l.Vid_id = prmVid 
       and AES_DECRYPT(FROM_BASE64(l.EGN),prmDummy)=prmEGN
       and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
     LIMIT 1;                  

  IF LENGTH(IFNULL (@v_fullsikcode,''))>0 THEN
      IF prmVid = 2 THEN
        SET retval =concat('Дублирано ЛНЧ (',@v_fullsikcode,')');
      ELSE
        SET retval =concat('Дублирано ЕГН (',@v_fullsikcode,')');
      END IF;
  ELSE
       
    IF checkNumber(prmVid, prmEGN) = -1 THEN
      IF prmVid = 2 THEN
        SET retval = "Грешно ЛНЧ.";
      ELSE
        SET retval = "Грешно ЕГН.";
      END IF;
    END IF;  
  END IF;
  
  SELECT retval as ImpMessage;  	
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.check4DoublicateSik
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `check4DoublicateSik`(prmSIK varchar(3),prmIzbAlias varchar(6), prmTUR int, prmTOA varchar(2), prmID int)
BEGIN
  DECLARE retval integer default 0;
  
  if EXISTS (SELECT 1 
              FROM siks s
              WHERE s.ID_SEK <> prmID
                AND s.Izb_Alias = prmIzbAlias
                AND s.TUR = prmTUR
                AND s.TOA = prmToa
                AND s.Sik = prmSIK)
  THEN
    SET retval = -1;
  END IF;
  
  SELECT retval as Id;  	
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.checkBulstat
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `checkBulstat`(
    prmBulstat   varchar(13)
)
BEGIN
  SET NAMES 'utf8';  
  SET @retval = checkNumber (3,prmBulstat);
  
  SELECT @retval as id;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.checkLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `checkLica`(
    prmIzbAlias   varchar(6)
    ,prmToa       varchar(2)
    ,prmTur       int 
    ,prmID        int
    ,prmVIDID     int
    ,prmEgn       varchar(10)
    ,prmIdSila    int
    ,prmSIK       varchar(3)
    ,prmKODROL    varchar(3)
    ,prmKODSPEC   varchar(3)
    ,prmKODOBR    varchar(3)
    ,prmDummy     varchar(30)
    ,prmIdReplace int  
)
BEGIN
  DECLARE v_opisanie varchar(250) default ''  collate utf8_unicode_ci;
  
  SET v_opisanie  := fnCheckLica (1
                                  ,prmIzbAlias  
                                  ,prmToa       
                                  ,prmTur       
                                  ,prmID        
                                  ,prmVIDID     
                                  ,prmEgn       
                                  ,prmIdSila    
                                  ,prmSIK       
                                  ,prmKODROL    
                                  ,prmKODSPEC   
                                  ,prmKODOBR    
                                  ,prmDummy
                                  ,prmIdReplace
                              );
   
  
  SELECT v_opisanie as impmessage;
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.checkNumber
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `checkNumber`(prmType int, prmValue varchar(20)) RETURNS int(11)
BEGIN
  DECLARE retval int;
  SET retval := -1;
     
  CREATE TEMPORARY TABLE if not exists tblvalues (val int, numb tinyint);

  CASE
    WHEN prmType = 2 THEN
      SET @fixlen := 10;      
      SET @Values = '21,19,17,13,11,9,7,3,1';

    WHEN prmType = 3 THEN          
      SET @Values  = '1,2,3,4,5,6,7,8';
      SET @Values2 = '3,4,5,6,7,8,9,10';

      IF Length(prmValue) = 13 THEN
        SET @fixlen := 13;
        SET @Values131 = '2,7,3,5';
        SET @Values132 = '4,9,5,7';
      ELSE
        SET @fixlen := 9;
      END IF;
      
     ELSE BEGIN
        SET @fixlen := 10;
        SET @Values = '2,4,8,5,10,9,7,3,6';      
     END;
  END CASE;    

  IF LENGTH(prmValue) = @fixlen THEN
    SET @cnt = 0;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @cnt   = @cnt +1;
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
    END WHILE;

    SET @cnt = @cnt +1;
    SET @value = ELT(1, @Values);
    INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
    
    IF prmType = 3 THEN
       SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );
       
       IF @result = 10 THEN
          DELETE FROM tblvalues;
          
          SET @cnt = 0;
          WHILE (LOCATE(',', @Values2) > 0)
          DO
              SET @cnt   = @cnt +1;
              SET @value = ELT(1, @Values2);
              SET @Values2= SUBSTRING(@Values2, LOCATE(',',@Values2) + 1);

              INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
          END WHILE;

          SET @cnt   = @cnt +1;
          SET @value = ELT(1, @Values2);
          INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
          
          
          SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              
       END IF;
       
       IF @fixlen = 13 THEN
          DELETE FROM tblvalues;
          
          SET @cnt = 0;
          WHILE (LOCATE(',', @Values131) > 0)
          DO
              SET @cnt   = @cnt +1;
              SET @value = ELT(1, @Values131);
              SET @Values131= SUBSTRING(@Values131, LOCATE(',',@Values131) + 1);

              INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
          END WHILE;

          SET @cnt   = @cnt +1;
          SET @value = ELT(1, @Values131);
          INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
          
          
          SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              

          IF @result = 10 THEN
            DELETE FROM tblvalues;
            
            SET @cnt = 0;
            WHILE (LOCATE(',', @Values132) > 0)
            DO
                SET @cnt   = @cnt +1;
                SET @value = ELT(1, @Values132);
                SET @Values132= SUBSTRING(@Values132, LOCATE(',',@Values132) + 1);

                INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
            END WHILE;

            SET @cnt   = @cnt +1;
            SET @value = ELT(1, @Values132);
            INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
            
            
            SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              
          END IF;
      END IF;        
    ELSE
      IF prmType = 2 THEN
        SET @result := (select IF(MOD(sum(val*numb),10)=10,0,MOD(sum(val*numb),10)) from tblvalues);    
      ELSE
        SET @result := (select IF(MOD(sum(val*numb),11)=10,0,MOD(sum(val*numb),11)) from tblvalues);
      END IF;
    END IF;
    
    IF SUBSTRING(prmValue,@fixlen) = @result THEN
        SET retval := 0;
    END IF;
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.createLog
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `createLog`(
   prmUser          varchar(128) 
  ,prmACTION        int
  ,prmKOD           varchar(250) 
  ,prmDescriptipon  varchar(250) 
  ,prmToa           varchar(2)  
  ,prmAA            varchar(250)
)
BEGIN
    SET NAMES 'utf8';
 
    SELECT UserName
      INTO @v_username 
      FROM aspnetusers
      WHERE ID=prmUser;

    SET @v_username = IFNULL(@v_username ,concat('Грешен потребител: ','prmUser'));
    
    SELECT  NIME
      INTO @v_action
      FROM wntoa 
      WHERE NKOD = prmToa;
    
    IF @v_action is null THEN
      SELECT w.nime
        INTO @v_action
        FROM sys_usermain s inner join wntoa w on s.Value = w.NKOD and s.Name='TOA'
        WHERE User=prmUser;
    END IF;
    
    CASE prmACTION
      WHEN 1 THEN      
              INSERT INTO `n_log_lica` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,@v_action
                  ,prmKOD
                  ,prmDescriptipon
                );
      WHEN 3 THEN      
              INSERT INTO `n_log_dokumenti` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,@v_action
                  ,prmKOD 
                  ,prmDescriptipon
                );
                
      WHEN 4 THEN      
              INSERT INTO `n_log_deinosti` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`, `AAA`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,@v_action
                  ,prmKOD 
                  ,prmDescriptipon
                  ,prmAA
                );
      ELSE          
          BEGIN
              INSERT INTO `n_log` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,@v_action
                  ,prmKOD 
                  ,prmDescriptipon
                );
          END;
    END CASE;      
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.createNewElection
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `createNewElection`(
   prmUSER          varchar(128) 
   ,prmTIPIZB       varchar(2)
   ,prmName         varchar(50)
   ,prmDATE1TUR     datetime
   ,prmDATE2TUR     datetime
)
BEGIN
   SET NAMES 'utf8';
   
   DELETE FROM n_top_main;
   
   SET @v_izbalias = CONCAT(prmTIPIZB,CAST(YEAR(prmDATE1TUR) as char(4)));
   
   IF NOT EXISTS (SELECT 1 FROM wntipizbori WHERE NKOD = prmTIPIZB AND TUR=2) THEN
       INSERT INTO n_top_main 
            (IZB_ALIAS,Description,DATE1TUR,DATE2TUR,Status_parameters)
          VALUES(@v_izbalias,prmName,prmDATE1TUR,null,1 );   
   ELSE
     INSERT INTO n_top_main 
          (IZB_ALIAS,Description,DATE1TUR,DATE2TUR,Status_parameters)
        VALUES(@v_izbalias,prmName,prmDATE1TUR,prmDATE2TUR,1 );   
   END IF; 
   
         
   CALL createNewTurOrElection ( prmUSER,@v_izbalias,0);
   
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.createNewTurOrElection
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `createNewTurOrElection`(
   prmUSER          varchar(128) 
   ,prmIzbAlias     varchar(6)
   ,prmTUR          int
)
BEGIN
   SET NAMES 'utf8';
  
   
   IF  prmTUR = -1 THEN
      DELETE FROM n_log;
      DELETE FROM n_lice_pari_zanap;
      DELETE FROM n_lice_pari_zaplashtane;
      DELETE FROM n_lica_dopylnenie;
      DELETE FROM n_lica_izbori_zamestvane;
      DELETE FROM n_lica_izbori;             
      DELETE FROM n_lica_import;
      DELETE FROM N_LICA;
      
      DELETE FROM n_top_partgrid;
      DELETE FROM n_top_partkvoti;
      
      DELETE FROM siks_vidove 
        WHERE ID_sik  IN (SELECT ID_SEK FROM SIKS WHERE SIK != '000');
        
      DELETE FROM siks WHERE SIK != '000';
      
      DELETE FROM siks_vidove 
        WHERE ID_sik  IN (SELECT ID_SEK FROM SIKS WHERE (IFNULL(IZB_ALIAS,'') <> prmIzbAlias 
                OR IZB_RAJON <> fnGetIzborenRajon(prmIzbAlias,toa)));
                
      DELETE FROM siks 
        WHERE (IFNULL(IZB_ALIAS,'') <> prmIzbAlias 
                OR IZB_RAJON <> fnGetIzborenRajon(prmIzbAlias,toa));

      INSERT INTO SIKS (Izb_Alias, TUR, Izb_rajon, TOA,AA_BB_CC,Sik,Status_Sekcia,Obl,Obs,NAS,USER,Koga)
        SELECT prmIzbAlias, 1
              ,fnGetIzborenRajon(prmIzbAlias,wntoa.nkod), wntoa.nkod
              ,fnGetFullSikNumber(wntoa.nkod), '000',0,'SOF','SOF46','68134',prmUSER, now() 
        FROM wntoa
        WHERE NOT EXISTS (SELECT 1 FROM SIKS WHERE TOA = wntoa.nkod);
            
      DELETE FROM sys_main WHERE NAME = 'FINANCE';
      UPDATE sys_main SET VALUE =1 WHERE ID  = 2;
    
      DELETE FROM sys_toamain;
      DELETE FROM sys_usermain;
      
      INSERT INTO sys_usermain (`User`,`Name`,`Value`)
        SELECT Id, 'TOA',IFNULL(administrative_rajon,'01')
            FROM aspnetusers;
      
      call createLog (prmUSER, 2,concat('Инициализация на базата',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');
   ELSE
     
     IF EXISTS (SELECT 1
                  FROM sys_main
                  WHERE ID = 1
                    AND VALUE = prmIzbAlias)
     THEN   
        
        IF EXISTS (SELECT 1 
                     FROM sys_main 
                     WHERE ID  = 2 
                     AND Value = '1') 
        
          AND EXISTS (SELECT 1 
                        FROM wntipizbori 
                        WHERE nkod = left(prmIzbAlias,2) 
                          and tur=2 
                          and status=1) 
        THEN
           DELETE FROM n_toa_main
             WHERE IZB_ALIAS = prmIzbAlias 
                AND TUR = 2;
                      
           INSERT INTO n_toa_main (`IZB_ALIAS`,`TOA`,`Tur`,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                           ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`)
           SELECT IZB_ALIAS,TOA,2,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                   ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`
              FROM n_toa_main
              WHERE IZB_ALIAS = prmIzbAlias 
                AND TUR = 1;
            
           DELETE FROM normi_operacii
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_operacii (`Izb_allias`,`Tur`,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`,2,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_operacii
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

           DELETE FROM normi_priznaci
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_priznaci (`Izb_allias`,`Tur`,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`,2,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_priznaci
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

           DELETE FROM normi_roli
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_roli (`Izb_allias`,`Tur`,  `Vid_codetable_1`,`Idcodeposition_1`
                                  ,`Vid_Codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`, 2, `Vid_codetable_1`,`Idcodeposition_1`
                     ,`Vid_Codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_roli
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

          INSERT INTO N_LICA_DOPYLNENIE_OTTUR1
            SELECT *
              FROM N_LICA_DOPYLNENIE
              WHERE ID_LICE IN (SELECT id 
                                    FROM n_lica_izbori n 
                                          inner join siks s ON n.Id_Sik=s.Id_sek 
                                    WHERE s.IZB_ALIAS = prmIzbAlias 
  
                                  );
                                
          DELETE FROM n_lica_dopylnenie 
              WHERE ID_LICE IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 

                                );
           
                                  
          INSERT INTO n_lica_izbori_zamestvane_ottur1 
            SELECT *
              FROM n_lica_izbori_zamestvane
              WHERE ID_Lice_novo IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 

                                );
              
          DELETE FROM n_lica_izbori_zamestvane 
              WHERE ID_Lice_novo IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 

                                );

          DELETE FROM n_lica_izbori 
              WHERE ID_SIK IN (SELECT id_sek FROM siks   WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2);

           DELETE FROM siks_vidove
              WHERE ID_sik in (SELECT id_sek FROM siks   WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2); 
              
           DELETE FROM siks WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2; 

           INSERT INTO siks (Izb_Alias,TUR,Izb_rajon,TOA,AA_BB_CC,Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,USER,KOGA,Status_Sekcia)
                SELECT Izb_Alias,2,Izb_rajon,TOA,AA_BB_CC,Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,prmUSER,now(),Status_Sekcia
                  FROM SIKS
                  WHERE IZB_ALIAS = prmIzbAlias 
                    AND TUR = 1;

           CREATE TEMPORARY TABLE IF NOT EXISTS tblsiks (
                old_idsek int,
                new_idsek int
           );

           CREATE TEMPORARY TABLE IF NOT EXISTS tblizbori (
                old_id int,
                new_id int
           );
    
           INSERT INTO tblsiks
                SELECT s1.id_sek, s2.id_sek
                  FROM siks s1 inner join siks s2 on s1.Izb_Alias = s2.Izb_Alias and s1.toa = s2.toa and s1.sik = s2.sik and s2.tur=2
                  WHERE s1.Izb_Alias = prmIzbAlias 
                    AND s1.TUR = 1;
                       
           INSERT INTO siks_vidove (IZB_allias,Tur,Id_Sik,Vid_codetable,Idcodeposition,Status)
                SELECT s1.IZB_allias,2,t.new_idsek,s1.Vid_codetable,s1.Idcodeposition,s1.Status
                  FROM SIKS_VIDOVE s1 inner join tblsiks t on s1.id_sik = t.old_idsek
                  WHERE s1.IZB_allias = prmIzbAlias 
                    AND s1.TUR = 1;
                     
           INSERT INTO n_lica_izbori (`ID_Lice`,`Izb_Alias`,`Tur`,`TOA`,`Id_Sik`,`id_sila`,`Re`,`Code_rolia`,`Ime_rolia`,USER,KOGA)
               SELECT i.ID_Lice,i.Izb_Alias,2,i.TOA,t.new_idsek,i.id_sila,i.Re,i.Code_rolia,i.Ime_rolia,prmUSER,now()
                FROM n_lica_izbori i inner join tblsiks t on i.Id_Sik = t.old_idsek
                WHERE i.IZB_ALIAS = prmIzbAlias 
                  AND i.TUR = 1;


           INSERT INTO tblizbori
                SELECT s1.id, s2.id
                  FROM n_lica_izbori s1 inner join n_lica_izbori s2 on s1.izb_alias = s2.izb_alias and s1.id_lice = s2.id_lice and s2.tur=2
                  WHERE s1.IZB_ALIAS = prmIzbAlias 
                    AND s1.TUR = 1;


             
          UPDATE sys_main
            SET value = 2
            WHERE id = 2;
                    
          DELETE FROM sys_main WHERE NAME = 'FINANCE';
           
          SELECT MAX(ID)+1 INTo @v_ID FROM sys_main;
          INSERT INTO sys_main (ID,NAME,VALUE) 
                VALUES (@v_ID,'TUR2KOGA', UNIX_TIMESTAMP(now()));

          DROP TEMPORARY TABLE IF EXISTS tblsiks;
          DROP TEMPORARY TABLE IF EXISTS tblizbori;
 
          call createLog (prmUSER, 2,concat('Преминаване към тур 2: ',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');
        END IF;
     ELSE     
       DELETE FROM n_log;
     
       DELETE FROM sys_main WHERE NAME = 'FINANCE';
       DELETE FROM sys_main WHERE NAME = 'TUR2KOGA';       
       UPDATE sys_main SET VALUE =prmIzbAlias WHERE ID  = 1;
       UPDATE sys_main SET VALUE =1 WHERE ID  = 2;
     
       UPDATE wnizbraion 
          SET IZB_ALIAS= prmIzbAlias;
       
       IF EXISTS (SELECT 1 
                        FROM wntipizbori 
                        WHERE nkod = left(prmIzbAlias,2) 
                          and tur=2 
                          and status=1)
       THEN
           UPDATE wnizbraion 
              SET status = 1
              WHERE nkod = '22';

           UPDATE wnizbraion 
              SET status = 0
              WHERE nkod <> '22';
       ELSE
           UPDATE wnizbraion 
              SET status = 0
              WHERE nkod = '22';

           UPDATE wnizbraion 
              SET status = 1
              WHERE nkod <> '22';
       END IF;
                         
       UPDATE n_list_codepositions
          SET IZB_ALLIAS = prmIzbAlias;

       UPDATE n_toa_main
          SET IZB_ALIAS = prmIzbAlias;
          
       UPDATE n_top_dancoef
          SET IZB_ALLIAS = prmIzbAlias;
          
       UPDATE n_top_parameters
          SET IZB_ALIAS = prmIzbAlias;
          
       UPDATE n_top_partkvoti
          SET IZB_ALIAS = prmIzbAlias;

       UPDATE wnsila
          SET IZB_alias = prmIzbAlias;
        
       DELETE FROM wndocs;
       
       DELETE FROM N_LICA_DOPYLNENIE_OTTUR1;                                  
       DELETE FROM n_lica_izbori_zamestvane_ottur1;
       
       DELETE FROM n_lice_pari_zanap;
       DELETE FROM n_lice_pari_zaplashtane;
       DELETE FROM n_lica_dopylnenie;
       DELETE FROM n_lica_izbori_zamestvane;
       DELETE FROM n_lica_izbori;             
       DELETE FROM n_lica_import;
       DELETE FROM N_LICA;
       
       DELETE FROM normi_operacii;
       DELETE FROM normi_priznaci;
       DELETE FROM normi_roli;
       
       
       DELETE FROM siks_vidove WHERE TUR=2;
       DELETE FROM siks WHERE TUR=2;
              
       
       DELETE FROM siks_vidove 
          WHERE Vid_codetable = 1 
            AND Idcodeposition <> 101;
          
       DELETE FROM siks 
        WHERE not EXISTS (SELECT 1
                               FROM siks_vidove 
                               WHERE Id_Sik = siks.Id_sek);

       UPDATE siks_vidove
          SET IZB_allias = prmIzbAlias;

       UPDATE siks
          SET IZB_alias = prmIzbAlias;

       
       INSERT INTO SIKS (Izb_Alias, TUR, Izb_rajon, TOA,AA_BB_CC,Sik,Status_Sekcia,Obl,Obs,NAS,USER,Koga)
          SELECT prmIzbAlias, 1,fnGetIzborenRajon(prmIzbAlias,wntoa.nkod), wntoa.nkod
                ,concat(fnGetFullSikNumber(wntoa.nkod), '000'), '000',0,'SOF','SOF46','68134',prmUSER, now() 
          FROM wntoa
          WHERE NOT EXISTS (SELECT 1 FROM SIKS WHERE TOA = wntoa.nkod);

       INSERT INTO siks_vidove (IZB_allias,Tur,Id_Sik,Vid_codetable,Idcodeposition, Status)
          SELECT Izb_Alias, TUR, Id_sek, 1, 100,1
             FROM SIKS
             WHERE SIK = '000';
             
       DELETE FROM n_toa_main WHERE TUR=2;

       UPDATE n_toa_main 
          SET PRIS = (SELECT  PREFIX
                          FROM wnizbraion
                          WHERE nkod =  fnGetIzborenRajon(prmIzbAlias, TOA)
                            AND IZB_ALIAS =prmIzbAlias);   

      UPDATE n_toa_main 
          SET R1 = (SELECT  NIME
                          FROM wnizbraion
                          WHERE nkod =  fnGetIzborenRajon(prmIzbAlias, TOA)
                            AND IZB_ALIAS =prmIzbAlias);   
                 
       DELETE FROM sys_toamain;
       DELETE FROM sys_usermain;

       INSERT INTO sys_usermain (`User`,`Name`,`Value`)
        SELECT Id, 'TOA',IFNULL(administrative_rajon,'01')
            FROM aspnetusers;
            
       call createLog (prmUSER, 2,concat('Преминаване към нови избори ',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');      
      END IF;
    END IF;    
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.createSikLog
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `createSikLog`(
   prmUser          varchar(128) 
  ,prmToa           varchar(2)  
  ,prmSIK           varchar(10) 
  ,prmKOD           varchar(250) 
  ,prmDescriptipon  varchar(250) 
  ,prmOldVal        varchar(250) 
  ,prmNewVal        varchar(250) 
)
BEGIN
    SET NAMES 'utf8';
 
    SELECT UserName
      INTO @v_username 
      FROM aspnetusers
      WHERE ID=prmUser;

    SET @v_username = IFNULL(@v_username ,concat('Грешен потребител: ','prmUser'));
    
    SELECT  NIME
      INTO @v_toaname
      FROM wntoa 
      WHERE NKOD = prmToa;
       
    INSERT INTO `n_log_sik_istoria` (`User`,  Koga, `TOA`,  `TOA_Tekst`,  `SIK`
                  ,`Kod_Obrabotka`,  `Kod_Tekst`,  `Pole_Bilo`,  `Pole_Stava`)
      VALUES (
        @v_username      
        ,NOW()
        ,prmToa
        ,@v_toaname
        ,prmSIK
        ,prmKOD 
        ,prmDescriptipon
        ,prmOldVal
        ,prmNewVal
      );

END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.deleteImportLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `deleteImportLica`(
   prmUSER      varchar(128) 
)
BEGIN
  DELETE FROM n_lica_import  WHERE USER = prmUSER;      
  SELECT 0 as ID ;  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.deleteLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `deleteLica`(
  prmID         int
  ,prmUSER      varchar(128)
  ,prmToa       varchar(2)
  ,prmDummy     varchar(30)
)
BEGIN
    DECLARE prmIME      varchar(250);
    
    SET NAMES 'utf8';

    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
        INTO @v_tur
        FROM sys_main
        WHERE ID =2;
    
    IF @v_tur = 2 THEN      
      SELECT IFNULL(MAX(s.SIK),'000')
        INTO @v_sik
        FROM n_lica_izbori i inner join siks s on i.id_sik = s.Id_sek
        WHERE i.ID_LICE = prmID
          AND i.TUR = 1;
    ELSE
      SET @v_sik = '000';
    END IF;      

    SELECT i.ID
      INTO @prmIDIZB
      FROM n_lica_izbori i inner join siks s on i.id_sik = s.Id_sek
      WHERE i.ID_LICE = prmID
        AND i.TUR =  @v_tur;

    IF  @v_sik = '000' THEN
      SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        INTO prmIME
        FROM n_lica
        WHERE ID = prmID;
      
      

      DELETE FROM n_lice_pari_zanap WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lice_pari_zaplashtane WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lica_dopylnenie WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lica_dopylnenie_ottur1 WHERE ID_LICE =@prmIDIZB;
      
      DELETE FROM n_lica_izbori_zamestvane WHERE ID_Lice_staro =@prmIDIZB;
      DELETE FROM n_lica_izbori_zamestvane WHERE ID_Lice_novo =@prmIDIZB;
      
      DELETE FROM n_lica_izbori_zamestvane_ottur1 WHERE ID_Lice_staro =@prmIDIZB;
      DELETE FROM n_lica_izbori_zamestvane_ottur1 WHERE ID_Lice_novo =@prmIDIZB;
   
      DELETE FROM n_lica_izbori WHERE ID_LICE =prmID;           
      DELETE FROM N_LICA WHERE ID = prmID;
                     
      call createLog (prmUSER, 1,'Изтриване',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');
      select prmID as ID from dual;
    ELSE
      select -1 as ID from dual;    
    END IF;  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.deleteSik
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `deleteSik`(
  prmID         int
  ,prmUSER      varchar(128)
)
BEGIN
    DECLARE prmSik      varchar(3);
    DECLARE prmADR_IME  varchar(100);
    DECLARE prmToa      varchar(3);
    DECLARE prmFullSik  varchar(10);

    SET NAMES 'utf8';

    SELECT SIK, ADR_IME, TOA, AA_BB_CC
      INTO prmSik, prmADR_IME, prmToa, prmFullSik
      FROM siks
      WHERE ID_SEK = prmID;

    IF prmSIk = '000' THEN
      SELECT -1 as ID FROM DUAL;
    ELSEIF EXISTS (SELECT 1 FROM n_lica_izbori where id_sik = prmID) THEN
      SELECT -2 as ID FROM DUAL;    
    ELSE
      UPDATE siks 
        SET Status_Sekcia = 0
      WHERE Id_sek = prmID;

      call createSikLog (prmUser, prmTOA, prmFullSik, 11, 'Закрита','','');
      SELECT prmID as ID FROM DUAL;
    END IF;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.exportBonuses
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `exportBonuses`(
   prmUSER          varchar(128) 
   ,prmIdLiceIzb    int
   ,prmTip          int
   ,prmDummy        varchar(30)
)
BEGIN
  DECLARE v_tur INTEGER DEFAULT 0;
  DECLARE v_toa varchar(2) default "";
  DECLARE v_izb_alias varchar(6) default "MI2019";
     
  SET NAMES 'utf8';
  
 SELECT SUM(pari)
    INTO @v_c35
    FROM n_lice_pari_zaplashtane
    WHERE n_lice_pari_zaplashtane.ID_Lice = prmIdLiceIzb;
                   
  IF EXISTS (SELECT 1 
               FROM n_lica_izbori l 
                      inner join siks s on l.id_sik = s.id_sek
                      inner join siks_vidove v on v.id_sik = s.id_sek                      
                      inner join n_list_codepositions n ON n.PKODE = v.Vid_codetable and n.NKODE = v.Idcodeposition and n.CALC=1
               WHERE l.ID         = prmIdLiceIzb 
                 AND l.Code_rolia   < 410
                 AND IFNULL(l.hasmaxincome,0) = 0
                 AND v.Idcodeposition < 104
               ) 
      AND @v_c35 > 0         
  THEN
    SELECT i.IZB_Alias, s.TOA, s.TUR
      INTO v_izb_alias, v_toa, v_tur  
      FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.Id_sek
      WHERE i.Id = prmIdLiceIzb;
               
    IF v_tur = 2 THEN
      SELECT DATE2TUR
        INTO @v_datetur
        FROM n_top_main
        WHERE status_parameters = 1;    
    ELSE
      SELECT DATE1TUR
        INTO @v_datetur
        FROM n_top_main
        WHERE status_parameters = 1;    
    END IF;
 
    SELECT BUL collate utf8_unicode_ci
      INTO @v_bulstat
      FROM n_toa_main 
      WHERE IZB_ALIAS = v_izb_alias
        AND TOA = v_toa
        AND TUR = v_tur;
      
    IF v_tur = 2 THEN
        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c21
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '51'
            AND n_top_parameters.Status_parameters =1;

        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c9
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '54'
            AND n_top_parameters.Status_parameters =1;

        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c10
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '55'
            AND n_top_parameters.Status_parameters =1;
    
    ELSE
        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c21
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '50'
            AND n_top_parameters.Status_parameters =1;

        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c9
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '52'
            AND n_top_parameters.Status_parameters =1;

        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c10
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '53'
            AND n_top_parameters.Status_parameters =1;    
    END IF;
    
    SELECT IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.egn),prmDummy) as CHAR(50)),'')
      INTO @v_egn
      FROM n_lica_izbori i inner join n_lica l on i.ID_Lice = l.id
      WHERE i.ID = prmIdLiceIzb
      LIMIT 1;

    if fnGetLiceBirthYear( @v_egn) > 1959 THEN   
        SELECT Coef_stoinost
          INTO @v_c36
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '02';
    ELSE
        SELECT Coef_stoinost
          INTO @v_c36
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '01';
    END IF;
    
    SELECT Coef_stoinost
      INTO @v_c38
      FROM n_top_dancoef
      WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
        AND nred = '04';      
      
   SELECT Coef_stoinost
      INTO @v_c40
      FROM n_top_dancoef
      WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
        AND nred = '06';      

   if fnGetLiceBirthYear( @v_egn) > 1959 THEN   
       SELECT Coef_stoinost
          INTO @v_c43
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '03'; 
    ELSE
       SET  @v_c43 = 0;
    END IF;
    
    SET @delimiter = ',' collate utf8_unicode_ci;
    
              
    
    SELECT CONCAT(
               CAST(c1 as CHAR(2)),@delimiter
              ,CAST(c2 as CHAR(4)),@delimiter
              ,c3,@delimiter
              ,c4,@delimiter
              ,CAST(c5 as CHAR(1)),@delimiter
              ,c6,@delimiter
              ,c7,@delimiter
              ,c8,@delimiter
              ,c9,@delimiter
              ,c10,@delimiter
              ,c11,@delimiter
              ,c12,@delimiter
              ,c13,@delimiter
              ,c14,@delimiter
              ,c15,@delimiter
              ,c16,@delimiter
              ,c17,@delimiter
              ,c18,@delimiter
              ,c19,@delimiter
              ,c20,@delimiter
              ,CAST(c21 as CHAR(4)),@delimiter
              ,c22,@delimiter
              ,c23,@delimiter
              ,c24,@delimiter
              ,c25,@delimiter
              ,c26,@delimiter
              ,c27,@delimiter
              ,c28,@delimiter
              ,c29,@delimiter
              ,c30,@delimiter
              ,c31,@delimiter
              ,c32,@delimiter
              ,c33,@delimiter
              ,c34,@delimiter
              ,CAST(c35 as CHAR),@delimiter
              ,CAST(c36 as CHAR),@delimiter
              ,c37,@delimiter
              ,CAST(c38 as CHAR),@delimiter
              ,c39,@delimiter
              ,CAST(c40 as CHAR),@delimiter
              ,c41,@delimiter
              ,c42,@delimiter
              ,CAST(c43 as CHAR),@delimiter
              ,c44,@delimiter
              ,c45,@delimiter
              ,c46,@delimiter
              ,c47,@delimiter
              ,c48,@delimiter
              ,c49,@delimiter
              ,c50,@delimiter
              ,CAST(c51 as CHAR),@delimiter
              ,c52,@delimiter
              ,c53,@delimiter
              ,c54
      )  collate utf8_unicode_ci as line
      FROM (SELECT MONTH(@v_datetur) as c1
                  ,YEAR(@v_datetur)  as c2
                  ,CONCAT('"',IFNULL(@v_bulstat,''),'"')  as c3
                  ,CONCAT('"',@v_egn,'"') as c4
                  ,l.VID_ID as c5 
                  ,CONCAT('"',IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.im3),prmDummy) as CHAR(50)),''),'"') as c6
                  ,CONCAT('"',CONCAT(LEFT(CAST(AES_DECRYPT(FROM_BASE64(l.im1),prmDummy) as CHAR(50)),1)
                                   ,IFNULL(LEFT(CAST(AES_DECRYPT(FROM_BASE64(l.im2),prmDummy) as CHAR(50)),1),''))
                                    ,'"') collate utf8_unicode_ci as c7        
                  ,'71' as c8
                  ,LEFT(IFNULL(@v_c9,'0'),2) as c9
                  ,LEFT(IFNULL(@v_c10,'0'),2) as c10
                  ,'0' as c11
                  ,'0' as c12
                  ,'0' as c13
                  ,'0' as c14
                  ,'0' as c15
                  ,'0' as c16
                  ,'0' as c17
                  ,'0' as c18
                  ,'1' as c19
                  ,'"0300"' as c20
                  ,IFNULL(FORMAT(@v_c21,0),0) as c21 
                  ,'0' as c22
                  ,'0' as c23
                  ,'0' as c24
                  ,'0' as c25
                  ,'0' as c26
                  ,'0' as c27
                  ,'0' as c28
                  ,'0' as c29
                  ,'""' as c30
                  ,'0' as c31
                  ,'0' as c32
                  ,'0' as c33
                  ,'0' as c34
                  ,IFNULL(FORMAT(@v_c35,2),0) as c35
                  ,IFNULL(FORMAT(@v_c36*100,2),0) as c36
                  ,'0' as c37
                  ,IFNULL(FORMAT(@v_c38*100,2),0) as c38
                  ,'0' as c39
                  ,IFNULL(FORMAT(@v_c40*100,2),0) as c40
                  ,'0' as c41
                  ,'0' as c42
                  ,IF(@v_c43=0,'',IFNULL(FORMAT(@v_c43*100,2),0)) as c43
                  ,'0' as c44
                  ,'0' as c45
                  ,'0' as c46
                  ,'0' as c47
                  ,'0' as c48
                  ,'0' as c49
                  ,'0' as c50
                  ,IFNULL(FORMAT(@v_c35,2),0) as c51
                  ,'0' as c52
                  ,prmTip as c53
                  ,'"NRAD12008"' as c54
              FROM n_lica_izbori i inner join n_lica l on i.ID_Lice = l.ID
              WHERE i.Id = prmIdLiceIzb) x;
  ELSE
     SELECT ''  collate utf8_unicode_ci as LINE;
  END IF;
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnCheck4DoublicateEgn
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnCheck4DoublicateEgn`(prmEGN varchar(10),prmVid integer) RETURNS int(11)
BEGIN
  DECLARE retval integer default 0;
  
  if EXISTS (SELECT 1 FROM n_lica WHERE n_lica.Vid_id = prmVid and n_lica.EGN= prmEGN) 
  THEN
    SET retval = -1;
  ELSE
       
    IF checkNumber(prmVid, prmID) = 0 THEN
      SET retval = -2;
    END IF;  
  END IF;
  
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnCheck4DoublicateSik
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `fnCheck4DoublicateSik`(prmSIK varchar(3),prmIzbAlias varchar(6), prnTUR int, prmTOA varchar(2)) RETURNS int(11)
BEGIN
  DECLARE retval integer default 0;
  
  if EXISTS (SELECT 1 
              FROM siks s
              WHERE s.Izb_Alias = prmIzbAlias
                AND s.TUR = prmTUR
                AND s.TOA = prmToa
                AND s.Sik = prmSIK
                AND s.Status_Sekcia = 0)
  THEN
    SET retval = -1;
  END IF;
  
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnCheckLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnCheckLica`(
    prnFrom       int             
    ,prmIzbAlias  varchar(6)
    ,prmToa       varchar(2)
    ,prmTur       int 
    ,prmID        int
    ,prmVIDID     int
    ,prmEgn       varchar(10)
    ,prmIdSila    int
    ,prmSIK       varchar(3)
    ,prmKODROL    varchar(3)
    ,prmKODSPEC   varchar(3)
    ,prmKODOBR    varchar(3)
    ,prmDummy     varchar(30)
    ,prmIdReplace  int
) RETURNS varchar(250) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
  DECLARE retval,v_opisanie varchar(250) default ''  collate utf8_unicode_ci;
  DECLARE v_VIDID int default -1;
  
  SET retval     := '00';
  SET v_opisanie := '';
   
  
  IF LENGTH(IFNULL(prmKODROL,''))=0 THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва длъжност');
  END IF;



  IF LENGTH(IFNULL(prmEgn,'')) = 0 THEN
      SET retval      := '11';
      SET v_opisanie  := CONCAT('Липсва ',IF(prmVIDID=2,' ЛНЧ','ЕГН'));        
  ELSE
    
    if prnFrom = 0 THEN
        IF checkNumber(0, prmEgn) = 0 THEN
            SET v_VIDID := 0;
        ELSE
          
          IF checkNumber(2, prmEgn) = 0 THEN
              SET v_VIDID := 2;
          END IF;
        END IF;  
    ELSE
       IF checkNumber(prmVIDID, prmEgn) = 0 THEN
          SET v_VIDID = prmVIDID;
       END IF;   
    END IF;
    
    IF v_VIDID = -1 THEN
       SET retval     := '11';
       SET v_opisanie := CONCAT('Грешно ',IF(prmVIDID=2,' ЛНЧ','ЕГН'));
    END IF;
  END IF;
  
  
  IF LENGTH(IFNULL(prmSIK,''))=0 THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва СИК');
  ELSE
    IF NOT EXISTS(SELECT 1 
                    FROM SIKS 
                    WHERE IZB_ALIAS = prmIzbAlias
                     AND TOA = prmToa
                     AND TUR = prmTur
                     AND SIK = prmSIK
                     AND (Status_Sekcia=1 OR prmSIK='000')) 
    THEN
        SET retval     := '11';
        SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешнa СИК');        
    END IF;      
  END IF;

  
  IF (IFNULL(prmIdSila, 0) = 0) THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва Политическа сила');
  ELSE
    IF NOT EXISTS(SELECT 1 
                    FROM wnsila 
                    WHERE id_party = prmIdSila) THEN
        SET retval     := '11';
        SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешнa Политическа сила');        
    END IF;      
  END IF;
  
  IF IFNULL(prmKODROL,0) in (401,402,403) THEN  
    SELECT Id_sek, sik 
      INTO @v_idsik, @v_sik
      FROM siks
      WHERE sik = prmSIK
        AND IZB_ALIAS  = prmIzbAlias
        AND Toa = prmToa
        AND TUR = prmTUR
        AND Status_Sekcia=1 ;
  
    
    IF IFNULL(prmIdReplace,0) = 0 AND  @v_sik != '000' THEN
      IF EXISTS(SELECT 1 
                      FROM n_lica_izbori i 
                      WHERE i.Id_Sik    = @v_idsik
                        AND i.id_lice <> prmID
                        and i.Code_rolia = prmKODROL) THEN
                        
          SET retval     := '01';
          SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Заета длъжност ');        
      ELSE
         
          IF EXISTS(SELECT 1 
                          FROM n_lica_izbori i 
                          WHERE i.Id_Sik    = @v_idsik
                            AND i.id_lice <> prmID
                            and i.id_sila = prmIdSila
                            and i.Code_rolia in (401,402,403)) THEN
              SET retval     := '01';
              SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Друга ръководна длъжност от същата политическа сила');        
          ELSE    
           
            IF EXISTS(SELECT 1 
                          FROM n_lica_izbori i
                          WHERE i.Id_Sik  = @v_idsik
                            AND i.id_lice <> prmID
                            and i.id_sila <> prmIdSila
                            and i.Code_rolia = prmKODROL) THEN
                              
                SET retval     := '01';
                SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Заета длъжност от друга политическа сила');        
            END IF;      
          END IF;      
      END IF;      
    END IF;
  END IF;
  
  SET retval := CONCAT(retval,'|',v_opisanie);
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnGetFullSikNumber
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnGetFullSikNumber`(prmToa varchar(2)) RETURNS varchar(10) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
  DECLARE retval varchar(10) default ''  collate utf8_unicode_ci;
  
  SET NAMES 'utf8';
     
  SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID = 1;
  
  SET @v_izb_rajon = fnGetIzborenRajon(@v_izbalias,prmToa);
  
  SET retval = concat(@v_izb_rajon,'46',prmToa);      
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnGetIzborenRajon
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnGetIzborenRajon`(prmIzbAlias varchar(6),prmToa varchar(2)) RETURNS varchar(250) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
   SELECT w2.nkod
      INTO @v_izbrajon
      FROM wntoa_izbraion w1 inner join wnizbraion w2 on w1.IZB_R = w2.NKOD AND w2.IZB_ALIAS = prmIzbAlias AND w2.status=1
      WHERE w1.NKOD = prmToa;
  
  RETURN  IFNULL(@v_izbrajon,'00');  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnGetLiceBirthYear
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `fnGetLiceBirthYear`(prmEGN varchar(10)) RETURNS int(11)
BEGIN
  SET NAMES 'utf8';
         
  SET @birthyear = convert(left(prmEGN,2), UNSIGNED INTEGER);    
  SET @birthmont = convert(substring(prmEGN,3,2), UNSIGNED INTEGER);
    
  CASE 
    WHEN @birthmont > 40 THEN 
      SET @birthyear = 2000+@birthyear;
    WHEN @birthmont > 20 and @birthmont < 40 THEN 
      SET @birthyear = 1800+@birthyear;
    ELSE
      SET @birthyear = 1900+@birthyear;      
  END CASE;  
  
  RETURN @birthyear;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnGetSikAddress
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnGetSikAddress`(prmSIK int) RETURNS varchar(500) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
  DECLARE retval varchar(500) default ''  collate utf8_unicode_ci;
  
  SET NAMES 'utf8';

  SELECT  
      CONCAT(


            IFNULL(w3.nime,''),IF(IFNULL(w3.nime,'')='','',', ')
            ,IFNULL(w4.nime,''),IF(IFNULL(w4.nime,'')='','',', ')
            ,IFNULL(s.nom,''),  IF(IFNULL(s.nom,'')='','',', ')
            ,IFNULL(w5.nime,''),IF(IFNULL(w5.nime,'')='','',', ')
            ,IFNULL(s.blok,''), IF(IFNULL(s.blok,'')='','',', ')
            ,IFNULL(s.adr_ime,'')
   )
   INTO retval 
   FROM siks s 


        inner join wnasm w3 on w3.NKOD = s.nas
         left join wnuli w4  on w4.NKOD = s.UL
         left join wnjk_kv w5 on w5.NKOD = s.JK_KV
   WHERE s.ID_SEK = prmSIK;
   
   SET retval= TRIM(IFNULL(retval,''));
   SET retval = IF(RIGHT(retval,1)=',',LEFT(retval,LENGTH(retval)-1),retval);
   
   RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnSearchNumber
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnSearchNumber`(prmDigit char) RETURNS varchar(20) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
    return CASE prmDigit
              WHEN '1' THEN 'един'
              WHEN '2' THEN 'два'
              WHEN '3' THEN 'три'
              WHEN '4' THEN 'четири'
              WHEN '5' THEN 'пет'
              WHEN '6' THEN 'шест'
              WHEN '7' THEN 'седем'
              WHEN '8' THEN 'осем'
              WHEN '9' THEN 'девет'
              ELSE ''
            END;
END//
DELIMITER ;

-- Дъмп структура за функция votingregister.fnSlovom
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` FUNCTION `fnSlovom`(prmPari numeric(12,2)) RETURNS varchar(250) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
  DECLARE retval varchar(250) default ''  collate utf8_unicode_ci;
  DECLARE v_counter int default 1;
  DECLARE v_finished INTEGER default 0;
  DECLARE v_number  char(3); 
  
  DECLARE numberCursor CURSOR FOR 
      SELECT pos, number FROM tblvalues ORDER BY pos desc;       
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished := 1;   

  SET NAMES 'utf8';
  CREATE TEMPORARY TABLE if not exists tblvalues (pos int NOT NULL AUTO_INCREMENT  PRIMARY KEY , number char(3));
  
  SET @vRest   := prmPari - FLOOR (prmPari); 
  SET @cNumber := TRIM(CAST(FLOOR (prmPari) as CHAR(50)));
  SET @cNumber := LPAD(@cNumber, 12, '0');
    
  SET v_counter := 1;
  WHILE v_counter < CHAR_LENGTH (@cNumber) do
    INSERT INTO tblvalues (number)
        VALUES (SUBSTRING(@cNumber,v_counter,3));
        
    SET v_counter=v_counter+3;
  END WHILE;

  OPEN numberCursor;
  REPEAT
      FETCH numberCursor INTO v_counter,v_number;
      IF NOT v_finished THEN

          SET @cTempStr  := '' collate utf8_unicode_ci;
          SET @cTempStr1 := '' collate utf8_unicode_ci;
          SET @cTempStr2 := '' collate utf8_unicode_ci;
          SET @cTempStr3 := '' collate utf8_unicode_ci;
         
          SET @tmpDigit  := SUBSTRING(v_number,1,1) collate utf8_unicode_ci;

          SET @cTempStr1 = fnSearchNumber(@tmpDigit);          
          SET @cTempStr1 = IF (@tmpDigit='1','сто',
                                              IF(@tmpDigit='0','', 
                                                               IF(CONVERT(@tmpDigit,UNSIGNED INTEGER)>3, 
                                                                              CONCAT(@cTempStr1,'стотин'),
                                                                              IF(@tmpDigit='2','двеста',CONCAT(@cTempStr1,'ста')))));

          IF SUBSTRING(v_number,2,1) = '1' THEN
              IF SUBSTRING(v_number,3,1) = '0' THEN
                SET @cTempStr2 := 'десет';
              ELSE
                SET @cTempStr2 :=  fnSearchNumber(SUBSTRING(v_number,3,1));                
                SET @cTempStr2 := IF(SUBSTRING(v_number,3,1)='1','единадесет',CONCAT(@cTempStr2,'надесет'));
              END IF;  
         ELSE
            SET @cTempStr2  := fnSearchNumber(SUBSTRING(v_number,2,1));                              
            SET @cTempStr2 := IF(IFNULL(@cTempStr2,'')='','',concat(@cTempStr2,'десет'));
            SET @cTempStr3 := fnSearchNumber(SUBSTRING(v_number,3,1));                              
         END IF;
  
         SET @cTempStr :=  CASE
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr2,@cTempStr3),'')='' 
                                    THEN ''
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr2),'')='' AND IFNULL(@cTempStr3,'')>''                                 
                                    THEN @cTempStr3
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr3),'')='' AND IFNULL(@cTempStr2,'')>'' 
                                    THEN @cTempStr2
                              WHEN IFNULL(concat(@cTempStr2,@cTempStr3),'')='' AND IFNULL(@cTempStr1,'')>'' 
                                    THEN @cTempStr1
                              WHEN IFNULL(@cTempStr1,'')='' AND IFNULL(@cTempStr2,'')>'' AND IFNULL(@cTempStr3,'')>'' 
                                    THEN CONCAT(@cTempStr2,' и ',@cTempStr3)
                              WHEN IFNULL(@cTempStr2,'')='' AND IFNULL(@cTempStr1,'')>'' AND IFNULL(@cTempStr3,'')>'' 
                                    THEN CONCAT(@cTempStr1,' и ',@cTempStr3)
                              WHEN IFNULL(@cTempStr3,'')='' AND IFNULL(@cTempStr1,'')>'' AND IFNULL(@cTempStr2,'')>'' 
                                    THEN CONCAT(@cTempStr1,' и ',@cTempStr2)
                              ELSE
                                    CONCAT(@cTempStr1,' ',@cTempStr2, ' и ',@cTempStr3)
                            END;
     
         SET @cTempStr := CASE
                            WHEN v_counter = 1
                                 THEN IF (v_number='001',concat(@cTempStr,' милиард'),
                                                                    IF (v_number='000','',concat(@cTempStr,' милиарда')))
                            WHEN v_counter = 2
                                 THEN IF (v_number='001',concat(@cTempStr,' милион'),
                                                                    IF (v_number='000','',concat(@cTempStr,' милиона')))
                            WHEN v_counter = 3
                                 THEN CASE
                                        WHEN v_number = '000' THEN ''
                                        WHEN v_number = '001' THEN 'хиляда'
                                        WHEN v_number = '002' THEN 'две хиляди'
                                        ELSE concat(@cTempStr ,' хиляди')
                                      END     
                            ELSE @cTempStr          
                         END;
                         
         
         SET v_finished := 0;                    
   
         SET retval := concat(IF(IFNULL(@cTempStr,'')='','',concat(@cTempStr,' ')),retval);    
      END IF;
      
  UNTIL v_finished END REPEAT;   
  CLOSE numberCursor;
  
  SET retval := TRIM(retval);
  SET @cTempStr := TRIM(SUBSTRING_INDEX(retval, ' ', -1));

  IF @cTempStr not in ('','хиляди','милион','милиона','милиард','милиарда') THEN           
      SET @cTempStr := TRIM(SUBSTRING_INDEX(retval,' и ', -1));
      
  END IF;           

  SET retval := concat(retval,' лв.');
  
  IF @vRest > 0 THEN
      SET retval := concat(retval,' и ',TRIM(cast((CAST(@vRest*100 as SIGNED )) as CHAR(10))),' ст.');
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  RETURN retval;  	
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.getIzbRajoni
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `getIzbRajoni`(prmIizbAlias varchar(6))
BEGIN
  SET NAMES 'utf8';
  
  SELECT NKOD, NIME
     FROM wnizbraion
     WHERE IZB_ALIAS = prmIizbAlias
       AND status = 1;
       
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.getMaxMemebers4IzbRajoni
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `getMaxMemebers4IzbRajoni`(
  prmTOA varchar(2)
)
BEGIN
  SET NAMES 'utf8';
    
 SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID =1;
      
  SELECT w.MAX_BROI_SIK
     INTO @v_maxmembers
     FROM wnizbraion w inner join wntoa_izbraion w1 on w.NKOD = w1.IZB_R and w1.NKOD=prmTOA
     WHERE w.izb_alias = @v_izbalias
       AND w.status = 1;
       
  SELECT @v_maxmembers-3 as id;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.getMaxTur4Izbori
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `getMaxTur4Izbori`()
BEGIN
  SET NAMES 'utf8';
    
 SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);
      
  SELECT TUR
     INTO @v_maxtur
     FROM wntipizbori
     WHERE nkod = LEFT(@v_izbalias,2)
       AND status = 1;
       
  SELECT @v_maxtur as id;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.getPaymentCorrection
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `getPaymentCorrection`(
   prmIdLice  int
)
BEGIN
  DECLARE prmIME      varchar(250);  
  
  SET NAMES 'utf8';

  SELECT  n.NIME as TEXT, p.PARI
    FROM n_lice_pari_zaplashtane p 
          inner join n_lica_izbori i ON i.ID = p.Id_lice and i.TUR = 1
          inner join n_list_codepositions n
              ON p.Code_Table = n.PKODE AND p.Code_possition = n.NKODE
    WHERE i.ID_Lice =  prmIdLice;
  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.getSikAddress
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `getSikAddress`(
  prmSIKS    int
)
BEGIN
  SET NAMES 'utf8';
   
  SELECT fnGetSikAddress(prmSIKS) as address;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.importLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `importLica`(
   prmUSER      varchar(128) 
   ,prmIzbAlias varchar(6)
   ,prmTur      int
   ,prmToa      varchar(2)
   ,prmIdSila   int
   ,prmDummy    varchar(30)
)
BEGIN
  DECLARE v_finished,v_IDIMP,v_impstatus,v_id INTEGER DEFAULT 0;
  DECLARE v_IM1, v_IM2, v_IM3, v_ROLJA, v_OBRA, v_SPEC, v_TEL  varchar(100) DEFAULT "";
  DECLARE v_KODROL, v_KODSPEC, v_KODOBR, v_SIK varchar(3) DEFAULT "";
  DECLARE v_opisanie  varchar(1000) DEFAULT "";
  DECLARE v_egn varchar(10) DEFAULT "";
  DECLARE v_VIDID int DEFAULT -1;
  DECLARE v_cntall, v_cntadd,v_cntneval, v_cntothv int default 0;
  DECLARE prmIME      varchar(250);
    
   
  DEClARE lica_cursor CURSOR FOR 
  SELECT i.ID, i.EGN, TRIM(i.IM1), TRIM(i.IM2), TRIM(i.IM3), LPAD(IFNULL(TRIM(i.SIK),''), 3, '0'), i.ROLJA, i.OBRA, i.SPEC, i.TEL, IFNULL(l.id,0) 
    FROM n_lica_import i left join n_lica l on i.egn = l.egn
    WHERE i.USER = prmUSER 
      AND i.STATUS = 0;
   
   
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;   
  
  SET NAMES 'utf8';
    
  OPEN lica_cursor;  
  read_loop: LOOP
    FETCH lica_cursor INTO v_IDIMP, v_egn, v_IM1, v_IM2, v_IM3, v_SIK, v_ROLJA, v_OBRA, v_SPEC, v_TEL,v_id ;
    IF  v_finished  THEN
        LEAVE read_loop;
    END IF;
    
    SET v_impstatus := 0;
    SET v_opisanie  := '';
     
    SELECT Id_sek 
      INTO @v_idsik
      FROM siks
      WHERE sik = v_SIK
        AND IZB_ALIAS  = prmIzbAlias
        AND Toa = prmToa
        AND TUR = prmTUR
        AND (Status_Sekcia=1 OR v_SIK='000');

    
    IF IFNULL(@v_idsik,0) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := 'Несъществуваща или нективна секция';
    END IF;

    IF LENGTH(IFNULL(v_IM1,'')) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Няма име');
    ELSE
        IF (SELECT v_IM1 REGEXP "^[а-яА-Я]+(([а-яА-Я-])?[а-яА-Я]*)*$") = 0 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Името съдържа непозволени символи');
        END IF;
    END IF;


    IF LENGTH(IFNULL(v_IM2,'')) > 0 THEN
      IF (SELECT v_IM2 REGEXP "^[а-яА-Я]+(([а-яА-Я])?[а-яА-Я]*)*$") = 0 THEN
          SET v_impstatus := 2;
          SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Презимето съдържа непозволени символи');
      END IF;
    END IF;
    
    IF LENGTH(IFNULL(v_IM3,'')) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Няма фамилия');
    ELSE
        IF (SELECT v_IM3 REGEXP "^[а-яА-Я]+(([а-яА-Я- ])?[а-яА-Я]*)*$") = 0 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Фамилията съдържа непозволени символи');
        END IF;
    END IF;
     
    
    IF checkNumber(0, v_egn) = 0 THEN
        SET v_VIDID := 0;
    ELSE
      
      IF checkNumber(2, v_egn) = 0 THEN
          SET v_VIDID := 2;
      END IF;
    END IF;  
    
    SET @v_fullsikcode = '';
    
    SELECT CONCAT(s.AA_BB_CC, ' ', w.Short_name)
       INTO @v_fullsikcode
       FROM n_lica l
            left join n_lica_izbori i on l.id = i.id_lice
                inner join wnsila w on w.ID_Party = i.id_sila
                inner join siks s on i.id_sik = s.Id_sek
       WHERE l.id <> v_id
         and l.Vid_id = v_VIDID 
         and AES_DECRYPT(FROM_BASE64(l.EGN),prmDummy)=v_egn
         and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
       LIMIT 1;                  
       
    IF LENGTH(IFNULL (@v_fullsikcode,''))>0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Дублирано ЕГН (',@v_fullsikcode,')');
    ELSE    
        IF v_VIDID = -1 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешно ЕГН/ЛНЧ');
        END IF;
    END IF;

    IF v_impstatus = 0 THEN
        
        SELECT Id_sek 
          INTO @v_idnullsik
          FROM siks
          WHERE sik = '000'
            AND IZB_ALIAS  = prmIzbAlias
            AND Toa = prmToa
            AND TUR = prmTUR;
        
        SET v_KODROL = '';    
        SELECT NKODE INTO v_KODROL 
          FROM n_list_codepositions
          WHERE PKODE = '4'
             AND IZB_ALLIAS  = prmIzbAlias
             AND UPPER(NIME) = UPPER(v_ROLJA);
          
        SET v_KODSPEC  = '';  
        SELECT NKOD INTO v_KODSPEC 
          FROM wnspec
          WHERE UPPER(NIME) = UPPER(v_SPEC);

        SET v_KODOBR = '';
        SELECT NKOD INTO v_KODOBR 
          FROM wnszem
          WHERE UPPER(NIME) = UPPER(v_OBRA);
              
        SET v_opisanie  := fnCheckLica (0,prmIzbAlias,prmToa,prmTur,v_id,v_VIDID,v_egn,prmIdSila,v_SIK,v_KODROL,v_SPEC,v_OBRA,prmDummy,0);

        SET @v_error := CAST(LEFT(v_opisanie,2) as unsigned);

        IF @v_error > 0 THEN
          IF @v_error > 10 THEN
            SET v_impstatus := 2;            
          ELSE
            SET v_impstatus := 1;
          END IF;
        END IF;
        
        SET v_opisanie := SUBSTRING(v_opisanie,4);
        
        IF v_impstatus = 2 THEN
            SET v_cntneval = v_cntneval+1;                        
        ELSE
          
      	  IF v_id > 0 THEN
             IF v_impstatus=0 THEN  
               SET v_cntadd = v_cntadd+1;
               
               UPDATE n_lica 
                  SET  Vid_id  = v_VIDID
                      ,EGN    = TO_BASE64(AES_ENCRYPT(v_egn,prmDummy))
                      ,IM1    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy))
                      ,IM2    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy))
                      ,IM3    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy))
                      ,Obra   = v_KODOBR
                      ,Spec   = v_KODSPEC
                      ,TEL    = v_TEL
                      ,impstatus  = v_impstatus
                      ,impmessage = v_opisanie
                      ,USER   = prmUSER
                      ,KOGA   = now()
                  WHERE ID = v_id;
              
               UPDATE n_lica_izbori
                  SET Id_Sik=@v_idsik
                     ,id_sila=prmIdSila
                     ,Code_rolia=v_KODROL
                     ,KOGA=now()        
                  where id_lice = v_id 
                    and Izb_Alias = prmIzbAlias
                    and TUR = prmTur;    

             ELSE
                SET v_cntothv = v_cntothv+1;                 
             END IF;
          ELSE
              IF v_impstatus=0 THEN  
                SET v_cntadd = v_cntadd+1;
              ELSE 
                SET v_cntothv = v_cntothv+1; 
              END IF;
              
              INSERT INTO n_lica (VID_ID,EGN,IM1,IM2 ,IM3,Obra,Spec,TEL,impstatus,impmessage,USER,KOGA)
                      VALUES (
                        v_VIDID
                        ,TO_BASE64(AES_ENCRYPT(v_egn,prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy))
                        ,v_KODOBR
                        ,v_KODSPEC
                        ,v_TEL
                        ,v_impstatus
                        ,v_opisanie
                        ,prmUSER
                        ,now()
                      );
             
              SELECT LAST_INSERT_ID() INTO v_id FROM DUAL;    
                            
              IF v_id > 0 THEN
                INSERT INTO n_lica_izbori (ID_Lice,Izb_Alias,Tur,TOA,Id_Sik,id_sila,Re,Code_rolia,Ime_rolia,hasmaxincome,USER,KOGA)
                    VALUES (v_id,prmIzbAlias, prmTur, prmToa
                            ,IF(v_impstatus=1,@v_idnullsik,@v_idsik)
                            ,prmIdSila, '', v_KODROL, '',0,prmUser, now());
              END IF;

          END IF;                           
        END IF;
    ELSE
        SET v_cntneval = v_cntneval+1;                        
    END IF;
    
    SET v_cntall = v_cntall+1;
    
    UPDATE n_lica_import
        SET opisanie = v_opisanie, status = 1+v_impstatus
        WHERE ID = v_IDIMP;
    
    SET v_finished = 0;  
    
  END LOOP read_loop;
  CLOSE lica_cursor;       
  
  SELECT concat("Обработени: "
                ,cast(v_cntall as char)
                ,' записа, Добавени: '
                ,cast(v_cntadd as char)
                ,' записа, Отхвърлени: '
                ,cast(v_cntneval as char)
                ,' записа, Невалидни: '
                ,cast(v_cntothv as char)
                ,' записа')  as ImpExcelMessage
        ,v_cntothv+v_cntneval as wrongRec ;  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.insertLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `insertLica`(
   prmVid_id      int
  ,prmEGN         varchar(128)
  ,prmIM1         varchar(128)
  ,prmIM2         varchar(128)
  ,prmIM3         varchar(128)
  ,prmObra        varchar(16)
  ,prmSpec        varchar(16)
  ,prmTEL         varchar(14) 
  ,prmPAS1        varchar(1)
  ,prmPAS2        varchar(10)
  ,prmPAS3        datetime
  ,prmPAS4        varchar(2)
  ,prmNAZ         varchar(2)
  ,prmOBL         varchar(3)
  ,prmOBS         varchar(5)
  ,prmRAJ         varchar(2)
  ,prmNAS         varchar(5)
  ,prmULKOD       varchar(5)
  ,prmNOM         varchar(6)
  ,prmJK_KV       varchar(2)
  ,prmBLOK        varchar(5)
  ,prmVH          varchar(2)
  ,prmET          varchar(2)
  ,prmAP          varchar(3)
  ,prmPK          varchar(4)
  ,prmimpstatus   int
  ,prmimpmessage  varchar(100)
  ,prmUSER        varchar(128) 
  ,prmToa         varchar(2)  
  ,prmDummy       varchar(30)
  ,OUT prmId      int
)
BEGIN
    DECLARE prmIME      varchar(250);

    SET NAMES 'utf8';
     
    IF NOT EXISTS(SELECT 1 
                    FROM n_lica l 
                          inner join n_lica_izbori i on l.ID = i.id_lice
                          inner join siks s on i.ID_sik = s.id_sek                    
                    WHERE l.VID_ID =  prmVid_id 
                      AND l.EGN = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
                      and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
                  )
    THEN                      
        INSERT INTO n_lica (VID_ID,EGN,IM1,IM2 ,IM3,Obra,Spec,TEL,PAS1,PAS2,PAS3,PAS4,NAZ
              ,OBL,OBS,RAJ,NAS,UL,NOM,JK_KV,BLOK,VH,ET,AP,PK,impstatus,impmessage,USER,KOGA
        )
        VALUES (
          prmVid_id
    
          
          ,TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy))
          
          ,prmObra
          ,prmSpec
          ,prmTEL
          ,prmPAS1
          ,prmPAS2
          ,prmPAS3
          ,prmPAS4
          ,prmNAZ
          ,prmOBL
          ,prmOBS
          ,prmRAJ
          ,prmNAS
          ,prmULKOD
          ,prmNOM
          ,prmJK_KV
          ,prmBLOK
          ,prmVH
          ,prmET
          ,prmAP
          ,prmPK
          ,prmimpstatus
          ,prmimpmessage
          ,prmUSER
          ,now()
        );
      
       SELECT LAST_INSERT_ID() INTO prmID FROM DUAL;    

       SET prmIME =  CONCAT(TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy)),' ',
                           IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy)),''),' ',
                           IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy)),''));

       call createLog (prmUSER, 1,'Ново лице',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');

       SELECT prmID as 'Id' FROM DUAL;
    ELSE
       SELECT -1 as 'Id' FROM DUAL;
    END IF;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.insertLicaZamestvane
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `insertLicaZamestvane`(
  prmIdLiceNovo   int
  ,prmIdLiceStaro int(11)
  ,prmUSER        varchar(128)
  ,prmTIP         int
)
BEGIN
    SET NAMES 'utf8';
    
    SELECT cast(value as unsigned integer)
      INTO @v_tur
      FROM sys_main 
      WHERE ID = 2;
      
    
    SELECT ID 
      INTO @v_id_lice_staro
      FROM n_lica_izbori 
      WHERE ID_LICE = prmIdLiceStaro
        AND TUR = @v_tur;
  
    SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR, i.id_sila, i.Code_rolia
        INTO @v_idsik, @v_IzbAlias, @v_toa, @v_tur, @v_idsila, @v_id_rolja
        FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
        WHERE i.id =  @v_id_lice_staro;
    
    DELETE FROM n_lica_izbori_zamestvane 
        WHERE Id_Lice_staro = @v_id_lice_staro
          AND Id_Lice_novo  = prmIdLiceNovo;
      
    IF prmTIP = 2 THEN      
      SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR, i.id_sila, i.Code_rolia
          INTO @v_idsiknovo, @v_IzbAlias, @v_toa, @v_tur, @v_idsilanova, @v_id_roljanova
          FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
          WHERE i.id =  prmIdLiceNovo;
      
      
      UPDATE n_lica_izbori
          SET Id_Sik = @v_idsiknovo
          WHERE ID =  @v_id_lice_staro;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (prmIdLiceNovo, @v_id_lice_staro,@v_idsila,@v_id_rolja,@v_idsik,prmUSER ,now());
      
      
      UPDATE n_lica_izbori
          SET Id_Sik = @v_idsik
          WHERE ID =  prmIdLiceNovo;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (@v_id_lice_staro, prmIdLiceNovo, @v_idsilanova,@v_id_roljanova,@v_idsiknovo,prmUSER ,now());
      
    ELSE
      
      SELECT Id_sek 
          INTO @v_idnullsik
          FROM siks
          WHERE sik = '000'
            AND IZB_ALIAS  = @v_IzbAlias
            AND Toa = @v_Toa
            AND TUR = @v_TUR;  

      UPDATE n_lica_izbori
          SET Id_Sik = @v_idnullsik
          WHERE ID =  @v_id_lice_staro;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (prmIdLiceNovo, @v_id_lice_staro,@v_idsila,@v_id_rolja,@v_idsik,prmUSER ,now());
    END IF;
    
    SELECT LAST_INSERT_ID() as `Id` FROM DUAL;     
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.insertSik
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `insertSik`(
  prmIzb_Alias  varchar(6)
  ,prmTUR       int
  ,prmIzb_rajon varchar(2)
  ,prmTOA       varchar(2)
  ,prmAA_BB_CC  varchar(6)
  ,prmSik       varchar(3)
  ,prmObl       varchar(3)
  ,prmObs       varchar(5)
  ,prmNAS       varchar(5)
  ,prmJK_KV     varchar(2)
  ,prmUL        varchar(5)
  ,prmNom       varchar(5)
  ,prmBLok      varchar(5)
  ,prmADR_IME   varchar(250)
  ,prmUSER      varchar(128)
  ,prmStatus_Sekcia int
  ,prmBroiMembers int
  ,OUT prmId    int
)
BEGIN
    SET NAMES 'utf8';

    SET @v_izbrajon = IFNULL(fnGetIzborenRajon(prmIzb_Alias,prmTOA),'00');
    SET @v_FullSIK = CONCAT(fnGetFullSikNumber(prmTOA),prmSik) collate utf8_unicode_ci;
    
    INSERT INTO siks (Izb_Alias,TUR,Izb_rajon,TOA,AA_BB_CC,Sik,
                      Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,USER,KOGA,Status_Sekcia,
                      broimembers)
    VALUES (
      prmIzb_Alias
      ,prmTUR
      ,@v_izbrajon 
      ,prmTOA
      ,@v_FullSIK
      ,prmSik
      ,prmObl
      ,prmObs
      ,prmNAS
      ,prmJK_KV
      ,prmUL
      ,prmNom
      ,prmBLok
      ,prmADR_IME
      ,prmUSER
      ,now()
      ,1
      ,prmBroiMembers             
    );
  
     SELECT LAST_INSERT_ID() INTO prmId FROM DUAL;    
     
    call createSikLog (prmUser, prmTOA, @v_FullSIK, 12, 'Нова','','');
    SELECT prmId as 'Id' FROM DUAL;    
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.insertToaMain
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `insertToaMain`(
  prmIzb_Alias       varchar(6)
  ,prmTOA            varchar(2)
  ,prmTur            tinyint
  ,prmStatus_Master  int
  ,prmIME            varchar(30)
  ,prmTEL            varchar(10)
  ,prmTel1           varchar(10)
  ,prmIzr            varchar(15)
  ,prmOBL            varchar(3)
  ,prmOBS            varchar(5)
  ,prmRAJ            varchar(2)
  ,prmNAS            varchar(5)
  ,prmUL             varchar(5)
  ,prmNOM            varchar(4)
  ,prmJK_KV          varchar(2)
  ,prmBLOK           varchar(5)
  ,prmVH             varchar(2)
  ,prmET             varchar(2)
  ,prmAP             varchar(3)
  ,prmPK             varchar(4)
  ,prmEPOD           varchar(30)
  ,prmIPOD           varchar(20)
  ,prmPred           varchar(20)
  ,prmSekr           varchar(20)
  ,prmNsik           int
  ,prmPris           varchar(10)
  ,prmR1             varchar(20)
  ,prmR2             varchar(20)
  ,prmANO            int
  ,prmBul            varchar(13)
  ,prmUSER           varchar(128)    
)
BEGIN
    SET NAMES 'utf8';

    IF checkNumber (3,prmBul) = -1 THEN
       SET prmBul = '';
    END IF;  
   
    SET @izbrajon =  fnGetIzborenRajon(prmIzb_Alias, prmToa);
  
    SELECT  NIME, PREFIX
      INTO @izbrajon_name, @izbrajon_predstavka
      FROM wnizbraion
      WHERE nkod =  @izbrajon
        AND IZB_ALIAS =prmIzb_Alias;
     
     
    IF LENGTH(prmOBL) = 0 THEN
      SET @OBL = 'SOF46';
    ELSE  
      SET @OBL =prmOBL;
    END IF;
    
    IF LENGTH(prmOBS) = 0 THEN
      SET @OBS = 'SOF46';
    ELSE  
      SET @OBS =prmOBL;
    END IF;
     
    IF LENGTH(prmNAS) = 0 THEN
      SET @NAS = '68134';
    ELSE  
      SET @NAS =prmNAS;
    END IF;
    
    INSERT INTO n_toa_main (`IZB_ALIAS`,`TOA`,`Tur`,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                           ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`)
    VALUES (
      prmIzb_Alias
      ,prmTOA
      ,prmTur
      ,prmStatus_Master
      ,prmIME
      ,prmTEL
      ,prmTel1
      ,prmIzr
      ,@OBL
      ,@OBS
      ,prmRAJ
      ,@NAS
      ,prmUL
      ,prmNOM
      ,prmJK_KV
      ,prmBLOK
      ,prmVH
      ,prmET
      ,prmAP
      ,prmPK
      ,prmEPOD
      ,prmIPOD
      ,prmPred
      ,prmSekr
      ,prmNsik
      ,IFNULL(@izbrajon_predstavka,'0000')
      ,@izbrajon_name
      ,prmR2
      ,prmANO
      ,prmBul
    );
  
    SELECT LAST_INSERT_ID() INTO @Id FROM DUAL;    
  
    call createLog (prmUSER, 5,'Нов Административен район',IFNULL(prmIME,''),IFNULL(prmToa,''),'');  
    SELECT @Id as 'Id' FROM DUAL;    
END//
DELIMITER ;

-- Дъмп структура за таблица votingregister.normi_operacii
CREATE TABLE IF NOT EXISTS `normi_operacii` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `Izb_allias` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tur` int(1) DEFAULT NULL,
  `Vid_codetable` char(1) COLLATE utf8_unicode_ci DEFAULT '3',
  `Idcodeposition` int(11) DEFAULT NULL,
  `Pari` decimal(6,2) DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.normi_operacii: ~0 rows (приблизително)
DELETE FROM `normi_operacii`;
/*!40000 ALTER TABLE `normi_operacii` DISABLE KEYS */;
/*!40000 ALTER TABLE `normi_operacii` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.normi_priznaci
CREATE TABLE IF NOT EXISTS `normi_priznaci` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `Izb_allias` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tur` int(1) DEFAULT NULL,
  `Vid_codetable` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '2',
  `Idcodeposition` int(11) DEFAULT NULL,
  `Pari` decimal(6,2) DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.normi_priznaci: ~0 rows (приблизително)
DELETE FROM `normi_priznaci`;
/*!40000 ALTER TABLE `normi_priznaci` DISABLE KEYS */;
/*!40000 ALTER TABLE `normi_priznaci` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.normi_roli
CREATE TABLE IF NOT EXISTS `normi_roli` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `Izb_allias` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tur` int(1) DEFAULT NULL,
  `Vid_codetable_1` int(11) DEFAULT NULL,
  `Idcodeposition_1` int(11) DEFAULT NULL,
  `Vid_Codetable` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '4',
  `Idcodeposition` int(11) DEFAULT NULL,
  `Pari` decimal(6,2) DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.normi_roli: ~16 rows (приблизително)
DELETE FROM `normi_roli`;
/*!40000 ALTER TABLE `normi_roli` DISABLE KEYS */;
INSERT INTO `normi_roli` (`ID`, `Izb_allias`, `Tur`, `Vid_codetable_1`, `Idcodeposition_1`, `Vid_Codetable`, `Idcodeposition`, `Pari`, `Status`, `User`, `Koga`) VALUES
	(1, 'PR2021', 1, 1, 101, '4', 401, 100.00, 1, NULL, '2019-12-18 15:41:19.385207'),
	(2, 'PR2021', 1, 1, 101, '4', 402, 90.00, 1, NULL, '2019-12-18 15:41:30.761696'),
	(3, 'PR2021', 1, 1, 101, '4', 403, 90.00, 1, NULL, '2019-12-18 15:42:04.022835'),
	(4, 'PR2021', 1, 1, 101, '4', 404, 80.00, 1, NULL, '2019-12-18 15:42:11.110928'),
	(9, 'PR2021', 1, 1, 102, '4', 401, 1000.00, 1, NULL, '2019-12-18 15:55:08.939996'),
	(10, 'PR2021', 1, 1, 102, '4', 402, 900.00, 1, NULL, '2019-12-18 15:55:12.729492'),
	(11, 'PR2021', 1, 1, 102, '4', 403, 900.00, 1, NULL, '2019-12-18 15:55:16.717051'),
	(12, 'PR2021', 1, 1, 102, '4', 404, 800.00, 1, NULL, '2019-12-18 15:55:19.942870'),
	(66, 'PR2021', 2, 1, 101, '4', 401, 100.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(67, 'PR2021', 2, 1, 101, '4', 402, 90.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(68, 'PR2021', 2, 1, 101, '4', 403, 90.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(69, 'PR2021', 2, 1, 101, '4', 404, 80.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(70, 'PR2021', 2, 1, 102, '4', 401, 1000.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(71, 'PR2021', 2, 1, 102, '4', 402, 900.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(72, 'PR2021', 2, 1, 102, '4', 403, 900.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000'),
	(73, 'PR2021', 2, 1, 102, '4', 404, 800.00, 1, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000');
/*!40000 ALTER TABLE `normi_roli` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica
CREATE TABLE IF NOT EXISTS `n_lica` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `Vid_id` int(1) DEFAULT NULL,
  `EGN` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `IM1` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IM2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IM3` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Obra` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Spec` varchar(16) CHARACTER SET latin1 DEFAULT NULL,
  `TEL` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAS1` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAS2` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAS3` datetime(6) DEFAULT NULL,
  `PAS4` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAZ` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'BG',
  `OBL` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OBS` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RAJ` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAS` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UL` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOM` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JK_KV` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BLOK` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VH` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ET` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AP` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PK` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `impstatus` int(11) DEFAULT NULL,
  `impmessage` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `JK_KV` (`JK_KV`),
  KEY `NAS` (`NAS`),
  KEY `OBL` (`OBL`),
  KEY `OBS` (`OBS`),
  KEY `RAJ` (`RAJ`),
  KEY `UL` (`UL`)
) ENGINE=InnoDB AUTO_INCREMENT=1834 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica: ~11 rows (приблизително)
DELETE FROM `n_lica`;
/*!40000 ALTER TABLE `n_lica` DISABLE KEYS */;
INSERT INTO `n_lica` (`ID`, `Vid_id`, `EGN`, `IM1`, `IM2`, `IM3`, `Obra`, `Spec`, `TEL`, `PAS1`, `PAS2`, `PAS3`, `PAS4`, `NAZ`, `OBL`, `OBS`, `RAJ`, `NAS`, `UL`, `NOM`, `JK_KV`, `BLOK`, `VH`, `ET`, `AP`, `PK`, `impstatus`, `impmessage`, `USER`, `KOGA`) VALUES
	(1821, 0, 'b4T2xE1z+EeRZUgmAkXLRA==', 'tpN3UD55F9HR6jq1eeDEDw==', 'adLuG6poNtDfNmHsC7gHag==', 'zMvrv19SoqCAZ6LfA6JV5Wnc5RxxamI4qGzTqW3cCM8=', '01', '02', NULL, 'f', NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-19 16:07:53.000000'),
	(1822, 0, 'aeI4uag8CBeFbcuyAW5z6g==', 'yPEJjFBqMJgUJ3vVVlRpow==', 'Z8X0O5W89b9/l1+qbeRAIw==', 'pIBhkGOqeBmjEgprx17Oq3l8dSy78w8cypQxyTkuJYw=', '01', '03', '5555555555', 'f', NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-26 16:18:16.000000'),
	(1823, 0, 'zRtrW5pkVqLdRO6zdW/cjQ==', 'RkCUtZcdURjNp3Q3mg78fQ==', '2lJ1abUlonNyXbrNqN4rIw==', 'V+30setvBk9L94k6/ZFJl9f0PJ2hgpEHXK1bJTZ/hAM=', '', '', '333', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1824, 0, 'ncTa0QZ9/qk6qsIiayA+pg==', 'UVh9y1lmObTX+KvAcbbvew==', 'nNl8AhbeXU4Qbh6ID/u5V2nc5RxxamI4qGzTqW3cCM8=', 'Z8X0O5W89b9/l1+qbeRAIw==', '', '', '', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1825, 0, 'zKI9Nc0EsGReuspkq115TQ==', 'eyIZjDUzV0Cqzl6yN1A+V9f0PJ2hgpEHXK1bJTZ/hAM=', 'PWtA8V9cxd2Z+auIK4JslQ==', '1fxbocFS8FJDtT6gcLy1/A==', '01', '02', '', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1826, 0, 'Y/+xFHZzOfNyfB5no9Tpeg==', 'AcucX9aw1A2q+n7Rf6EJEQ==', 'FZEF6o1ALsfMweTj5vk1WGnc5RxxamI4qGzTqW3cCM8=', 'yH7hw9tFY9YcHnyt+Dnzgdf0PJ2hgpEHXK1bJTZ/hAM=', '', '', '', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1827, 0, 'MojRg0rhyj33BclMIGfUUg==', 'BNBVkK+lEc07hWkXNsZ2pA==', 'FZEF6o1ALsfMweTj5vk1WGnc5RxxamI4qGzTqW3cCM8=', 'zJ0BUC2SP2RnyOMyVCpiaWnc5RxxamI4qGzTqW3cCM8=', '', '', '88888888', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1828, 0, 'S6r59jqY09AcZX0qh5WYGA==', '3N0vOOmE5cBDhNwWSC7iJA==', '6PgXzARQoCQvppt4NaRoaE2ql9rShVSwVUrmca5qBYU=', 'IFfUkUGeCOue/uhjad2MKmnc5RxxamI4qGzTqW3cCM8=', '', '', '', NULL, NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000'),
	(1829, 0, 'I2wLoK/BheqHo2nwaOz8Eg==', '1IdWUkQmJ0I9QR3lU9PAvQ==', '5wEXV7VnwqT9WfpBh+aLZw==', 'C5veE+X40cdqMGZXAmPAZdf0PJ2hgpEHXK1bJTZ/hAM=', '00', '00', NULL, 'f', NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:55:53.000000'),
	(1830, 0, 'pfUlOGfcQ8UglBRImomv6w==', 'nML10vdYswReizSC2ZRd6g==', 'qCS6Z2lHL7JC2gZIE2ZLLw==', 'qCS6Z2lHL7JC2gZIE2ZLLw==', '00', '00', NULL, 'f', NULL, '0001-01-01 00:00:00.000000', NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 15:27:56.000000'),
	(1832, 0, 'BtmaJkyEWIkDtECHzck6yA==', 'tpN3UD55F9HR6jq1eeDEDw==', 'UDYLirXmhqdk5T5ggcJZGGnc5RxxamI4qGzTqW3cCM8=', 'bsgXO1Gko6BMkg0N0Af6GA==', '00', '00', NULL, 'f', NULL, NULL, NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-26 16:21:21.000000'),
	(1833, 0, 'BtmaJkyEWIkDtECHzck6yA==', 'fRqvlVD31w4qMtMoaecZdw==', 'UDYLirXmhqdk5T5ggcJZGGnc5RxxamI4qGzTqW3cCM8=', 'bsgXO1Gko6BMkg0N0Af6GA==', '00', '00', NULL, 'f', NULL, '0001-01-01 00:00:00.000000', NULL, 'BG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-19 16:28:53.000000');
/*!40000 ALTER TABLE `n_lica` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_dopylnenie
CREATE TABLE IF NOT EXISTS `n_lica_dopylnenie` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `Id_Lice` int(7) DEFAULT NULL,
  `VidCodetable` int(11) DEFAULT NULL,
  `Idcodeposition` int(11) DEFAULT NULL,
  `Status` int(1) DEFAULT '1',
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_nlicadop_nlica` (`Id_Lice`),
  CONSTRAINT `FK_nlicadop_nlica` FOREIGN KEY (`Id_Lice`) REFERENCES `n_lica_izbori` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_dopylnenie: ~2 rows (приблизително)
DELETE FROM `n_lica_dopylnenie`;
/*!40000 ALTER TABLE `n_lica_dopylnenie` DISABLE KEYS */;
/*!40000 ALTER TABLE `n_lica_dopylnenie` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_dopylnenie_ottur1
CREATE TABLE IF NOT EXISTS `n_lica_dopylnenie_ottur1` (
  `ID` int(7) NOT NULL,
  `Id_Lice` int(7) DEFAULT NULL,
  `VidCodetable` int(11) DEFAULT NULL,
  `Idcodeposition` int(11) DEFAULT NULL,
  `Status` int(1) DEFAULT '1',
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_dopylnenie_ottur1: ~0 rows (приблизително)
DELETE FROM `n_lica_dopylnenie_ottur1`;
/*!40000 ALTER TABLE `n_lica_dopylnenie_ottur1` DISABLE KEYS */;
/*!40000 ALTER TABLE `n_lica_dopylnenie_ottur1` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_import
CREATE TABLE IF NOT EXISTS `n_lica_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `egn` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `im1` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `im2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `im3` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SIK` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `Rolja` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Obra` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Spec` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `opisanie` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_import: ~9 rows (приблизително)
DELETE FROM `n_lica_import`;
/*!40000 ALTER TABLE `n_lica_import` DISABLE KEYS */;
INSERT INTO `n_lica_import` (`id`, `egn`, `im1`, `im2`, `im3`, `SIK`, `Rolja`, `Obra`, `Spec`, `Tel`, `status`, `opisanie`, `user`) VALUES
	(1, '4406166731', 'ПЕНКА', 'ИВАНОВА', 'КАРАГЕОРГИЕВА', '1', 'Председател', 'Магистър', 'Икономист', '5555555555', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(2, '4407316651', 'ДОНКА', 'ЙОТОВА', 'БРАТАНОВА', '10', 'Секретар', '', '', '333', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(3, '4408276316', 'МАРИЯНА', 'КИРИЛОВА', 'ИВАНОВА', '1', 'Член', '', '', '', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(4, '4409116652', 'ДИМИТРИНА', 'АСЕНОВА', 'НЕНОВА', '1', 'Член', 'Магистър', 'Юрист', '', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(5, '4409136290', 'ЛИЛИ', 'СТОЯНОВА', 'МИХАЙЛОВА', '11', 'Председател', '', '', '', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(6, '3412216676', 'ВЕРА', 'СТОЯНОВА', 'ЕГНЕТОВА', '11', 'Член', '', '', '88888888', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(7, '4409246810', 'ИВАНКА', 'АЛЕКСАНДРОВА', 'АНГЕЛОВА', '12', 'Председател', '', '', '', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(8, '4409256441', 'ДАФИНА', 'ГРЕШКОВА', 'ЕГНЕТОВА', '12', 'Член', '', '', '', 3, 'Грешно ЕГН', 'a4905182-408b-4afd-850c-ffe46d0157b7'),
	(9, '4410056673', 'АНА', 'ПЕНЧЕВА', 'ЧЕРКЕЗОВА', '12', 'Член', '', '', '', 1, '', 'a4905182-408b-4afd-850c-ffe46d0157b7');
/*!40000 ALTER TABLE `n_lica_import` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_izbori
CREATE TABLE IF NOT EXISTS `n_lica_izbori` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `ID_Lice` int(7) NOT NULL,
  `Izb_Alias` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'MI2019',
  `Tur` int(1) DEFAULT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Id_Sik` int(10) DEFAULT NULL,
  `id_sila` int(11) DEFAULT NULL,
  `Re` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Code_rolia` int(11) NOT NULL,
  `Ime_rolia` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  `hasmaxincome` int(1) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `n_lica_izbori_ibfk_1` (`ID_Lice`),
  KEY `FK_lica_izbori_siks_1` (`Id_Sik`),
  KEY `FK_lica_izbori_wnsila` (`id_sila`),
  KEY `FK_n_lica_izbori_wntoa` (`TOA`),
  CONSTRAINT `FK_lica_izbori_wnsila` FOREIGN KEY (`id_sila`) REFERENCES `wnsila` (`ID_Party`),
  CONSTRAINT `FK_n_lica_izbori_wntoa` FOREIGN KEY (`TOA`) REFERENCES `wntoa` (`NKOD`),
  CONSTRAINT `n_lica_izbori_ibfk_1` FOREIGN KEY (`ID_Lice`) REFERENCES `n_lica` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3895 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_izbori: ~19 rows (приблизително)
DELETE FROM `n_lica_izbori`;
/*!40000 ALTER TABLE `n_lica_izbori` DISABLE KEYS */;
INSERT INTO `n_lica_izbori` (`ID`, `ID_Lice`, `Izb_Alias`, `Tur`, `TOA`, `Id_Sik`, `id_sila`, `Re`, `Code_rolia`, `Ime_rolia`, `USER`, `KOGA`, `hasmaxincome`) VALUES
	(3867, 1821, 'PR2021', 1, '19', 3523, 1, '0', 401, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:46:44.067040', 0),
	(3868, 1822, 'PR2021', 1, '02', 3524, 1, '', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3869, 1823, 'PR2021', 1, '02', 3525, 1, '', 403, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3870, 1824, 'PR2021', 1, '02', 3524, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3871, 1825, 'PR2021', 1, '02', 3524, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3872, 1826, 'PR2021', 1, '02', 3526, 1, '', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3873, 1827, 'PR2021', 1, '02', 3526, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3874, 1828, 'PR2021', 1, '02', 3527, 1, '', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:43:50.000000', 0),
	(3875, 1829, 'PR2021', 1, NULL, 3527, 1, '0', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:55:53.446652', 0),
	(3876, 1821, 'PR2021', 2, NULL, 3553, 1, '0', 401, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2020-02-19 16:07:53.038110', 0),
	(3877, 1822, 'PR2021', 2, '02', 3529, 1, '0', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2020-03-11 19:30:36.947916', 0),
	(3878, 1823, 'PR2021', 2, '02', 3555, 1, '0', 403, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2020-02-26 17:53:23.838981', 0),
	(3879, 1824, 'PR2021', 2, '02', 3554, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3880, 1825, 'PR2021', 2, '02', 3554, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3881, 1826, 'PR2021', 2, '02', 3556, 1, '', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3882, 1827, 'PR2021', 2, '02', 3556, 1, '', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3883, 1828, 'PR2021', 2, '02', 3557, 1, '', 401, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3884, 1829, 'PR2021', 2, NULL, 3557, 1, '0', 404, '', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:45.000000', NULL),
	(3891, 1830, 'PR2021', 2, '02', 3554, 1, '0', 404, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 15:27:56.788981', 0),
	(3893, 1832, 'PR2021', 2, NULL, 3554, 2, '0', 404, NULL, '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-19 16:31:11.750519', 0),
	(3894, 1833, 'PR2021', 2, '01', 3528, 2, '0', 404, NULL, '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-19 16:28:53.145454', 0);
/*!40000 ALTER TABLE `n_lica_izbori` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_izbori_zamestvane
CREATE TABLE IF NOT EXISTS `n_lica_izbori_zamestvane` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Lice_novo` int(11) NOT NULL,
  `Id_Lice_staro` int(11) DEFAULT NULL,
  `id_sila` int(11) DEFAULT '0',
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  `id_rolja` int(11) DEFAULT '0',
  `id_sek` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `n_lica_izbori_zamestvane_ibfk_1` (`ID_Lice_novo`),
  CONSTRAINT `n_lica_izbori_zamestvane_ibfk_1` FOREIGN KEY (`ID_Lice_novo`) REFERENCES `n_lica_izbori` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_izbori_zamestvane: ~0 rows (приблизително)
DELETE FROM `n_lica_izbori_zamestvane`;
/*!40000 ALTER TABLE `n_lica_izbori_zamestvane` DISABLE KEYS */;
/*!40000 ALTER TABLE `n_lica_izbori_zamestvane` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lica_izbori_zamestvane_ottur1
CREATE TABLE IF NOT EXISTS `n_lica_izbori_zamestvane_ottur1` (
  `ID` int(11) NOT NULL,
  `ID_Lice_novo` int(11) NOT NULL,
  `Id_Lice_staro` int(11) DEFAULT NULL,
  `id_sila` int(11) DEFAULT '0',
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  `id_rolja` int(11) DEFAULT '0',
  `id_sek` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lica_izbori_zamestvane_ottur1: ~0 rows (приблизително)
DELETE FROM `n_lica_izbori_zamestvane_ottur1`;
/*!40000 ALTER TABLE `n_lica_izbori_zamestvane_ottur1` DISABLE KEYS */;
/*!40000 ALTER TABLE `n_lica_izbori_zamestvane_ottur1` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lice_pari_zanap
CREATE TABLE IF NOT EXISTS `n_lice_pari_zanap` (
  `Id` int(8) NOT NULL AUTO_INCREMENT,
  `ID_Lice` int(8) NOT NULL,
  `Code_dancoef` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Pari` decimal(10,4) DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_nlicaparizanap_nlica` (`ID_Lice`),
  CONSTRAINT `FK_nlicaparizanap_nlica` FOREIGN KEY (`ID_Lice`) REFERENCES `n_lica_izbori` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=143416 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lice_pari_zanap: ~9 rows (приблизително)
DELETE FROM `n_lice_pari_zanap`;
/*!40000 ALTER TABLE `n_lice_pari_zanap` DISABLE KEYS */;
INSERT INTO `n_lice_pari_zanap` (`Id`, `ID_Lice`, `Code_dancoef`, `Pari`, `Koga`) VALUES
	(143380, 3867, '01', 2.4300, '2020-02-27 10:46:29.000000'),
	(143381, 3867, '04', 0.8000, '2020-02-27 10:46:29.000000'),
	(143382, 3867, '06', 0.0700, '2020-02-27 10:46:29.000000'),
	(143383, 3871, '01', 2.4300, '2020-02-28 10:40:54.000000'),
	(143384, 3871, '04', 0.8000, '2020-02-28 10:40:54.000000'),
	(143385, 3871, '06', 0.0700, '2020-02-28 10:40:54.000000'),
	(143413, 3868, '01', 4.8600, '2020-03-05 18:31:11.000000'),
	(143414, 3868, '04', 1.6000, '2020-03-05 18:31:11.000000'),
	(143415, 3868, '06', 0.1400, '2020-03-05 18:31:11.000000');
/*!40000 ALTER TABLE `n_lice_pari_zanap` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_lice_pari_zaplashtane
CREATE TABLE IF NOT EXISTS `n_lice_pari_zaplashtane` (
  `Id` int(8) NOT NULL AUTO_INCREMENT,
  `ID_Lice` int(8) NOT NULL,
  `Code_Table` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Code_possition` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Pari` decimal(10,4) DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_nlicaparizaplashtane_nlica` (`ID_Lice`),
  CONSTRAINT `FK_nlicaparizaplashtane_nlica` FOREIGN KEY (`ID_Lice`) REFERENCES `n_lica_izbori` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27662 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_lice_pari_zaplashtane: ~3 rows (приблизително)
DELETE FROM `n_lice_pari_zaplashtane`;
/*!40000 ALTER TABLE `n_lice_pari_zaplashtane` DISABLE KEYS */;
INSERT INTO `n_lice_pari_zaplashtane` (`Id`, `ID_Lice`, `Code_Table`, `Code_possition`, `Pari`, `Koga`) VALUES
	(27650, 3867, '3', '330', 10.0000, '2020-02-27 10:46:29.000000'),
	(27651, 3871, '3', '330', 10.0000, '2020-02-28 10:40:54.000000'),
	(27661, 3868, '3', '330', 20.0000, '2020-03-05 18:31:11.000000');
/*!40000 ALTER TABLE `n_lice_pari_zaplashtane` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_list_codepositions
CREATE TABLE IF NOT EXISTS `n_list_codepositions` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `PKODE` int(4) NOT NULL DEFAULT '0',
  `IZB_ALLIAS` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `NKODE` int(3) NOT NULL,
  `NIME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status` int(1) DEFAULT '1',
  `CALC` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CODEPOS_CODETABL` (`PKODE`),
  CONSTRAINT `FK_CODEPOS_CODETABL` FOREIGN KEY (`PKODE`) REFERENCES `n_list_codetables` (`NKODE`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_list_codepositions: ~20 rows (приблизително)
DELETE FROM `n_list_codepositions`;
/*!40000 ALTER TABLE `n_list_codepositions` DISABLE KEYS */;
INSERT INTO `n_list_codepositions` (`ID`, `PKODE`, `IZB_ALLIAS`, `NKODE`, `NIME`, `Status`, `CALC`) VALUES
	(1, 1, 'PR2021', 101, 'Основна секция', 1, 1),
	(2, 1, 'PR2021', 102, 'Подвижна секция ', 1, 1),
	(3, 1, 'PR2021', 103, 'Служебна секция', 1, 1),
	(4, 1, 'PR2021', 104, 'Друга секция', 1, 0),
	(8, 3, 'PR2021', 301, 'Черпене с боза', 1, NULL),
	(9, 3, 'PR2021', 302, 'Получаване на изборни книжа', 1, NULL),
	(10, 3, 'PR2021', 303, 'Участие в обучение', 1, NULL),
	(11, 4, 'PR2021', 401, 'Председател', 1, NULL),
	(12, 4, 'PR2021', 402, 'Зам. председател', 1, NULL),
	(13, 4, 'PR2021', 403, 'Секретар', 1, NULL),
	(14, 4, 'PR2021', 404, 'Член', 1, NULL),
	(15, 4, 'PR2021', 410, 'резерва', 1, NULL),
	(16, 4, 'PR2021', 411, 'заменен', 1, NULL),
	(17, 4, 'PR2021', 412, 'отпаднал', 1, NULL),
	(18, 4, 'PR2021', 413, 'неявил се', 1, NULL),
	(27, 2, 'PR2021', 201, 'Машинна секция', 1, NULL),
	(30, 2, 'PR2021', 202, 'Над 800 души', 1, NULL),
	(32, 2, 'PR2021', 205, 'Za test', 0, NULL),
	(34, 2, 'PR2021', 203, 'Участие в обучение', 1, NULL),
	(36, 1, 'PR2021', 100, 'Нулева секция', 1, 0),
	(37, 3, 'PR2021', 330, 'Корекция–баланс', 1, NULL);
/*!40000 ALTER TABLE `n_list_codepositions` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_list_codetables
CREATE TABLE IF NOT EXISTS `n_list_codetables` (
  `NKODE` int(4) NOT NULL AUTO_INCREMENT,
  `NIME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`NKODE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_list_codetables: ~4 rows (приблизително)
DELETE FROM `n_list_codetables`;
/*!40000 ALTER TABLE `n_list_codetables` DISABLE KEYS */;
INSERT INTO `n_list_codetables` (`NKODE`, `NIME`, `Status`) VALUES
	(1, 'Видове секции', 1),
	(2, 'Видове признаци на секции', 1),
	(3, 'Видове операции', 1),
	(4, 'Роли (Длъжности)', 1);
/*!40000 ALTER TABLE `n_list_codetables` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_log
CREATE TABLE IF NOT EXISTS `n_log` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_log: ~14 rows (приблизително)
DELETE FROM `n_log`;
/*!40000 ALTER TABLE `n_log` DISABLE KEYS */;
INSERT INTO `n_log` (`Id_LOG`, `User`, `Koga`, `ACTION`, `Kod_Obrabotka`, `Ime_Obrabotka`, `AAA`) VALUES
	(1, 'krasi66', '2020-02-24 18:46:22.000000', 'ЛЮЛИН', 'Финансови изчисления', '', NULL),
	(2, 'Грешен потребител: prmUser', '2020-02-26 14:59:58.000000', 'ОВЧА КУПЕЛ', 'Нов Административен район', 'ОВЧА КУПЕЛ', NULL),
	(3, 'krasi66', '2020-02-26 15:06:52.000000', 'ОВЧА КУПЕЛ', 'Редактиране на Административен район', 'ОВЧА КУПЕЛ', NULL),
	(4, 'krasi66', '2020-02-26 15:07:37.000000', 'ОВЧА КУПЕЛ', 'Редактиране на Административен район', 'ОВЧА КУПЕЛ', NULL),
	(5, 'Грешен потребител: prmUser', '2020-02-26 15:14:25.000000', 'ОВЧА КУПЕЛ', 'Нов Административен район', 'ОВЧА КУПЕЛ', NULL),
	(6, 'krasi66', '2020-02-26 15:15:04.000000', 'ОВЧА КУПЕЛ', 'Редактиране на Административен район', 'ОВЧА КУПЕЛ', NULL),
	(7, 'krasi66', '2020-02-26 15:40:35.000000', 'ОВЧА КУПЕЛ', 'Редактиране на Административен район', 'ОВЧА КУПЕЛ', NULL),
	(8, 'krasi66', '2020-02-27 09:14:34.000000', 'СРЕДЕЦ', 'Редактиране на Административен район', 'СРЕДЕЦ', NULL),
	(9, 'krasi66', '2020-03-04 19:21:12.000000', 'КРАСНО СЕЛО', 'Отмяна на финансовите изчисления', '', NULL),
	(10, 'krasi66', '2020-03-05 18:30:33.000000', 'КРАСНО СЕЛО', 'Финансови изчисления', '', NULL),
	(11, 'krasi66', '2020-03-05 18:45:55.000000', 'КРАСНО СЕЛО', 'Отмяна на финансовите изчисления', '', NULL),
	(12, 'krasi66', '2020-03-05 19:08:04.000000', 'КРАСНО СЕЛО', 'Финансови изчисления', '', NULL),
	(13, 'krasi66', '2020-03-05 19:08:13.000000', 'КРАСНО СЕЛО', 'Отмяна на финансовите изчисления', '', NULL),
	(14, 'krasi66', '2020-03-05 19:31:43.000000', 'КРАСНО СЕЛО', 'Финансови изчисления', '', NULL),
	(15, 'krasi66', '2020-03-05 19:31:51.000000', 'КРАСНО СЕЛО', 'Отмяна на финансовите изчисления', '', NULL);
/*!40000 ALTER TABLE `n_log` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_log_deinosti
CREATE TABLE IF NOT EXISTS `n_log_deinosti` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46546 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_log_deinosti: ~2 rows (приблизително)
DELETE FROM `n_log_deinosti`;
/*!40000 ALTER TABLE `n_log_deinosti` DISABLE KEYS */;
INSERT INTO `n_log_deinosti` (`Id_LOG`, `User`, `Koga`, `ACTION`, `Kod_Obrabotka`, `Ime_Obrabotka`, `AAA`) VALUES
	(46544, 'krasi66', '2020-02-21 19:28:27.000000', 'ЛЮЛИН', 'Черпене с боза', 'Н К АНТОНОВА', NULL),
	(46545, 'krasi66', '2020-02-21 19:29:35.000000', 'ЛЮЛИН', 'Черпене с боза', 'Н К АНТОНОВА', 'Не');
/*!40000 ALTER TABLE `n_log_deinosti` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_log_dokumenti
CREATE TABLE IF NOT EXISTS `n_log_dokumenti` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46812 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_log_dokumenti: ~245 rows (приблизително)
DELETE FROM `n_log_dokumenti`;
/*!40000 ALTER TABLE `n_log_dokumenti` DISABLE KEYS */;
INSERT INTO `n_log_dokumenti` (`Id_LOG`, `User`, `Koga`, `ACTION`, `Kod_Obrabotka`, `Ime_Obrabotka`, `AAA`) VALUES
	(46544, 'krasi66', '2020-02-20 23:35:09.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46545, 'krasi66', '2020-02-20 23:35:09.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46546, 'krasi66', '2020-02-20 23:35:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46547, 'krasi66', '2020-02-20 23:35:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46548, 'krasi66', '2020-02-21 19:20:32.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46549, 'krasi66', '2020-02-21 19:20:32.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46550, 'krasi66', '2020-02-24 18:45:55.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46551, 'krasi66', '2020-02-24 18:45:55.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46552, 'krasi66', '2020-02-24 18:46:59.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46553, 'krasi66', '2020-02-24 18:46:59.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46554, 'krasi66', '2020-02-24 19:27:09.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46555, 'krasi66', '2020-02-24 19:27:10.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46556, 'krasi66', '2020-02-24 19:51:00.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46557, 'krasi66', '2020-02-24 19:51:00.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46558, 'krasi66', '2020-02-24 19:56:02.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46559, 'krasi66', '2020-02-24 19:56:02.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46560, 'krasi66', '2020-02-24 20:26:59.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46561, 'krasi66', '2020-02-24 20:26:59.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46562, 'krasi66', '2020-02-24 20:28:46.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46563, 'krasi66', '2020-02-24 20:28:46.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46564, 'krasi66', '2020-02-24 23:24:25.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46565, 'krasi66', '2020-02-24 23:24:25.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46566, 'krasi66', '2020-02-24 23:42:36.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46567, 'krasi66', '2020-02-24 23:42:36.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46568, 'krasi66', '2020-02-25 18:41:01.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46569, 'krasi66', '2020-02-25 18:41:01.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46570, 'krasi66', '2020-02-26 10:01:29.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46571, 'krasi66', '2020-02-26 10:01:29.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46572, 'krasi66', '2020-02-26 10:09:32.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46573, 'krasi66', '2020-02-26 10:09:32.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46574, 'krasi66', '2020-02-26 10:12:24.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46575, 'krasi66', '2020-02-26 10:12:24.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46576, 'krasi66', '2020-02-26 10:26:35.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46577, 'krasi66', '2020-02-26 10:26:35.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46578, 'krasi66', '2020-02-26 11:19:43.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46579, 'krasi66', '2020-02-26 11:19:43.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46580, 'krasi66', '2020-02-26 11:49:20.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46581, 'krasi66', '2020-02-26 11:49:20.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46582, 'krasi66', '2020-02-26 11:49:56.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46583, 'krasi66', '2020-02-26 11:49:57.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46584, 'krasi66', '2020-02-26 11:51:07.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46585, 'krasi66', '2020-02-26 11:51:07.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46586, 'krasi66', '2020-02-26 14:32:00.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46587, 'krasi66', '2020-02-26 14:32:00.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46588, 'krasi66', '2020-02-26 14:32:11.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46589, 'krasi66', '2020-02-26 14:32:11.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46590, 'krasi66', '2020-02-26 14:32:11.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46591, 'krasi66', '2020-02-26 14:32:11.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46592, 'krasi66', '2020-02-26 14:53:50.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46593, 'krasi66', '2020-02-26 14:53:50.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46594, 'krasi66', '2020-02-26 14:58:12.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46595, 'krasi66', '2020-02-26 14:58:12.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46596, 'krasi66', '2020-02-26 14:59:52.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46597, 'krasi66', '2020-02-26 14:59:53.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46598, 'krasi66', '2020-02-26 15:04:17.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46599, 'krasi66', '2020-02-26 15:04:17.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46600, 'krasi66', '2020-02-26 15:05:59.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46601, 'krasi66', '2020-02-26 15:05:59.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46602, 'krasi66', '2020-02-26 15:10:50.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46603, 'krasi66', '2020-02-26 15:10:50.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46604, 'krasi66', '2020-02-26 15:19:58.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46605, 'krasi66', '2020-02-26 15:19:58.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46606, 'krasi66', '2020-02-26 15:23:41.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46607, 'krasi66', '2020-02-26 15:23:41.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46608, 'krasi66', '2020-02-26 15:30:32.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_3', NULL),
	(46609, 'krasi66', '2020-02-26 15:30:32.000000', 'ОВЧА КУПЕЛ', 'Справка', 'spravka_9_1', NULL),
	(46610, 'krasi66', '2020-02-26 16:14:42.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46611, 'krasi66', '2020-02-26 16:14:42.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46612, 'krasi66', '2020-02-26 16:15:57.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46613, 'krasi66', '2020-02-26 16:15:57.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46614, 'krasi66', '2020-02-26 16:32:13.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46615, 'krasi66', '2020-02-26 16:32:13.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46616, 'krasi66', '2020-02-26 16:37:33.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_3', NULL),
	(46617, 'krasi66', '2020-02-26 16:37:33.000000', 'ЛЮЛИН', 'Справка', 'spravka_9_1', NULL),
	(46618, 'krasi66', '2020-02-26 17:42:33.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46619, 'krasi66', '2020-02-26 17:42:33.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46620, 'krasi66', '2020-02-26 17:52:58.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46621, 'krasi66', '2020-02-26 17:52:58.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46622, 'krasi66', '2020-02-27 09:12:50.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46623, 'krasi66', '2020-02-27 09:12:50.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46624, 'krasi66', '2020-02-27 10:34:43.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46625, 'krasi66', '2020-02-27 10:34:43.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46626, 'krasi66', '2020-02-27 18:13:51.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46627, 'krasi66', '2020-02-27 18:13:51.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46628, 'krasi66', '2020-02-27 18:25:15.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46629, 'krasi66', '2020-02-27 18:25:15.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46630, 'krasi66', '2020-02-27 18:25:20.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46631, 'krasi66', '2020-02-27 18:25:20.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46632, 'krasi66', '2020-02-27 18:46:48.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46633, 'krasi66', '2020-02-27 18:46:48.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46634, 'krasi66', '2020-02-27 18:55:36.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46635, 'krasi66', '2020-02-27 18:55:36.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46636, 'krasi66', '2020-02-27 19:02:34.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46637, 'krasi66', '2020-02-27 19:02:34.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46638, 'krasi66', '2020-02-27 19:10:36.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46639, 'krasi66', '2020-02-27 19:10:36.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46640, 'krasi66', '2020-02-27 19:11:27.000000', 'СРЕДЕЦ', 'Справка', 'spravka_1_2', NULL),
	(46641, 'krasi66', '2020-02-27 19:14:13.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46642, 'krasi66', '2020-02-27 19:14:13.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46643, 'krasi66', '2020-02-27 19:14:21.000000', 'СРЕДЕЦ', 'Справка', 'spravka_1_2', NULL),
	(46644, 'krasi66', '2020-02-27 19:17:56.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46645, 'krasi66', '2020-02-27 19:17:56.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46646, 'krasi66', '2020-02-27 19:36:42.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46647, 'krasi66', '2020-02-27 19:36:42.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46648, 'krasi66', '2020-02-28 01:15:14.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46649, 'krasi66', '2020-02-28 01:15:14.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46650, 'krasi66', '2020-02-28 10:28:47.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46651, 'krasi66', '2020-02-28 10:28:47.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46652, 'krasi66', '2020-02-28 10:33:09.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46653, 'krasi66', '2020-02-28 10:33:09.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46654, 'krasi66', '2020-02-28 10:38:55.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46655, 'krasi66', '2020-02-28 10:38:55.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46656, 'krasi66', '2020-02-28 11:20:02.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46657, 'krasi66', '2020-02-28 11:20:02.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46658, 'krasi66', '2020-02-28 11:38:36.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46659, 'krasi66', '2020-02-28 11:38:36.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46660, 'krasi66', '2020-02-28 11:41:02.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46661, 'krasi66', '2020-02-28 11:41:02.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46662, 'krasi66', '2020-02-28 12:01:28.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46663, 'krasi66', '2020-02-28 12:01:28.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46664, 'krasi66', '2020-02-28 12:04:13.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46665, 'krasi66', '2020-02-28 12:04:13.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46666, 'krasi66', '2020-02-28 12:09:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46667, 'krasi66', '2020-02-28 12:09:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46668, 'krasi66', '2020-02-28 12:18:56.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46669, 'krasi66', '2020-02-28 12:18:56.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46670, 'krasi66', '2020-02-28 12:22:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46671, 'krasi66', '2020-02-28 12:22:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46672, 'krasi66', '2020-02-28 12:26:47.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46673, 'krasi66', '2020-02-28 12:26:47.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46674, 'krasi66', '2020-03-02 10:21:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46675, 'krasi66', '2020-03-02 10:21:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46676, 'krasi66', '2020-03-02 10:21:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46677, 'krasi66', '2020-03-02 10:21:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46678, 'krasi66', '2020-03-02 11:11:03.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46679, 'krasi66', '2020-03-02 11:11:03.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46680, 'krasi66', '2020-03-02 11:17:52.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46681, 'krasi66', '2020-03-02 11:17:52.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46682, 'krasi66', '2020-03-02 12:01:04.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46683, 'krasi66', '2020-03-02 12:01:04.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46684, 'krasi66', '2020-03-02 13:15:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46685, 'krasi66', '2020-03-02 13:15:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46686, 'krasi66', '2020-03-02 13:34:32.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46687, 'krasi66', '2020-03-02 13:34:32.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46688, 'krasi66', '2020-03-02 13:36:06.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46689, 'krasi66', '2020-03-02 13:36:06.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46690, 'krasi66', '2020-03-02 13:37:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46691, 'krasi66', '2020-03-02 13:37:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46692, 'krasi66', '2020-03-02 17:35:49.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46693, 'krasi66', '2020-03-02 17:39:43.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46694, 'krasi66', '2020-03-02 17:39:43.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46695, 'krasi66', '2020-03-02 18:38:20.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46696, 'krasi66', '2020-03-02 18:38:20.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46697, 'krasi66', '2020-03-02 19:27:56.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46698, 'krasi66', '2020-03-02 19:27:56.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46699, 'krasi66', '2020-03-02 19:32:29.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46700, 'krasi66', '2020-03-02 19:32:29.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46701, 'krasi66', '2020-03-04 19:16:41.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46702, 'krasi66', '2020-03-04 19:16:41.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46703, 'krasi66', '2020-03-04 19:17:25.000000', 'СРЕДЕЦ', 'Справка', 'spravka_1_2', NULL),
	(46704, 'krasi66', '2020-03-04 19:31:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46705, 'krasi66', '2020-03-04 19:31:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46706, 'krasi66', '2020-03-04 19:48:27.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46707, 'krasi66', '2020-03-04 19:48:27.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46708, 'krasi66', '2020-03-04 19:50:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46709, 'krasi66', '2020-03-04 19:50:35.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46710, 'krasi99', '2020-03-04 19:51:16.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46711, 'krasi99', '2020-03-04 19:51:16.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46712, 'krasi66', '2020-03-04 19:54:03.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46713, 'krasi66', '2020-03-04 19:54:03.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46714, 'krasi99', '2020-03-04 19:57:50.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46715, 'krasi99', '2020-03-04 19:57:50.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46716, 'krasi66', '2020-03-04 19:59:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46717, 'krasi66', '2020-03-04 19:59:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46718, 'krasi99', '2020-03-04 19:59:38.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46719, 'krasi99', '2020-03-04 19:59:38.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46720, 'krasi99', '2020-03-04 20:03:52.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46721, 'krasi99', '2020-03-04 20:03:52.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46722, 'krasi66', '2020-03-04 20:05:31.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46723, 'krasi66', '2020-03-04 20:05:31.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46724, 'krasi66', '2020-03-05 12:19:15.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46725, 'krasi66', '2020-03-05 12:19:15.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46726, 'krasi66', '2020-03-05 12:26:33.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46727, 'krasi66', '2020-03-05 12:26:33.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46728, 'krasi66', '2020-03-05 12:45:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46729, 'krasi66', '2020-03-05 12:45:18.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46730, 'krasi66', '2020-03-05 12:50:41.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46731, 'krasi66', '2020-03-05 12:50:41.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46732, 'krasi66', '2020-03-05 12:55:01.000000', 'СРЕДЕЦ', 'Справка', 'spravka_1_2', NULL),
	(46733, 'krasi66', '2020-03-05 18:19:14.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46734, 'krasi66', '2020-03-05 18:19:14.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46735, 'krasi66', '2020-03-05 18:41:59.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_1_2', NULL),
	(46736, 'krasi66', '2020-03-05 18:42:06.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_2_1_1', NULL),
	(46737, 'krasi66', '2020-03-05 18:43:21.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_2_1_1', NULL),
	(46738, 'krasi66', '2020-03-05 18:43:26.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_2_1_1', NULL),
	(46739, 'krasi66', '2020-03-05 18:43:31.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_3_3', NULL),
	(46740, 'krasi66', '2020-03-05 18:44:21.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_3_3', NULL),
	(46741, 'krasi66', '2020-03-05 18:44:26.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_2_1_2', NULL),
	(46742, 'krasi66', '2020-03-05 18:45:14.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_2_1_2', NULL),
	(46743, 'krasi66', '2020-03-05 18:45:22.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_1_1', NULL),
	(46744, 'krasi66', '2020-03-05 18:45:30.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_1_2', NULL),
	(46745, 'krasi66', '2020-03-05 18:52:59.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46746, 'krasi66', '2020-03-05 18:52:59.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46747, 'krasi66', '2020-03-05 18:53:30.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_1_2', NULL),
	(46748, 'krasi66', '2020-03-05 18:54:19.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_4_1', NULL),
	(46749, 'krasi66', '2020-03-05 18:54:26.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_4_1', NULL),
	(46750, 'krasi66', '2020-03-05 18:54:31.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_4_3', NULL),
	(46751, 'krasi66', '2020-03-05 18:55:07.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_4_3', NULL),
	(46752, 'krasi66', '2020-03-05 18:55:11.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46753, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'ПЕНКА ИВАНОВА КАРАГЕОРГИЕВА', NULL),
	(46754, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'МАРИЯНА КИРИЛОВА ИВАНОВА', NULL),
	(46755, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'ДИМИТРИНА АСЕНОВА НЕНОВА', NULL),
	(46756, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'ТЕСТ ТЕСТОВ ТЕСТОВ', NULL),
	(46757, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'Н ТОДОРОВА МИНЕВА', NULL),
	(46758, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'ЛИЛИ СТОЯНОВА МИХАЙЛОВА', NULL),
	(46759, 'krasi66', '2020-03-05 18:56:38.000000', 'КРАСНО СЕЛО', 'Декларация за осигурителен доход', 'ВЕРА СТОЯНОВА ЕГНЕТОВА', NULL),
	(46760, 'krasi66', '2020-03-05 19:01:00.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46761, 'krasi66', '2020-03-05 19:01:00.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46762, 'krasi66', '2020-03-05 19:06:33.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46763, 'krasi66', '2020-03-05 19:06:34.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46764, 'krasi66', '2020-03-05 19:31:35.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46765, 'krasi66', '2020-03-05 19:31:35.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46766, 'krasi66', '2020-03-06 19:08:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46767, 'krasi66', '2020-03-06 19:08:23.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46768, 'krasi66', '2020-03-06 19:39:35.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46769, 'krasi66', '2020-03-06 19:39:36.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46770, 'krasi66', '2020-03-06 19:42:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_3', NULL),
	(46771, 'krasi66', '2020-03-06 19:42:16.000000', 'СРЕДЕЦ', 'Справка', 'spravka_9_1', NULL),
	(46772, 'krasi66', '2020-03-06 19:51:05.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46773, 'krasi66', '2020-03-06 19:51:05.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46774, 'krasi66', '2020-03-09 18:52:49.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46775, 'krasi66', '2020-03-09 18:52:49.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46776, 'krasi66', '2020-03-09 19:13:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46777, 'krasi66', '2020-03-09 19:13:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46778, 'krasi66', '2020-03-09 19:15:39.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46779, 'krasi66', '2020-03-09 19:15:39.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46780, 'krasi66', '2020-03-09 19:34:27.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46781, 'krasi66', '2020-03-09 19:34:27.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46782, 'krasi66', '2020-03-09 19:42:44.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46783, 'krasi66', '2020-03-09 19:42:44.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46784, 'krasi66', '2020-03-09 19:48:06.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46785, 'krasi66', '2020-03-09 19:48:06.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46786, 'krasi66', '2020-03-09 19:51:12.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46787, 'krasi66', '2020-03-09 19:51:12.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46788, 'krasi66', '2020-03-09 19:52:47.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46789, 'krasi66', '2020-03-09 19:52:47.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46790, 'krasi66', '2020-03-10 16:30:19.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46791, 'krasi66', '2020-03-10 16:30:19.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46792, 'krasi66', '2020-03-10 19:20:38.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46793, 'krasi66', '2020-03-10 19:20:38.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46794, 'krasi66', '2020-03-11 16:02:33.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46795, 'krasi66', '2020-03-11 16:02:33.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46796, 'krasi66', '2020-03-11 16:51:36.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46797, 'krasi66', '2020-03-11 16:51:36.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46798, 'krasi66', '2020-03-11 18:04:30.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46799, 'krasi66', '2020-03-11 18:04:30.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46800, 'krasi66', '2020-03-11 19:07:48.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46801, 'krasi66', '2020-03-11 19:07:48.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46802, 'krasi66', '2020-03-11 19:14:04.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46803, 'krasi66', '2020-03-11 19:14:04.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46804, 'krasi66', '2020-03-11 19:27:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46805, 'krasi66', '2020-03-11 19:27:42.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46806, 'krasi66', '2020-03-11 19:52:19.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46807, 'krasi66', '2020-03-11 19:52:19.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46808, 'krasi66', '2020-03-11 19:55:54.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46809, 'krasi66', '2020-03-11 19:55:54.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL),
	(46810, 'krasi66', '2020-03-16 19:23:06.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_3', NULL),
	(46811, 'krasi66', '2020-03-16 19:23:06.000000', 'КРАСНО СЕЛО', 'Справка', 'spravka_9_1', NULL);
/*!40000 ALTER TABLE `n_log_dokumenti` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_log_lica
CREATE TABLE IF NOT EXISTS `n_log_lica` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_log_lica: ~6 rows (приблизително)
DELETE FROM `n_log_lica`;
/*!40000 ALTER TABLE `n_log_lica` DISABLE KEYS */;
INSERT INTO `n_log_lica` (`Id_LOG`, `User`, `Koga`, `ACTION`, `Kod_Obrabotka`, `Ime_Obrabotka`, `AAA`) VALUES
	(1, 'Грешен потребител: prmUser', '2020-02-27 10:21:43.000000', 'ЛЮЛИН', 'Корекция на плащане в Тур 1', 'Н К АНТОНОВА [3867]', NULL),
	(2, 'Грешен потребител: prmUser', '2020-02-27 10:22:17.000000', 'ЛЮЛИН', 'Корекция на плащане в Тур 1', 'Н К АНТОНОВА [3867]', NULL),
	(3, 'Грешен потребител: prmUser', '2020-02-27 10:46:29.000000', 'ЛЮЛИН', 'Корекция на плащане в Тур 1', 'Н К АНТОНОВА [1821]', NULL),
	(4, 'krasi66', '2020-02-28 10:40:54.000000', 'КРАСНО СЕЛО', 'Корекция на плащане в Тур 1', 'ДИМИТРИНА АСЕНОВА НЕНОВА [1825]', NULL),
	(5, 'krasi66', '2020-03-05 18:31:01.000000', 'КРАСНО СЕЛО', 'Корекция на плащане в Тур 1', 'ПЕНКА ИВАНОВА КАРАГЕОРГИЕВА [1822]', NULL),
	(6, 'krasi66', '2020-03-05 18:31:11.000000', 'КРАСНО СЕЛО', 'Корекция на плащане в Тур 1', 'ПЕНКА ИВАНОВА КАРАГЕОРГИЕВА [1822]', NULL);
/*!40000 ALTER TABLE `n_log_lica` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_log_sik_istoria
CREATE TABLE IF NOT EXISTS `n_log_sik_istoria` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `TOA_TEKST` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `SIK` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Kod_Tekst` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Pole_Bilo` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Pole_Stava` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46563 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_log_sik_istoria: ~18 rows (приблизително)
DELETE FROM `n_log_sik_istoria`;
/*!40000 ALTER TABLE `n_log_sik_istoria` DISABLE KEYS */;
INSERT INTO `n_log_sik_istoria` (`Id_LOG`, `User`, `Koga`, `TOA`, `TOA_TEKST`, `SIK`, `Kod_Obrabotka`, `Kod_Tekst`, `Pole_Bilo`, `Pole_Stava`) VALUES
	(46544, 'krasi66', '2020-02-20 23:36:44.000000', '01', 'СРЕДЕЦ', '224601000', '21', 'Смяна в адрес', 'гр.София,', 'гр.София, БУЛ.АКАД.ИВАН ЕВСТРАТИЕВ ГЕШОВ,'),
	(46545, 'krasi66', '2020-02-20 23:39:38.000000', '01', 'СРЕДЕЦ', '224601001', '12', 'Нова', '', ''),
	(46546, 'krasi66', '2020-02-20 23:43:09.000000', '01', 'СРЕДЕЦ', '224601001', '13', 'Активирана', '', ''),
	(46547, 'krasi66', '2020-02-20 23:43:26.000000', '01', 'СРЕДЕЦ', '224601001', '14', 'Деактивирана', '', ''),
	(46548, 'krasi66', '2020-02-20 23:43:50.000000', '01', 'СРЕДЕЦ', '224601001', '21', 'Смяна в адрес', 'гр.Нови Искър,', 'гр.Нови Искър, тест'),
	(46549, 'krasi66', '2020-02-20 23:44:42.000000', '01', 'СРЕДЕЦ', '224601001', '23', 'Смяна брой членове в СИК', '5', '7'),
	(46550, 'krasi66', '2020-02-26 15:07:15.000000', '18', 'ОВЧА КУПЕЛ', '224618000', '23', 'Смяна брой членове в СИК', '0', '7'),
	(46551, 'krasi66', '2020-03-02 12:16:08.000000', '01', 'СРЕДЕЦ', '224601001', '13', 'Активирана', '', ''),
	(46552, 'krasi66', '2020-03-04 19:21:33.000000', '02', 'КРАСНО СЕЛО', '224602011', '23', 'Смяна брой членове в СИК', '0', '7'),
	(46553, 'krasi66', '2020-03-05 18:46:38.000000', '02', 'КРАСНО СЕЛО', '224602001', '23', 'Смяна брой членове в СИК', '0', '7'),
	(46554, 'krasi66', '2020-03-05 18:46:46.000000', '02', 'КРАСНО СЕЛО', '224602010', '23', 'Смяна брой членове в СИК', '0', '5'),
	(46555, 'krasi66', '2020-03-05 18:47:28.000000', '02', 'КРАСНО СЕЛО', '224602001', '23', 'Смяна брой членове в СИК', '7', '5'),
	(46556, 'krasi66', '2020-03-09 18:53:09.000000', '02', 'КРАСНО СЕЛО', '224602011', '14', 'Деактивирана', '', ''),
	(46557, 'krasi66', '2020-03-10 20:07:57.000000', '02', 'КРАСНО СЕЛО', '224602012', '14', 'Деактивирана', '', ''),
	(46558, 'krasi66', '2020-03-11 19:33:28.000000', '02', 'КРАСНО СЕЛО', '224602000', '14', 'Деактивирана', '', ''),
	(46559, 'krasi66', '2020-03-16 19:23:19.000000', '02', 'КРАСНО СЕЛО', '224602012', '14', 'Деактивирана', '', ''),
	(46560, 'krasi66', '2020-03-16 19:23:30.000000', '02', 'КРАСНО СЕЛО', '224602012', '13', 'Активирана', '', ''),
	(46561, 'krasi66', '2020-03-16 19:23:34.000000', '02', 'КРАСНО СЕЛО', '224602012', '14', 'Деактивирана', '', ''),
	(46562, 'krasi66', '2020-03-16 19:23:38.000000', '02', 'КРАСНО СЕЛО', '224602012', '13', 'Активирана', '', '');
/*!40000 ALTER TABLE `n_log_sik_istoria` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_nomenclatures
CREATE TABLE IF NOT EXISTS `n_nomenclatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `table` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(1) DEFAULT NULL,
  `Tip` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_nomenclatures: ~19 rows (приблизително)
DELETE FROM `n_nomenclatures`;
/*!40000 ALTER TABLE `n_nomenclatures` DISABLE KEYS */;
INSERT INTO `n_nomenclatures` (`id`, `description`, `table`, `status`, `Tip`) VALUES
	(1, 'Населени места', 'wnasm', 1, 0),
	(2, 'Улици', 'wnuli', 1, 0),
	(3, 'Области', 'wnobl', 0, 0),
	(4, 'Общини', 'wnobs', 0, 0),
	(5, 'Райони', 'wntoa', 1, 0),
	(6, 'Административен район', 'n_toa_main', 1, 1),
	(7, 'Кметства', 'wnkmetstva', 1, 0),
	(8, 'Жилищни комплекси', 'wnjk_kv', 1, 0),
	(9, 'Районни управления', 'wnnru', 1, 1),
	(10, 'Националности', 'wnnaz', 1, 0),
	(11, 'Образование', 'wnszem', 1, 0),
	(12, 'Специалност', 'wnspec', 1, 0),
	(13, 'Решения', 'wndocs', 1, 1),
	(14, 'Политически сили', 'wnsila', 1, 0),
	(15, 'Видове секции', 'n_list_codepositions', 1, 0),
	(16, 'Видове признаци на секции', 'n_list_codepositions', 1, 0),
	(17, 'Видове операции', 'n_list_codepositions', 1, 0),
	(18, 'Длъжности', 'n_list_codepositions', 1, 0);
/*!40000 ALTER TABLE `n_nomenclatures` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_statistics
CREATE TABLE IF NOT EXISTS `n_statistics` (
  `id` int(11) NOT NULL,
  `shortdescription` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longdescription` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tip` int(11) NOT NULL DEFAULT '0',
  `proc` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_statistics: ~19 rows (приблизително)
DELETE FROM `n_statistics`;
/*!40000 ALTER TABLE `n_statistics` DISABLE KEYS */;
INSERT INTO `n_statistics` (`id`, `shortdescription`, `longdescription`, `Tip`, `proc`) VALUES
	(11, 'Брой секции ', 'Таблица за брой и видове секции по Изборен  И Административен район.', 1, 'spravka_1_1'),
	(12, 'Контролен списък на секции', 'Списък на секции с допълнително поле за контрол на броя членове в СИК.', 1, 'spravka_1_2'),
	(13, 'Контролен Списък на секции', 'С пълен номер, име, адрес и др. данни.', 0, 'spravka_1_2'),
	(14, 'Списък на СИК (за ОИК - на хартия)', 'Пълен списък на секционните избирателни комисии. Всяка СИК - на отделна страница.', 0, 'spravka_2_1_1'),
	(15, 'Обхват на подвижни секции', 'Обхват на подвижни секции, брой избиратели', 1, 'spravka_1_4'),
	(21, 'Списък лица по СИК (за ОИК - в Excel)', 'Общ списък на лицата по секции.', 0, 'spravka_2_1_1'),
	(23, 'Регистър лица за район', 'Списък на лицата само в обхвата на определен Административен район.', 9, 'spravka_2_1_3'),
	(24, 'Помощен списък лица', 'Списък лица по избран критерий (длъжност, политическа сила, решение, дейност, секция).', 1, 'spravka_2_2_1'),
	(25, 'Замествания', 'Справка за извършените замествания, съдържаща заместен, заместващ, длъжност, политическа сила и дата.', 0, 'spravka_2_3'),
	(26, 'Списък на резервите', 'Списък на резервите по секции.', 0, 'spravka_2_1_2'),
	(31, 'Ведомост', 'Справка за суми за получаване.', 2, 'spravka_3_1'),
	(32, 'Рекапитулация', 'Финансова рекапитулация за начислени суми и начислени осигуровки.', 2, 'spravka_3_2'),
	(33, 'Касов ордер', 'Касов ордер за едно лице.', 2, 'spravka_MORS'),
	(34, 'Декларация', 'Декларация за осигурителен доход (макет MSB_DECLAR).', 3, 'spravka_MSBD'),
	(35, 'Удостоверения', 'Приложение № 20-МИ (макет MUDO).', 3, 'spravka_MUDO'),
	(36, 'Служебна бележка', 'Служебна бележка (макет MSB1).', 3, 'spravka_MSB1'),
	(60, 'Заети позиции ', 'Заети позиции по партии и квоти.', 1, 'spravka_4_1'),
	(61, 'Заети позиции – общо за Изборен район', 'Заети позиции по партии и квоти – общо за Изборен район.', 1, 'spravka_4_1'),
	(63, 'Решетка', 'Разпределение на лицата по длъжности, секции и политически сили.', 1, 'spravka_4_3'),
	(90, 'Състояние на регистрациите', 'Разпределение на регистрираните лица по политически сили - общо и по длъжности (брой и %).', 1, 'spravka_9_3'),
	(91, 'История на промените на СИК', 'История на промените - създаване, закриване, промяна на параметри', 1, 'spravka_9_2');
/*!40000 ALTER TABLE `n_statistics` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_toa_main
CREATE TABLE IF NOT EXISTS `n_toa_main` (
  `Nrec` int(11) NOT NULL AUTO_INCREMENT,
  `IZB_ALIAS` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'MI2019',
  `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tur` tinyint(1) NOT NULL DEFAULT '1',
  `Status_Master` int(1) DEFAULT '1',
  `IME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEL` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tel1` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Izr` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OBL` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OBS` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RAJ` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAS` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UL` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOM` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JK_KV` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BLOK` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VH` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ET` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AP` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PK` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EPOD` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IPOD` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Pred` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Sekr` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Nsik` int(11) DEFAULT NULL,
  `Pris` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `R1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `R2` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ANO` int(11) DEFAULT NULL,
  `Bul` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Nrec`),
  KEY `JK_KV` (`JK_KV`),
  KEY `NAS` (`NAS`),
  KEY `OBL` (`OBL`),
  KEY `OBS` (`OBS`),
  KEY `RAJ` (`RAJ`),
  KEY `FK_MASTER_WNTOA` (`TOA`),
  KEY `UL` (`UL`),
  CONSTRAINT `FK_MASTER_WNTOA` FOREIGN KEY (`TOA`) REFERENCES `wntoa` (`NKOD`),
  CONSTRAINT `n_toa_main_ibfk_5` FOREIGN KEY (`OBL`) REFERENCES `wnobl` (`NKOD`),
  CONSTRAINT `n_toa_main_ibfk_6` FOREIGN KEY (`OBS`) REFERENCES `wnobs` (`NKOD`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_toa_main: ~20 rows (приблизително)
DELETE FROM `n_toa_main`;
/*!40000 ALTER TABLE `n_toa_main` DISABLE KEYS */;
INSERT INTO `n_toa_main` (`Nrec`, `IZB_ALIAS`, `TOA`, `Tur`, `Status_Master`, `IME`, `TEL`, `Tel1`, `Izr`, `OBL`, `OBS`, `RAJ`, `NAS`, `UL`, `NOM`, `JK_KV`, `BLOK`, `VH`, `ET`, `AP`, `PK`, `EPOD`, `IPOD`, `Pred`, `Sekr`, `Nsik`, `Pris`, `R1`, `R2`, `ANO`, `Bul`) VALUES
	(1, 'PR2021', '01', 2, 1, 'СРЕДЕЦ', NULL, '', '', 'SOF', 'SOF46', '01', '68134', '02962', '6', '0', NULL, NULL, NULL, NULL, '1000', 'Мария Ачкова', NULL, 'Валери Цалов', 'Боголюба Андонова', 50, '2246', '22-ри Район - София', NULL, 7, '131174427'),
	(5, 'PR2021', '23', 1, 1, 'ПАНЧАРЕВО', '02 345678', '', '', 'SOF', 'SOF46', '23', '55419', '01924', '10', '0', NULL, NULL, NULL, NULL, NULL, 'Иван Петров', NULL, NULL, NULL, 50, '2246', '22-ри Район - София', NULL, 7, '123456789'),
	(6, 'PR2021', '07', 1, 1, 'СЛАТИНА', NULL, '', '', 'SOF', 'SOF46', '07', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, 'Наталия Стоянова', NULL, 'Полина Витанова', 'Жана Петрова', 66, '2246', '22-ри Район - София', NULL, 7, '0006963270001'),
	(7, 'PR2021', '08', 1, 1, 'ИЗГРЕВ', NULL, '', '', 'SOF', 'SOF46', '08', '68134', '04345', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 77, '2246', '22-ри Район - София', NULL, 7, '66666666666'),
	(8, 'PR2021', '03', 1, 1, 'ВЪЗРАЖДАНЕ', NULL, '', '', 'SOF', 'SOF46', '03', '68134', '02612', '4', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100, '2246', '22-ри Район - София', NULL, 0, '589966331'),
	(9, 'PR2021', '19', 1, 1, 'ЛЮЛИН', NULL, '', '', 'SOF', 'SOF46', '19', '0', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270652'),
	(10, 'PR2021', '05', 1, 1, 'СЕРДИКА', NULL, '', '', 'SOF', 'SOF46', '05', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270476'),
	(11, 'PR2021', '15', 1, 1, 'МЛАДОСТ', NULL, '', '', 'SOF', 'SOF46', '15', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270614'),
	(43, 'PR2021', '24', 1, 1, 'БАНКЯ', NULL, '', '', 'SOF', 'SOF46', '24', '02659', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270495'),
	(44, 'PR2021', '02', 1, 1, 'КРАСНО СЕЛО', NULL, '', '', 'SOF', 'SOF46', '02', '68134', '0', NULL, '33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270526'),
	(45, 'PR2021', '01', 2, 1, 'СРЕДЕЦ', NULL, '', '', 'SOF', 'SOF46', '01', '68134', '02962', '6', '0', NULL, NULL, NULL, NULL, '1000', 'Мария Ачкова', NULL, 'Валери Цалов', 'Боголюба Андонова', 50, '2246', '22-ри Район - София', NULL, 7, '123456789'),
	(46, 'PR2021', '23', 2, 1, 'ПАНЧАРЕВО', '02 345678', '', '', 'SOF', 'SOF46', '23', '55419', '01924', '10', '0', NULL, NULL, NULL, NULL, NULL, 'Иван Петров', NULL, NULL, NULL, 50, '2246', '22-ри Район - София', NULL, 7, '123456789'),
	(47, 'PR2021', '07', 2, 1, 'СЛАТИНА', NULL, '', '', 'SOF', 'SOF46', '07', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, 'Наталия Стоянова', NULL, 'Полина Витанова', 'Жана Петрова', 66, '2246', '22-ри Район - София', NULL, 7, '0006963270001'),
	(48, 'PR2021', '08', 2, 1, 'ИЗГРЕВ', NULL, '', '', 'SOF', 'SOF46', '08', '68134', '04345', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 77, '2246', '22-ри Район - София', NULL, 7, '66666666666'),
	(49, 'PR2021', '03', 2, 1, 'ВЪЗРАЖДАНЕ', NULL, '', '', 'SOF', 'SOF46', '03', '68134', '02612', '4', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100, '2246', '22-ри Район - София', NULL, 0, '589966331'),
	(50, 'PR2021', '19', 2, 1, 'ЛЮЛИН', NULL, '', '', 'SOF', 'SOF46', '19', '0', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270652'),
	(51, 'PR2021', '05', 2, 1, 'СЕРДИКА', NULL, '', '', 'SOF', 'SOF46', '05', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270476'),
	(52, 'PR2021', '15', 2, 1, 'МЛАДОСТ', NULL, '', '', 'SOF', 'SOF46', '15', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270614'),
	(53, 'PR2021', '24', 2, 1, 'БАНКЯ', NULL, '', '', 'SOF', 'SOF46', '24', '02659', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270495'),
	(54, 'PR2021', '02', 2, 1, 'КРАСНО СЕЛО', NULL, '', '', 'SOF', 'SOF46', '02', '68134', '0', NULL, '33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '0006963270526'),
	(57, 'PR2021', '18', 2, 1, 'ОВЧА КУПЕЛ', NULL, '', '', 'SOF', 'SOF46', '18', '68134', '0', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2246', '22-ри Район - София', NULL, 0, '131174427');
/*!40000 ALTER TABLE `n_toa_main` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_top_dancoef
CREATE TABLE IF NOT EXISTS `n_top_dancoef` (
  `ID_Coef` int(6) NOT NULL AUTO_INCREMENT,
  `IZB_ALLIAS` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `Nred` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `Field_name` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tekst` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Coef_stoinost` decimal(10,4) DEFAULT NULL,
  `nap_colona` int(11) DEFAULT NULL,
  `Status_coef` int(1) DEFAULT '0',
  PRIMARY KEY (`ID_Coef`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_top_dancoef: ~12 rows (приблизително)
DELETE FROM `n_top_dancoef`;
/*!40000 ALTER TABLE `n_top_dancoef` DISABLE KEYS */;
INSERT INTO `n_top_dancoef` (`ID_Coef`, `IZB_ALLIAS`, `Nred`, `Field_name`, `Tekst`, `Coef_stoinost`, `nap_colona`, `Status_coef`) VALUES
	(1, 'PR2021', '01', 'NAD', 'ДОО работодател преди 1960', 0.2430, 36, 1),
	(2, 'PR2021', '02', 'BAN', 'ДОО работодател след 1959', 0.1930, 36, 1),
	(3, 'PR2021', '03', 'BAN1', 'ДЗПО работодател след 1959', 0.0500, 43, 1),
	(4, 'PR2021', '04', 'BAR', 'ЗО работодател', 0.0800, 38, 1),
	(5, 'PR2021', '05', 'NP_razhodi', 'Нормативно признати разходи', 0.0000, 0, 0),
	(6, 'PR2021', '06', 'TZPB', 'Труд. злополука/Проф. болест', 0.0070, 40, 1),
	(7, 'PR2021', '11', 'DOO_FP_pre', 'ДОО от лице преди 1960', NULL, NULL, 0),
	(8, 'PR2021', '12', 'DOO_FP_sle', 'ДОО от лице след 1959', NULL, NULL, 0),
	(9, 'PR2021', '13', 'DZPO_FP', 'ДЗПО от лице след 1959', NULL, NULL, 0),
	(10, 'PR2021', '14', 'ZO_FP', 'ЗО от лице', NULL, NULL, 0),
	(11, 'PR2021', '16', 'TZPB_FP', 'От ФЛ_Труд. злополука/Проф. болест', NULL, NULL, 0),
	(12, 'PR2021', '20', 'MRZ', 'Макс. осигурителен доход', 3000.0000, NULL, 1);
/*!40000 ALTER TABLE `n_top_dancoef` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_top_main
CREATE TABLE IF NOT EXISTS `n_top_main` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `IZB_ALIAS` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE1TUR` datetime(6) DEFAULT NULL,
  `DATE2TUR` datetime(6) DEFAULT NULL,
  `Status_parameters` int(1) DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_top_main: ~0 rows (приблизително)
DELETE FROM `n_top_main`;
/*!40000 ALTER TABLE `n_top_main` DISABLE KEYS */;
INSERT INTO `n_top_main` (`ID`, `IZB_ALIAS`, `Description`, `DATE1TUR`, `DATE2TUR`, `Status_parameters`) VALUES
	(7, 'PR2021', 'За Президент - 2021', '2021-10-11 00:00:00.000000', '2021-10-19 00:00:00.000000', 1);
/*!40000 ALTER TABLE `n_top_main` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_top_parameters
CREATE TABLE IF NOT EXISTS `n_top_parameters` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `IZB_ALIAS` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'MI2019',
  `KOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `Description` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Znachenie` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status_parameters` int(1) DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_top_parameters: ~6 rows (приблизително)
DELETE FROM `n_top_parameters`;
/*!40000 ALTER TABLE `n_top_parameters` DISABLE KEYS */;
INSERT INTO `n_top_parameters` (`ID`, `IZB_ALIAS`, `KOD`, `Description`, `Znachenie`, `Status_parameters`) VALUES
	(13, 'PR2021', '50', 'Брой нормодни  (Тур 1)', '3', 1),
	(14, 'PR2021', '51', 'Брой нормодни (Тур 2)', '2', 1),
	(15, 'PR2021', '52', 'Тур 1 Начална дата', '10.10.2021', 1),
	(16, 'PR2021', '53', 'Тур 1 Крайна дата', '12.10.2021', 1),
	(17, 'PR2021', '54', 'Тур 2 Начална  дата', '17.10.2021', 1),
	(18, 'PR2021', '55', 'Тур 2 Крайна дата', '18.10.2021', 1);
/*!40000 ALTER TABLE `n_top_parameters` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_top_partgrid
CREATE TABLE IF NOT EXISTS `n_top_partgrid` (
  `Id` int(6) NOT NULL AUTO_INCREMENT,
  `Izb_Alias` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_sek` int(11) DEFAULT NULL,
  `code_wnsila` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Code_rolia` int(11) DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `USER` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  `order_rolja` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_top_partgrid: ~0 rows (приблизително)
DELETE FROM `n_top_partgrid`;
/*!40000 ALTER TABLE `n_top_partgrid` DISABLE KEYS */;
/*!40000 ALTER TABLE `n_top_partgrid` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.n_top_partkvoti
CREATE TABLE IF NOT EXISTS `n_top_partkvoti` (
  `Id` int(6) NOT NULL AUTO_INCREMENT,
  `Izb_Alias` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `Izb_rajon` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_wnsila` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Code_rolia` int(11) DEFAULT NULL,
  `SIK_Clenove` int(4) DEFAULT NULL,
  `Status_kvoti` int(1) DEFAULT NULL,
  `USER` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.n_top_partkvoti: ~4 rows (приблизително)
DELETE FROM `n_top_partkvoti`;
/*!40000 ALTER TABLE `n_top_partkvoti` DISABLE KEYS */;
INSERT INTO `n_top_partkvoti` (`Id`, `Izb_Alias`, `Izb_rajon`, `TOA`, `code_wnsila`, `Code_rolia`, `SIK_Clenove`, `Status_kvoti`, `USER`, `KOGA`) VALUES
	(1, 'PR2021', 'nz', '02', '01', 401, 5, 1, 'a4905182-408b-4afd-8', '2019-12-30 15:33:19.401198'),
	(2, 'PR2021', 'nz', '02', '01', 402, 5, 1, 'a4905182-408b-4afd-8', '2019-12-30 15:33:19.422054'),
	(3, 'PR2021', 'nz', '02', '01', 403, 5, 1, 'a4905182-408b-4afd-8', '2019-12-30 15:33:19.432858'),
	(4, 'PR2021', 'nz', '02', '01', 404, 2, 1, 'a4905182-408b-4afd-8', '2019-12-30 15:33:19.437116');
/*!40000 ALTER TABLE `n_top_partkvoti` ENABLE KEYS */;

-- Дъмп структура за процедура votingregister.selectGrid
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectGrid`(prmToa varchar(2))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT  s.id_sek 
          ,s.AA_BB_CC as sikfullcode
          ,MAX(IF(n.Code_rolia=401,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum401
          ,SUM(IF(n.Code_rolia=401 and LENGTH(n.code_wnsila)>0,1,0)) as cnt401
          ,MAX(IF(n.Code_rolia=402,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum402
          ,SUM(IF(n.Code_rolia=402 and LENGTH(n.code_wnsila)>0,1,0)) as cnt402
          ,MAX(IF(n.Code_rolia=403,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum403
          ,SUM(IF(n.Code_rolia=403 and LENGTH(n.code_wnsila)>0,1,0)) as cnt403
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=1,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_1
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=2,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_2
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=3,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_3
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=4,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_4
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=5,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_5
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=6,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_6
          ,SUM(IF(n.Code_rolia=404 and LENGTH(n.code_wnsila)>0,1,0)) as cnt404
      FROM siks s 
             left join n_top_partgrid n on n.id_sek = s.id_sek 
      WHERE s.TOA = prmTOA 
        AND convert(s.sik, UNSIGNED INTEGER) > 0
        AND s.Status_Sekcia = 1        
      GROUP BY s.AA_BB_CC;
       
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectKvoti
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectKvoti`(prmToa varchar(2))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=1,VALUE,''))
          ,MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_izbalias, @v_tur
      FROM sys_main
      WHERE ID in (1,2);

    SELECT  w.nkod
          ,w.nime
          ,SUM(IFNULL(n.SIK_Clenove,0)) as total
          ,SUM(IF(n.Code_rolia=401, n.SIK_Clenove,0)) as sum401
          ,SUM(IF(n.Code_rolia=402, n.SIK_Clenove,0)) as sum402
          ,SUM(IF(n.Code_rolia=403, n.SIK_Clenove,0)) as sum403
          ,SUM(IF(n.Code_rolia=404, n.SIK_Clenove,0)) as sum404
      FROM wnsila w 
             left join n_top_partkvoti n 
             on n.code_wnsila = w.nkod 
              and n.izb_alias = @v_izbalias
              AND n.TOA = prmTOA  
      WHERE w.izb_alias = @v_izbalias 
      and w.status_partii = 1        
      GROUP BY w.nkod;
              
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectLica`(prmID int, prmDummy varchar(30))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

		select 
        l.ID,
        CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn,
         CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)) as im1,
         CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)) as im2,
         CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)) as im3,
        l.AP,
        l.BLOK,
        l.ET,
        l.Impmessage,
        l.impstatus,
        l.Jk_Kv,
        l.Koga,
        l.NAS,
        l.NAZ,
        l.NOM,
        l.OBL,
        l.Obra,
        l.OBS,
        l.PAS1,
        l.PAS2,
        l.PAS3,
        l.PAS4,
        l.PK,
        l.RAJ,
        l.Spec,
        l.TEL,
        l.UL,
        l.USER,
        l.VH,
        l.Vid_id  
      FROM n_lica l 
      WHERE ID = prmID;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectLica4Grid
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectLica4Grid`(prmFilter varchar(30), prmToa varchar(2), prmDummy varchar(30), prmSIK int)
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_tur
      FROM sys_main
      WHERE ID =2;
    
    IF IFNULL(prmSIK,0) > 0 THEN
  		select
          s.SIK
          ,l.ID
          ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
          ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
          ,c.NIME as dlyzjnost
          ,w.NIME as partia
          ,'' as Deistvie
          ,'' as Reshenie
          ,l.tel as Telefon
          ,i.tur
        FROM n_lica l 
            inner join n_lica_izbori i on l.ID = i.ID_Lice
            inner join siks s on s.Id_sek = i.Id_Sik
            left join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
            left join wnsila w on w.id_party = i.id_sila
        WHERE i.id_sik = prmSIK
          AND (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0)
        ORDER BY i.Code_rolia;      	
    ELSE
  		select
          s.SIK
          ,l.ID
          ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
          ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
          ,c.NIME as dlyzjnost
          ,w.NIME as partia
          ,'' as Deistvie
          ,'' as Reshenie          
          ,l.tel as Telefon
          ,@v_tur as tur
        FROM n_lica l 
            inner join n_lica_izbori i on l.ID = i.ID_Lice
            inner join siks s on s.Id_sek = i.Id_Sik
            left join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
            left join wnsila w on w.id_party = i.id_sila
        WHERE s.TUR = @v_tur
          AND s.TOA = prmToa
 
          AND (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0)
        ORDER BY s.SIK,i.Code_rolia;      	
    END IF;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectLica4ReplAction
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectLica4ReplAction`(prmToa varchar(2), prmSik varchar(3), prmDummy varchar(30))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';


    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_tur
    FROM sys_main
    WHERE ID =2;
    
		select
        l.ID
        ,s.sik as Sekciq
        ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn        
        ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)))  as Imena               
        ,c.nime as Dlujnost
        ,w1.nime as PoliticheskaSila
        ,IFNULL(w2.nime,'') as Reshenie
        ,i.ID as IdLiceIzbori 
      FROM n_lica l 
          inner join n_lica_izbori i on l.ID = i.ID_Lice
          inner join siks s on s.Id_sek = i.Id_Sik
          inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
          inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1          
          inner join n_list_codepositions c on c.nkode = i.code_rolia and c.PKODE=4
          inner join wnsila w1 on w1.id_Party = i.id_sila
          left join wndocs w2 on w2.nkod = i.re          
      WHERE i.TUR = @v_tur
        AND s.TOA = prmToa
        AND s.sik = IF(convert(prmSik, unsigned integer)=0,s.sik,prmSik)
        AND convert(s.sik, unsigned integer) > 0
        AND s.Status_Sekcia = 1
        AND i.code_rolia < 410
      ORDER BY s.SIK,i.Code_rolia;      	      
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectSik4Grid
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectSik4Grid`(
  prmTOA     varchar(2)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  INSERT INTO tblvalues 
      SELECT id_sek 
        FROM siks
        WHERE Izb_Alias = @v_izbalias
          AND TUR = @v_tur
          AND TOA = prmToa;
 --         AND Status_Sekcia=1
 --         AND convert(sik, UNSIGNED INTEGER) > 0;               
  
  SELECT 
      t.id as idsek
      ,s.sik
      ,fnGetSikAddress(t.id) as AdrIme
      ,s.Status_Sekcia as StatusSekcia
      ,n.NIME as Vid
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
        inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition
   ORDER BY 2;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectSikGrid
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectSikGrid`(prmSik int)
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT w.NKOD
          ,w.NIME
          ,SUM(IF(IFNULL(n.code_rolia,0) between 401 and 403,1,0)) as cntheadmembers
          ,SUM(IF(LENGTH(IFNULL(n.code_wnsila,""))>0,1,0)) as cntmembers
      FROM wnsila w 
             left join n_top_partgrid n on n.code_wnsila = w.NKOD and n.id_sek = prmSik
      WHERE w.status_partii = 1
      GROUP BY w.nkod;
       
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectSumGrid
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectSumGrid`(prmToa varchar(2))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=1,VALUE,''))
          ,MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_izbalias, @v_tur
      FROM sys_main
      WHERE ID in (1,2);

    SELECT  w.nime
            ,MAX(IF(n1.Code_rolia=401 and w.nkod = n1.code_wnsila,cnt,0)) as cnt401
            ,MAX(IF(n2.Code_rolia=401 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max401
            ,MAX(IF(n1.Code_rolia=402 and w.nkod = n1.code_wnsila,cnt,0)) as cnt402
            ,MAX(IF(n2.Code_rolia=402 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max402
            ,MAX(IF(n1.Code_rolia=403 and w.nkod = n1.code_wnsila,cnt,0)) as cnt403
            ,MAX(IF(n2.Code_rolia=403 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max403
            ,MAX(IF(n1.Code_rolia=404 and w.nkod = n1.code_wnsila,cnt,0)) as cnt404
            ,MAX(IF(n2.Code_rolia=404 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max404
      FROM wnsila w
              left join (SELECT code_wnsila, Code_rolia, COUNT(Code_rolia) cnt 
                           FROM n_top_partgrid n inner join siks s on s.id_sek = n.id_sek
                           WHERE convert(s.sik, UNSIGNED INTEGER) > 0
                             AND s.Status_Sekcia=1
                             and n.TOA = prmTOA        
                             AND n.izb_alias= @v_izbalias 
                           GROUP BY code_wnsila, Code_rolia) n1
                on w.nkod = n1.code_wnsila 
              left join (SELECT code_wnsila, Code_rolia, SUM(SIK_Clenove) maxcnt 
                           FROM n_top_partkvoti
                           WHERE TOA = prmTOA        
                             AND izb_alias= @v_izbalias 
                           GROUP BY code_wnsila, Code_rolia) n2
                on w.nkod = n2.code_wnsila 
      WHERE w.izb_alias= @v_izbalias 
        AND w.Status_Partii = 1
      GROUP BY w.nkod  ;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.selectWrongLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `selectWrongLica`(prmUser varchar(128))
BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

		select 
        l.ID,l.egn, im1, im2, im3, SIK, Rolja, Obra, Spec, Tel, opisanie,Status
      FROM n_lica_import l 
      WHERE USER = prmUser
        AND l.status>1;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.setObrabotkiOnOff
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `setObrabotkiOnOff`(
   prmUSER          varchar(128) 
   ,prmTOA          varchar(3)
)
BEGIN
  
  SET NAMES 'utf8';

  IF EXISTS(SELECT 1 FROM sys_main WHERE name = 'FINANCE' AND Value=prmTOA) THEN
      SELECT VALUE
        INTO @v_tur
        FROM sys_main
        WHERE ID =2;

     DELETE FROM sys_main WHERE name = 'FINANCE' AND Value=prmTOA;
     
     DELETE FROM n_lice_pari_zanap
        where ID_Lice in (select id 
                             from n_lica_izbori i inner join  siks s on i.id_sik = s.Id_sek
                             WHERE s.TOA = prmTOA
                               AND s.TUR = @v_tur);

     DELETE FROM n_lice_pari_zaplashtane 
        where ID_Lice in (select id 
                            from n_lica_izbori i inner join  siks s on i.id_sik = s.Id_sek
                             WHERE s.TOA = prmTOA
                               AND s.TUR = @v_tur);
        
     call createLog (prmUSER, 2,'Отмяна на финансовите изчисления','',prmTOA,'');     
  ELSE
     SELECT MAX(ID)+1 INTo @v_ID FROM sys_main;
     
     INSERT INTO sys_main (ID, Name, Value) 
          VALUES(@v_id, 'FINANCE',prmTOA);
  
     call createLog (prmUSER, 2,'Финансови изчисления','',prmTOA,'');
  END IF;   
  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.setPaymentCorrection
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `setPaymentCorrection`(
   prmIdLice  int
   ,prmUSER      varchar(128) 
   ,prmPARI      decimal(10,2)
   ,prmDummy     varchar(30)
)
BEGIN
  DECLARE prmIME      varchar(250);  
  
  SET NAMES 'utf8';

  SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
             CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        ,ifnull(i.hasmaxincome,0)
        ,TO_BASE64(AES_ENCRYPT(UPPER(l.EGN),prmDummy))             
        ,i.TOA
        ,i.Izb_Alias
        ,i.ID
    INTO @w_IME,  @v_hasmaxincome, @v_egn, @v_toa, @v_izb_alias, @prmIdLiceIzb
    FROM n_lica_izbori i 
          inner join  n_lica l ON i.ID_Lice = l.ID AND i.Tur = 1
    WHERE l.ID = prmIdLice;

  SELECT PARI
      INTO @_pari
      FROM n_lice_pari_zaplashtane 
      WHERE ID_Lice = @prmIdLiceIzb
        AND Code_Table = 3 and Code_possition = 330;
  
  SET @_pari  = IFNULL(@_pari,0) + prmPARI;
  
  DELETE FROM n_lice_pari_zaplashtane 
    WHERE ID_Lice = @prmIdLiceIzb
      AND Code_Table = 3 and Code_possition = 330;
  
  INSERT INTO n_lice_pari_zaplashtane  (`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
      VALUES(@prmIdLiceIzb, 3, 330, @_pari, NOW() );
    
  DELETE FROM n_lice_pari_zanap
    WHERE ID_Lice = @prmIdLiceIzb;
    
  IF @v_hasmaxincome = 0 THEN
        if fnGetLiceBirthYear(@v_egn) > 1959 THEN   
            
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT @prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = @prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = @v_izb_alias
                      AND CAST(nred AS UNSIGNED integer) between 2 and 10
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        ELSE
            
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT @prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = @prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = @v_izb_alias
                      AND (CAST(nred AS UNSIGNED integer) =1 OR CAST(nred AS UNSIGNED integer) between 4 and 10)
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        END IF;            
  END IF;   
    
  call createLog (prmUSER, 1,'Корекция на плащане в Тур 1',CONCAT(@w_IME,' [',prmIdLice,']'),IFNULL( @v_toa,''),'');
  select prmIdLice as ID from dual;  
END//
DELIMITER ;

-- Дъмп структура за таблица votingregister.siks
CREATE TABLE IF NOT EXISTS `siks` (
  `Id_sek` int(10) NOT NULL AUTO_INCREMENT,
  `Izb_Alias` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `TUR` int(1) DEFAULT NULL,
  `Izb_rajon` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `AA_BB_CC` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `Sik` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `Status_Sekcia` int(1) NOT NULL,
  `Obl` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Obs` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAS` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JK_KV` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UL` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Nom` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BLok` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tel` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ADR_IME` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  `broimembers` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`Id_sek`),
  KEY `JK_KV` (`JK_KV`),
  KEY `NAS` (`NAS`),
  KEY `Obl` (`Obl`),
  KEY `Obs` (`Obs`),
  KEY `FK_SIKS_WNTOA` (`TOA`),
  KEY `UL` (`UL`),
  CONSTRAINT `FK_SIKS_WNTOA` FOREIGN KEY (`TOA`) REFERENCES `wntoa` (`NKOD`),
  CONSTRAINT `siks_ibfk_1` FOREIGN KEY (`Obl`) REFERENCES `wnobl` (`NKOD`),
  CONSTRAINT `siks_ibfk_2` FOREIGN KEY (`Obs`) REFERENCES `wnobs` (`NKOD`)
) ENGINE=InnoDB AUTO_INCREMENT=3559 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.siks: ~61 rows (приблизително)
DELETE FROM `siks`;
/*!40000 ALTER TABLE `siks` DISABLE KEYS */;
INSERT INTO `siks` (`Id_sek`, `Izb_Alias`, `TUR`, `Izb_rajon`, `TOA`, `AA_BB_CC`, `Sik`, `Status_Sekcia`, `Obl`, `Obs`, `NAS`, `JK_KV`, `UL`, `Nom`, `BLok`, `Tel`, `ADR_IME`, `USER`, `Koga`, `broimembers`) VALUES
	(3492, 'PR2021', 1, '22', '01', '224601000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3493, 'PR2021', 1, '22', '02', '224602000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3494, 'PR2021', 1, '22', '03', '224603000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3495, 'PR2021', 1, '22', '04', '224604000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3496, 'PR2021', 1, '22', '05', '224605000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3497, 'PR2021', 1, '22', '06', '224606000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3498, 'PR2021', 1, '22', '07', '224607000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3499, 'PR2021', 1, '22', '08', '224608000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3500, 'PR2021', 1, '22', '09', '224609000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3501, 'PR2021', 1, '22', '10', '224610000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3502, 'PR2021', 1, '22', '11', '224611000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3503, 'PR2021', 1, '22', '12', '224612000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3504, 'PR2021', 1, '22', '13', '224613000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3505, 'PR2021', 1, '22', '14', '224614000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3506, 'PR2021', 1, '22', '15', '224615000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3507, 'PR2021', 1, '22', '16', '224616000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3508, 'PR2021', 1, '22', '17', '224617000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3509, 'PR2021', 1, '22', '18', '224618000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3510, 'PR2021', 1, '22', '19', '224619000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3511, 'PR2021', 1, '22', '20', '224620000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3512, 'PR2021', 1, '22', '21', '224621000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3513, 'PR2021', 1, '22', '22', '224622000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3514, 'PR2021', 1, '22', '23', '224623000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3515, 'PR2021', 1, '22', '24', '224624000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3516, 'PR2021', 1, '22', '25', '224625000', '000', 0, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:21:53.000000', 0),
	(3523, 'PR2021', 1, '22', '19', '224619001', '001', 1, 'SOF', 'SOF46', '68134', '41', '0', NULL, '1044', NULL, 'Това са президентски избори - Сек.1', '7b33da3b-8347-47cc-b7c5-7f4340d81bce', '2019-12-18 15:39:51.000000', 0),
	(3524, 'PR2021', 1, '22', '02', '224602001', '001', 1, 'SOF', 'SOF46', '68134', '0', '02610', '15', NULL, NULL, '36-то СОУ', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-18 15:47:06.000000', 0),
	(3525, 'PR2021', 1, '22', '02', '224602010', '010', 1, 'SOF', 'SOF46', '68134', '0', '0', NULL, NULL, NULL, 'Мед. Колеж ул. "Йорданка Филаретова" № 3 ', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:40:29.000000', 0),
	(3526, 'PR2021', 1, '22', '02', '224602011', '011', 1, 'SOF', 'SOF46', '68134', '0', '0', NULL, NULL, NULL, 'Мед. Колеж ул. "Йорданка Филаретова" № 3 ', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-27 15:52:45.000000', 0),
	(3527, 'PR2021', 1, '22', '02', '224602012', '012', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, '19-то СОУ ул. "Яков Крайков" № 16', '1111111111', NULL, 0),
	(3528, 'PR2021', 2, '22', '01', '224601000', '000', 1, 'SOF', 'SOF46', '68134', '0', '02612', NULL, NULL, NULL, NULL, '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-20 23:37:43.000000', 7),
	(3529, 'PR2021', 2, '22', '02', '224602000', '000', 1, 'SOF', 'SOF46', '68134', '0', '0', '', '', NULL, '', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-11 19:33:28.000000', 7),
	(3530, 'PR2021', 2, '22', '03', '224603000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3531, 'PR2021', 2, '22', '04', '224604000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3532, 'PR2021', 2, '22', '05', '224605000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3533, 'PR2021', 2, '22', '06', '224606000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3534, 'PR2021', 2, '22', '07', '224607000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3535, 'PR2021', 2, '22', '08', '224608000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3536, 'PR2021', 2, '22', '09', '224609000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3537, 'PR2021', 2, '22', '10', '224610000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3538, 'PR2021', 2, '22', '11', '224611000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3539, 'PR2021', 2, '22', '12', '224612000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3540, 'PR2021', 2, '22', '13', '224613000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3541, 'PR2021', 2, '22', '14', '224614000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3542, 'PR2021', 2, '22', '15', '224615000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3543, 'PR2021', 2, '22', '16', '224616000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3544, 'PR2021', 2, '22', '17', '224617000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3545, 'PR2021', 2, '22', '18', '224618000', '000', 1, 'SOF', 'SOF46', '68134', '0', '0', NULL, NULL, NULL, NULL, '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-02-26 15:07:15.000000', 7),
	(3546, 'PR2021', 2, '22', '19', '224619000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3547, 'PR2021', 2, '22', '20', '224620000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3548, 'PR2021', 2, '22', '21', '224621000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3549, 'PR2021', 2, '22', '22', '224622000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3550, 'PR2021', 2, '22', '23', '224623000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3551, 'PR2021', 2, '22', '24', '224624000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3552, 'PR2021', 2, '22', '25', '224625000', '000', 1, 'SOF', 'SOF46', '68134', NULL, NULL, NULL, NULL, NULL, NULL, 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3553, 'PR2021', 2, '22', '19', '224619001', '001', 1, 'SOF', 'SOF46', '68134', '41', '0', NULL, '1044', NULL, 'Това са президентски избори - Сек.1', 'a4905182-408b-4afd-850c-ffe46d0157b7', '2019-12-30 14:27:44.000000', 0),
	(3554, 'PR2021', 2, '22', '02', '224602001', '001', 1, 'SOF', 'SOF46', '68134', '0', '02610', '15', NULL, NULL, '36-то СОУ', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-05 18:48:29.000000', 5),
	(3555, 'PR2021', 2, '22', '02', '224602010', '010', 1, 'SOF', 'SOF46', '68134', '0', '0', NULL, NULL, NULL, 'Мед. Колеж ул. "Йорданка Филаретова" № 3 ', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-05 18:56:17.000000', 5),
	(3556, 'PR2021', 2, '22', '02', '224602011', '011', 1, 'SOF', 'SOF46', '68134', '0', '0', '', '', NULL, 'Мед. Колеж ул. "Йорданка Филаретова" № 3 ', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-09 19:52:58.000000', 7),
	(3557, 'PR2021', 2, '22', '02', '224602012', '012', 1, 'SOF', 'SOF46', '68134', '0', '0', '', '', NULL, '19-то СОУ ул. "Яков Крайков" № 16', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-16 19:23:38.000000', 7),
	(3558, 'PR2021', 2, '22', '01', '224601001', '001', 1, 'SOF', 'SOF46', '00357', '0', '0', NULL, NULL, NULL, 'тест', '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-02 12:16:08.000000', 7);
/*!40000 ALTER TABLE `siks` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.siks_podvijni
CREATE TABLE IF NOT EXISTS `siks_podvijni` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Id_Sik` int(11) NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `Voter_number` int(10) NOT NULL DEFAULT '0',
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_SIKS_PODVIJNI_SIKS` (`Id_Sik`),
  CONSTRAINT `FK_SIKS_PODVIJNI_SIKS` FOREIGN KEY (`Id_Sik`) REFERENCES `siks` (`Id_sek`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.siks_podvijni: ~4 rows (приблизително)
DELETE FROM `siks_podvijni`;
/*!40000 ALTER TABLE `siks_podvijni` DISABLE KEYS */;
INSERT INTO `siks_podvijni` (`ID`, `Id_Sik`, `TOA`, `Voter_number`, `USER`, `Koga`) VALUES
	(1, 3556, '02', 10, NULL, NULL),
	(2, 3556, '01', 2, NULL, NULL),
	(3, 3556, '03', 5, NULL, NULL),
	(8, 3557, '01', 2, '78752568-4ac7-4809-8eab-491a00c3bb9c', '2020-03-16 19:23:38.103490');
/*!40000 ALTER TABLE `siks_podvijni` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.siks_vidove
CREATE TABLE IF NOT EXISTS `siks_vidove` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `IZB_allias` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `Tur` int(1) NOT NULL,
  `Id_Sik` int(11) NOT NULL,
  `Vid_codetable` int(11) NOT NULL DEFAULT '0',
  `Idcodeposition` int(11) NOT NULL DEFAULT '0',
  `Status` int(1) DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `FK_SIKS_VIDOVE_SIKS` (`Id_Sik`),
  CONSTRAINT `FK_SIKS_VIDOVE_SIKS` FOREIGN KEY (`Id_Sik`) REFERENCES `siks` (`Id_sek`)
) ENGINE=InnoDB AUTO_INCREMENT=3348 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.siks_vidove: ~65 rows (приблизително)
DELETE FROM `siks_vidove`;
/*!40000 ALTER TABLE `siks_vidove` DISABLE KEYS */;
INSERT INTO `siks_vidove` (`ID`, `IZB_allias`, `Tur`, `Id_Sik`, `Vid_codetable`, `Idcodeposition`, `Status`) VALUES
	(1, 'PR2021', 1, 3523, 1, 101, 1),
	(2, 'PR2021', 1, 3523, 2, 201, 1),
	(3, 'PR2021', 1, 3524, 1, 101, 1),
	(3247, 'PR2021', 1, 3492, 1, 101, 1),
	(3248, 'PR2021', 1, 3493, 1, 101, 1),
	(3249, 'PR2021', 1, 3494, 1, 101, 1),
	(3250, 'PR2021', 1, 3495, 1, 101, 1),
	(3251, 'PR2021', 1, 3496, 1, 101, 1),
	(3252, 'PR2021', 1, 3497, 1, 101, 1),
	(3253, 'PR2021', 1, 3498, 1, 101, 1),
	(3254, 'PR2021', 1, 3499, 1, 101, 1),
	(3255, 'PR2021', 1, 3500, 1, 101, 1),
	(3256, 'PR2021', 1, 3501, 1, 101, 1),
	(3257, 'PR2021', 1, 3502, 1, 101, 1),
	(3258, 'PR2021', 1, 3503, 1, 101, 1),
	(3259, 'PR2021', 1, 3504, 1, 101, 1),
	(3260, 'PR2021', 1, 3505, 1, 101, 1),
	(3261, 'PR2021', 1, 3506, 1, 101, 1),
	(3262, 'PR2021', 1, 3507, 1, 101, 1),
	(3263, 'PR2021', 1, 3508, 1, 101, 1),
	(3264, 'PR2021', 1, 3509, 1, 101, 1),
	(3265, 'PR2021', 1, 3510, 1, 101, 1),
	(3266, 'PR2021', 1, 3511, 1, 101, 1),
	(3267, 'PR2021', 1, 3512, 1, 101, 1),
	(3268, 'PR2021', 1, 3513, 1, 101, 1),
	(3269, 'PR2021', 1, 3514, 1, 101, 1),
	(3270, 'PR2021', 1, 3515, 1, 101, 1),
	(3271, 'PR2021', 1, 3516, 1, 101, 1),
	(3274, 'PR2021', 1, 3527, 1, 101, 1),
	(3275, 'PR2021', 1, 3525, 1, 101, 1),
	(3276, 'PR2021', 1, 3525, 2, 201, 1),
	(3277, 'PR2021', 1, 3526, 1, 102, 1),
	(3280, 'PR2021', 2, 3530, 1, 101, 1),
	(3281, 'PR2021', 2, 3531, 1, 101, 1),
	(3282, 'PR2021', 2, 3532, 1, 101, 1),
	(3283, 'PR2021', 2, 3533, 1, 101, 1),
	(3284, 'PR2021', 2, 3534, 1, 101, 1),
	(3285, 'PR2021', 2, 3535, 1, 101, 1),
	(3286, 'PR2021', 2, 3536, 1, 101, 1),
	(3287, 'PR2021', 2, 3537, 1, 101, 1),
	(3288, 'PR2021', 2, 3538, 1, 101, 1),
	(3289, 'PR2021', 2, 3539, 1, 101, 1),
	(3290, 'PR2021', 2, 3540, 1, 101, 1),
	(3291, 'PR2021', 2, 3541, 1, 101, 1),
	(3292, 'PR2021', 2, 3542, 1, 101, 1),
	(3293, 'PR2021', 2, 3543, 1, 101, 1),
	(3294, 'PR2021', 2, 3544, 1, 101, 1),
	(3296, 'PR2021', 2, 3546, 1, 101, 1),
	(3297, 'PR2021', 2, 3547, 1, 101, 1),
	(3298, 'PR2021', 2, 3548, 1, 101, 1),
	(3299, 'PR2021', 2, 3549, 1, 101, 1),
	(3300, 'PR2021', 2, 3550, 1, 101, 1),
	(3301, 'PR2021', 2, 3551, 1, 101, 1),
	(3302, 'PR2021', 2, 3552, 1, 101, 1),
	(3303, 'PR2021', 2, 3553, 1, 101, 1),
	(3304, 'PR2021', 2, 3553, 2, 201, 1),
	(3313, 'PR2021', 2, 3528, 1, 101, 0),
	(3320, 'PR2021', 2, 3545, 1, 101, 0),
	(3321, 'PR2021', 2, 3558, 1, 101, 1),
	(3328, 'PR2021', 2, 3554, 1, 101, 1),
	(3329, 'PR2021', 2, 3555, 1, 104, 1),
	(3330, 'PR2021', 2, 3555, 2, 201, 1),
	(3340, 'PR2021', 2, 3556, 1, 102, 0),
	(3343, 'PR2021', 2, 3529, 1, 100, 0),
	(3347, 'PR2021', 2, 3557, 1, 102, 1);
/*!40000 ALTER TABLE `siks_vidove` ENABLE KEYS */;

-- Дъмп структура за процедура votingregister.spravka_1_1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_1_1`(
  prmIZB_R    varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_1_1',prmIZB_R,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
    
  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  IF prmIZB_R = '00' THEN
    INSERT INTO tblizbr
        SELECT nkod, nime
          FROM wnizbraion 
          WHERE IZB_ALIAS = @v_izbalias
            AND STATUS=1;
  ELSE
      INSERT INTO tblizbr
          SELECT nkod, nime
              FROM wnizbraion 
              WHERE IZB_ALIAS = @v_izbalias
                AND NKOD = prmIZB_R
                AND STATUS=1;
  END IF;     


  SELECT w1.NIME as nmizbrajon
        ,w3.NIME as nmrajon
        ,COUNT(distinct s.sik) total
        ,SUM(CASE WHEN s.Idcodeposition =101 THEN 1 ELSE 0 END) basic
        ,SUM(CASE WHEN s.Idcodeposition =102 THEN 1 ELSE 0 END) mobail
        ,SUM(CASE WHEN s.Idcodeposition =103 THEN 1 ELSE 0 END) official
        ,SUM(CASE WHEN s.Idcodeposition =104 THEN 1 ELSE 0 END) another
    FROM tblizbr t 
          inner join wnizbraion w1 on t.nkod = w1.nkod and w1.status =1
          inner join wntoa_izbraion w2 on w2.izb_r = w1.nkod
          inner join wntoa w3 on w3.NKOD = w2.NKOD
          left join  (SELECT s0.sik, s0.TOA, sv.Idcodeposition 
                        FROM siks s0 
                              inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
                              inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1
                        WHERE s0.Izb_Alias =@v_izbalias
                          and s0.TUR =@v_tur
                          and s0.Status_Sekcia=1) s 
          on s.TOA = w3.NKOD                          
    GROUP BY w3.NKOD
    ORDER BY t.name, w3.NIME;  
    
  DROP TEMPORARY TABLE tblizbr;   
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_1_2
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_1_2`(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmUSER    varchar(128)
  ,prmSIKS    varchar(100)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_1_2',prmTOA,'');

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);
  
  IF LENGTH(prmSIKS) > 0 THEN
    SET @Values = prmSIKS;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblvalues VALUES(@value);
    END WHILE;

    SET @value = ELT(1, @Values);
    INSERT INTO tblvalues VALUES(@value);
  
  ELSE
      IF convert(prmTOA, unsigned integer) > 0 THEN
          INSERT INTO tblvalues 
              SELECT id_sek 
                FROM siks s0
                  inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
                  inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1     
                WHERE s0.Izb_Alias = @v_izbalias
                  AND s0.TUR = @v_tur
                  AND s0.TOA = prmToa
                  AND s0.Status_Sekcia=1;               
      ELSE
        IF prmIZB_R = '00' THEN
          INSERT INTO tblizbr
              SELECT nkod, nime
                FROM wnizbraion 
                WHERE IZB_ALIAS = @v_izbalias
                  AND STATUS=1;
        ELSE
            INSERT INTO tblizbr
                SELECT nkod, nime
                    FROM wnizbraion 
                    WHERE IZB_ALIAS = @v_izbalias
                      AND NKOD = prmIZB_R
                      AND STATUS=1;
        END IF;    
      
        INSERT INTO tblvalues           
           SELECT s.id_sek
           FROM tblizbr t
                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R
                INNER JOIN siks s ON s.TOA = w1.NKOD 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
                    AND s.Status_Sekcia=1
                inner join siks_vidove sv on s.Id_sek = sv.Id_Sik
                inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1;     
      END IF;

      DROP TEMPORARY TABLE tblizbr;
  END IF;

  SELECT 
      t.id
      ,w8.nime as nmizbrajon
      ,w6.nime as nmrajon
      ,s.AA_BB_CC siknumb
      ,fnGetSikAddress(t.id) as address
      ,v.vid
      ,IFNULL(v.priznak,'') priznak
      ,IF(cntmembers=0,"Няма",IF(s.broimembers > cntmembers,"Недостатъчен",IF(cntmembers>s.broimembers,"Надвишен","OK"))) control
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join (SELECT id_sik
                           ,GROUP_CONCAT(c1.nime) vid
                           ,GROUP_CONCAT(c2.nime) priznak
                      FROM siks_vidove v
                             left join n_list_codepositions c1 on c1.NKODE = v.Idcodeposition and c1.PKODE=1
                             left join n_list_codepositions c2 on c2.NKODE = v.Idcodeposition and c2.PKODE=2
                      GROUP BY id_sik) v
            on v.Id_Sik = s.Id_sek  
        inner join (SELECT id_sik, count(id_lice) cntmembers 
                      FROM n_lica_izbori 
                      WHERE Code_rolia < 410
                      group by ID_SIK ) i on i.id_sik = t.id
        inner join wntoa w6 on w6.nkod = s.toa
        inner join wntoa_izbraion w7 on w7.nkod = w6.nkod
        inner join wnizbraion w8 on w8.nkod = w7.izb_r and w8.status =1
    ORDER BY 2,3,4;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_1_4
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_1_4`(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int, sumvoter int);
  
  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT s0.id_sek, sum(Voter_number) 
            FROM siks s0
              inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik AND sv.Idcodeposition  = 102
              inner join siks_podvijni sp on sp.id_sik = s0.id_sek
            WHERE s0.Izb_Alias = @v_izbalias
              AND s0.TUR = @v_tur
              AND s0.Status_Sekcia=1
              AND sp.TOA = prmToa
            GROUP BY s0.id_sek;
  ELSE
    IF prmIZB_R = '00' THEN
      INSERT INTO tblizbr
          SELECT nkod, nime
            FROM wnizbraion 
            WHERE IZB_ALIAS = @v_izbalias
              AND STATUS=1;
    ELSE
        INSERT INTO tblizbr
            SELECT nkod, nime
                FROM wnizbraion 
                WHERE IZB_ALIAS = @v_izbalias
                  AND NKOD = prmIZB_R
                  AND STATUS=1;
    END IF;    
  
    INSERT INTO tblvalues           
       SELECT s.id_sek, sum(Voter_number)
       FROM siks s 
            inner join siks_vidove sv on s.Id_sek = sv.Id_Sik AND sv.Idcodeposition  = 102
            inner join siks_podvijni sp on sp.id_sik = s.id_sek
       WHERE sp.TOA IN (SELECT w1.NKOD 
                          FROM tblizbr t
                                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R)    
          AND s.Izb_Alias = @v_izbalias 
          AND s.TUR = @v_tur
          AND s.Status_Sekcia=1
       GROUP BY s.id_sek;
  END IF;

  DROP TEMPORARY TABLE tblizbr;

  SET @row_number = 0;
  
  SELECT 
      (@row_number:=@row_number + 1) AS Id 
      ,w8.nime as nmizbrajon
      ,w6.nime as nmrajon
      ,t.sumvoter
      ,s.AA_BB_CC as siknumb
      ,fnGetSikAddress(t.id) as address
      ,w1.nime obsrajon
      ,sp.Voter_number voters
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join siks_podvijni sp on sp.id_sik = t.id
        inner join wntoa w1 on w1.nkod = sp.toa             -- obsluzjvashti rajoni
        inner join wntoa w6 on w6.nkod = s.toa              -- sik adm. rajon
        inner join wntoa_izbraion w7 on w7.nkod = w6.nkod
        inner join wnizbraion w8 on w8.nkod = w7.izb_r and w8.status =1
    ORDER BY 2,3,5;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_2_1_1
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_2_1_1`(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_2_1_1',prmTOA,'');

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF LENGTH(prmSIKS) > 0 THEN
    SET @Values = prmSIKS;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblvalues VALUES(@value);
    END WHILE;

    SET @value = ELT(1, @Values);
    INSERT INTO tblvalues VALUES(@value);
  
  ELSE
    IF convert(prmTOA, unsigned integer) > 0 THEN
        INSERT INTO tblvalues 
            SELECT s.id_sek 
              FROM siks s
                inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
              WHERE s.Izb_Alias = @v_izbalias
                AND s.TUR =  @v_tur
                AND s.TOA = prmToa
                AND s.Status_Sekcia=1;               
    ELSE
       IF prmIZB_R = '00' THEN
            INSERT INTO tblizbr
                SELECT nkod, nime
                  FROM wnizbraion 
                  WHERE IZB_ALIAS = @v_izbalias
                    AND STATUS=1;
        ELSE
            INSERT INTO tblizbr
                SELECT nkod, nime
                    FROM wnizbraion 
                    WHERE IZB_ALIAS = @v_izbalias
                      AND NKOD = prmIZB_R
                      AND STATUS=1;
        END IF;   
 
       INSERT INTO tblvalues           
         SELECT s.id_sek
         FROM tblizbr t
              INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R
              INNER JOIN siks s ON s.TOA = w1.NKOD 
                  AND s.Izb_Alias = @v_izbalias 
                  AND s.TUR = @v_tur
                  AND s.Status_Sekcia=1
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1;   
    END IF;
  END IF;

  DROP TEMPORARY TABLE tblizbr;

   SELECT
        w6.NIME as nmizbrajon        
        ,w5.NIME as nmrajon
        ,aa_bb_cc as sikfullcode
        ,p.nime   rolia
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,w1.nime  sila
        ,lc.tel 
        ,w2.nime  re
        ,w3.nime  obra 
        ,w4.nime  spec
        ,fnGetSikAddress(t.id) as sikaddress
   FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
        INNER JOIN wnizbraion w6 ON w6.NKOD =  s.izb_rajon and w6.IZB_ALIAS =  @v_izbalias 
        left join wndocs w2 on w2.NKOD = l.re
        left join wnszem w3 on w3.NKOD = lc.obra
        left join wnspec w4 on w4.NKOD = lc.spec
		WHERE l.Code_rolia < 410		
    ORDER BY 1,2,3, l.Code_rolia;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_2_1_2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_2_1_2`(
  prmToa      varchar(2)
  ,prmSIKS     varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_2_1_2',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF LENGTH(prmSIKS) > 0 THEN
    SET @Values = prmSIKS;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblvalues VALUES(@value);
    END WHILE;

    SET @value = ELT(1, @Values);
    INSERT INTO tblvalues VALUES(@value);
  
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
                inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR =  @v_tur
            AND s.TOA = prmToa
            AND (s.Status_Sekcia=1 or  n.CALC=0);               
  END IF;

  SELECT
        w5.NIME as NmRajon
        ,aa_bb_cc as sikfullcode
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.nime   rolia
        ,w1.nime  sila
        ,lc.tel 
   FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
		WHERE l.Code_rolia = 410		
    ORDER BY 1,2,w1.nime;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_2_1_3
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_2_1_3`(
  prmTOA      varchar(2)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_2_1_3',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int, siknumb varchar(10));

  INSERT INTO tblvalues 
      SELECT id_sek, concat(aa_bb_cc,sik) 
        FROM siks
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
        WHERE Izb_Alias = @v_izbalias
          AND TUR = @v_tur
          AND TOA = prmToa
          AND Status_Sekcia=1;               

  SELECT t.siknumb
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.nime   rolia
        ,w1.nime  sila
        ,w2.nime  re
        ,lc.tel 
        ,w3.nime  obra 
        ,w4.nime  spec
   FROM tblvalues t
        inner join n_lica_izbori l on l.Id_Sik = t.id
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        inner join wndocs w2 on w2.NKOD = l.re
        inner join wnszem w3 on w3.NKOD = lc.obra
        inner join wnspec w4 on w4.NKOD = lc.spec
		WHERE l.Code_rolia < 410		
    ORDER BY 1, l.Code_rolia;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_2_2_1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_2_2_1`(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(2)
  ,prmOper    int
  ,prmSik     varchar(3)
  ,prmFilter  varchar(30)  
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_2_2_1',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  CALL spravka_filter_lica(
            prmTOA
            ,prmIdRolja
            ,prmIdSila
            ,prmRe    
            ,prmOper  
            ,prmSik   
            ,prmFilter
            ,prmUSER  
            ,prmDummy 
            ,0  
  );

  SELECT w2.NIME
        ,s.AA_BB_CC siknumb
        ,p.NIME
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,w1.nime
        ,lc.tel
   FROM tblvalues t
        inner join n_lica_izbori i on i.id = t.id
        INNER JOIN siks s ON s.id_sek = i.id_sik
        inner join n_lica lc on lc.Id = i.id_lice
        INNER JOIN wntoa w2 ON s.TOA = w2.NKOD
        inner join n_list_codepositions p on p.NKODE = i.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = i.id_sila
		WHERE i.Code_rolia < 410		
    ORDER BY 1, 2;

  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_2_3
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_2_3`(
  prmTOA      varchar(2)
  ,prmSIKS     varchar(100)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_3_3',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
  
    
  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF LENGTH(prmSIKS) > 0 THEN
    SET @Values = prmSIKS;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblvalues VALUES(@value);
    END WHILE;

    SET @value = ELT(1, @Values);
    INSERT INTO tblvalues VALUES(@value);
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.TOA = prmToa
            AND s.status_sekcia = 1;       
  END IF;

  SET @row_number = 0;


  SELECT (@row_number:=@row_number + 1) AS Id         ,
        w6.NIME as nmizbrajon        
        ,w5.NIME as nmrajon
        ,aa_bb_cc as sikfullcode
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im3),prmDummy) as CHAR(50)),'')) as imenovo
        ,CAST(AES_DECRYPT(FROM_BASE64(l1.egn),prmDummy) as CHAR(50)) as egnnovo
            
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im3),prmDummy) as CHAR(50)),'')) as imestaro
        ,CAST(AES_DECRYPT(FROM_BASE64(l2.egn),prmDummy) as CHAR(50)) as egnstaro

        ,p.nime  rolia
        ,w1.NIME partia
        ,DATE_FORMAT(z.koga, '%d.%m.%Y %H:%i:%s') as koga
    FROM tblvalues t 
        inner join n_lica_izbori_zamestvane z on z.id_sek = t.id
        inner join siks s on s.id_sek = z.id_sek
        inner join n_list_codepositions p on p.NKODE = z.id_rolja and p.PKODE=4
        inner join wnsila w1 on w1.ID_Party = z.id_sila
        inner join (SELECT l.*, i.id as idizbori  
                      FROM n_lica_izbori i inner join n_lica l on i.id_lice = l.id) l1 
              on l1.idizbori = z.ID_Lice_novo
        inner join (SELECT l.*, i.id as idizbori 
                      FROM n_lica_izbori i inner join n_lica l on i.id_lice = l.id) l2 
              on l2.idizbori = z.ID_Lice_staro
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
        INNER JOIN wnizbraion w6 ON w6.NKOD =  s.izb_rajon AND w6.izb_alias= @v_izbalias
		ORDER BY 2,3,z.koga;
    
  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_3_1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_3_1`(
  prmTOA     varchar(2)
  ,prmTUR     int
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';  
  
  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_3_1',prmTOA,'');

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      izb_rajon varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF convert(prmSIKS, UNSIGNED INTEGER)> 0 THEN
      DROP TEMPORARY TABLE if exists tblsiks;
      CREATE TEMPORARY TABLE if not exists tblsiks (sik varchar(3));

      SET @Values = prmSIKS;
      WHILE (LOCATE(',', @Values) > 0)
      DO
          SET @value = ELT(1, @Values);
          SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

          INSERT INTO tblsiks 
              SELECT sik 
                FROM SIKS 
                WHERE ID_SEK = @value 
                  and TOA =  prmTOA;
      END WHILE;

      SET @value = ELT(1, @Values);
      INSERT INTO tblsiks 
          SELECT sik 
            FROM SIKS 
            WHERE ID_SEK = @value 
              and TOA =  prmTOA;
    
      INSERT INTO tblvalues
        SELECT ID_SEK
          FROM siks s inner join tblsiks t on s.sik = t.sik and s.TUR = prmTUR and s.TOA = prmTOA;     
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE Izb_Alias = @v_izbalias
            AND TUR =  prmTUR
            AND TOA = prmToa
            AND status_sekcia = 1;               
  END IF;

  DROP TEMPORARY TABLE tblizbr;

  SET @row_number = 0;


  SELECT 
        nmizbrajon
        , nmrajon
        ,(@row_number := @row_number + 1) AS num
        ,sikcode
        ,rolia
        ,ime
        ,suma
        ,AA_BB_CC as SikFullCode
        ,Code_rolia
        ,z.Egn
    FROM (SELECT 
                w4.nime  as nmizbrajon
                ,w2.NIME as nmrajon
                ,sikcode
                ,rolia
                ,ime
                ,suma
                ,AA_BB_CC
                ,Code_rolia
                ,x.Egn
            FROM (SELECT    
                      s.Izb_rajon
                      ,s.toa
                      ,sik as sikcode
                      ,p.nime   rolia
                      ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
                      ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
                             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  as ime
                      ,IFNULL(round(w4.pari,2),0) as suma
                      ,s.AA_BB_CC
                      ,l.Code_rolia
                     FROM tblvalues t
                          inner join siks s on s.Id_sek = t.id
                          inner join n_lica_izbori l on l.Id_Sik = s.id_sek
                          inner join n_lica lc on lc.Id = l.id_lice
                          inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
                          inner join (SELECT id_lice, sum(pari) pari 
                                        from n_lice_pari_zaplashtane 
                                        group by id_lice) w4 
                          on w4.id_lice = l.id
                      ORDER BY s.sik, l.Code_rolia) x
                  inner join wntoa w2 on w2.NKOD = x.toa
                  inner join wntoa_izbraion w3 on w3.nkod = w2.nkod and w3.IZB_R = x.izb_rajon
                  inner join wnizbraion w4 on w4.nkod = w3.izb_r and w4.izb_alias = @v_izbalias
             WHERE suma >0) z
      ORDER BY AA_BB_CC, Code_rolia;
             
  DROP TEMPORARY TABLE tblvalues;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_3_2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_3_2`(
  prmTOA      varchar(2)
  ,prmTUR     int
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE done TINYINT DEFAULT FALSE;
  DECLARE v_id INT DEFAULT 0;

  DECLARE crsFields 
     CURSOR FOR SELECT id FROM tblpart2 t1; 

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  SET NAMES 'utf8';
  SET @v_tur = prmTUR;

  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);

  SELECT coef_stoinost
     INTO @v_maxosigsum 
     FROM n_top_dancoef
     WHERE Izb_Allias = @v_izbalias
       AND status_coef = 1 
       and nred = '20';

  call createLog (prmUSER, 3,'Справка','spravka_3_2',prmTOA,'');

  DROP TEMPORARY TABLE  IF EXISTS `tblvalues`;

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF convert(prmSIKS, UNSIGNED INTEGER)> 0 THEN
      DROP TEMPORARY TABLE if exists tblsiks;
      CREATE TEMPORARY TABLE if not exists tblsiks (sik varchar(3));

      SET @Values = prmSIKS;
      WHILE (LOCATE(',', @Values) > 0)
      DO
          SET @value = ELT(1, @Values);
          SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

          INSERT INTO tblsiks 
              SELECT sik 
                FROM SIKS 
                WHERE ID_SEK = @value 
                  and TOA =  prmTOA;
      END WHILE;

      SET @value = ELT(1, @Values);
      INSERT INTO tblsiks 
          SELECT sik 
            FROM SIKS 
            WHERE ID_SEK = @value 
              and TOA =  prmTOA;
    
      INSERT INTO tblvalues
        SELECT ID_SEK
          FROM siks s inner join tblsiks t on s.sik = t.sik and s.TUR = prmTUR and s.TOA = prmTOA;     
  
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.TOA = prmToa
            AND s.status_sekcia = 1;               
  END IF;

  -- syzdavam vremenna tablica
  CREATE TEMPORARY TABLE if not exists tblpart2 (
         id int
        ,S01 varchar(100) not null default '0'
        ,S02 varchar(100) not null default '0'
        ,S03 varchar(100) not null default '0'
        ,S04 varchar(100) not null default '0'
        ,S05 varchar(100) not null default '0'
        ,S06 varchar(100) not null default '0'
        ,S07 varchar(100) not null default '0'
        ,S08 varchar(100) not null default '0'
        ,S09 varchar(100) not null default '0'
        ,S10 varchar(100) not null default '0'
        ,S   varchar(100) not null default '0'
        ,T   decimal (10,2) not null default 0
  );        

  INSERT INTO tblpart2 (id,S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S,T)
      VALUES (0,'','','','','','','','','','','Общо осигуровки',0);

  -- popylva se headera
  SET @sql = NULL;
  SELECT CONCAT ('UPDATE tblpart2 SET '
                 ,GROUP_CONCAT(DISTINCT CONCAT(' S',nred,'=','\'',tekst,'\''))
                 ,' WHERE ID = 0'
         )        
     INTO @sql
     FROM n_top_dancoef
     WHERE Izb_Allias = @v_izbalias
       AND status_coef = 1 
       and convert(nred, UNSIGNED INTEGER) < '20';

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  -- popylvat se redovete
  INSERT INTO tblpart2 (id )
     SELECT l.id 
     FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek;

  OPEN crsFields;
  my_loop: 
  LOOP
    FETCH NEXT FROM crsFields INTO v_id;

    IF done THEN 
      LEAVE my_loop; 
    ELSE 
      SET @sql = NULL;
      SELECT CONCAT ('UPDATE tblpart2 SET '
                     ,GROUP_CONCAT(DISTINCT CONCAT(' S',n.Code_dancoef,'=','\'',convert(ifnull(round(n.pari,2),0),char),'\''))
                     ,' WHERE ID = '
                     ,convert(v_id,char)
             ), SUM(n.pari)        
         INTO @sql, @suma
         FROM n_lice_pari_zanap n 
         WHERE n.id_lice = v_id;

      IF length(IFNULL(@sql,''))>0 THEN
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        UPDATE tblpart2 
            SET s=convert(round(@suma,2), char),  t= @suma 
            WHERE id = v_id;
      END IF;
      
      SET done = false;      
    END IF;
  END LOOP;
  CLOSE crsFields;
  
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
     SELECT SUM(convert(S01, decimal(10,2)))  as S01
            ,SUM(convert(S02, decimal(10,2))) as S02
            ,SUM(convert(S03, decimal(10,2))) as S03
            ,SUM(convert(S04, decimal(10,2))) as S04
            ,SUM(convert(S05, decimal(10,2))) as S05
            ,SUM(convert(S06, decimal(10,2))) as S06
            ,SUM(convert(S07, decimal(10,2))) as S07
            ,SUM(convert(S08, decimal(10,2))) as S08
            ,SUM(convert(S09, decimal(10,2))) as S09
            ,SUM(convert(S10, decimal(10,2))) as S10
            ,SUM(convert(S, decimal(10,2)))   as S
     FROM tblpart2 t
     WHERE ID > 0;
  
  -- popylvat se redovete
  INSERT INTO tblpart2 (id, S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S)
    SELECT 999999,S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S FROM tmptable;
    
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;
  
  -- popylvat se part1 na rablicata
  DROP TEMPORARY TABLE  IF EXISTS `tblpart1`;

  CREATE TEMPORARY TABLE if not exists tblpart1 (
        id          int
        ,col1       varchar(100)
        ,col2       varchar(100)
        ,col3       varchar(400)
        ,col4       varchar(150)
        ,col5       varchar(100)
        ,col6       varchar(100)
        ,birthyear  int
        ,nmizbrajon varchar(45)
        ,nmrajon    varchar(45)
        ,orders     int
        ,Code_rolia int
        
  );

  SELECT w1.nime 
    INTO @nmizbrajon
    FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.nkod = w2.Izb_r and w2.nkod = prmTOA
    WHERE w1.status = 1;
    
  SELECT w2.nime 
    INTO @nmrajon
    FROM wntoa w2 
    WHERE w2.NKOD = prmTOA;
    
   SELECT round(sum(w4.pari),2)
      INTO @sumpari
     FROM tblvalues t
          inner join n_lica_izbori l on l.Id_Sik = t.id
          inner join (SELECT id_lice, sum(pari) pari 
                        from n_lice_pari_zaplashtane 
                        group by id_lice) w4 on w4.id_lice = l.id;
      
  INSERT INTO tblpart1 VALUES(0,'№','СИК','Име, Презиме, Фамилия','Длъжност','Начислена сума','Осиг. доход',0,@nmizbrajon,@nmrajon,0,0);
  
  INSERT INTO tblpart1 (ID, orders,col4,col5, col6) VALUES(999999,2,'Общо',@sumpari,@sumpari);
  
  INSERT INTO tblpart1 
    SELECT    
      l.id
      ,0
      ,sik as sikcode
      ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im1),prmDummy) as CHAR(50)),''),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im2),prmDummy) as CHAR(50)),''),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im3),prmDummy) as CHAR(50)),''))  ime
      ,p.nime   rolia
      ,round(w4.pari,2) as suma        
      ,ROUND(w4.pari,2) as maxosigsuma
      ,fnGetLiceBirthYear(CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50))) as birthyear
      ,'' as nmizbrajon
      ,'' as nmrajon     
      ,1
      ,l.Code_rolia
     FROM tblvalues t
          inner join siks s on s.Id_sek = t.id
          inner join n_lica_izbori l on l.Id_Sik = s.id_sek
          inner join n_lica lc on lc.Id = l.id_lice
          inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
          inner join (SELECT id_lice, sum(pari) pari from n_lice_pari_zaplashtane group by id_lice) w4 on w4.id_lice = l.id
      ORDER BY s.sik, l.Code_rolia;
      
  SET @row_number = 0;
  SELECT (@row_number:=@row_number + 1) AS Id  
          ,nmizbrajon
          ,nmrajon
          ,t1.orders,t1.birthyear,t2.t
          ,t1.col1,t1.col2, t1.col3, t1.col4, t1.col5, t1.col6
          ,t2.s01, t2.s02, t2.s03, t2.s04, t2.s05, t2.s06, t2.s07, t2.s08, t2.s09, t2.s10
          ,t2.s as s
     FROM tblpart1 t1 
            inner join tblpart2 t2  on t1.id = t2.id
     ORDER BY t1.orders, t1.col2, t1.Code_rolia, t1.id;
    
  DROP TEMPORARY TABLE tblvalues;
  DROP TEMPORARY TABLE tblpart1;
  DROP TEMPORARY TABLE tblpart2;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_4_1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_4_1`(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)  
  ,prmType    tinyint
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_4_1',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);


  DROP TEMPORARY TABLE if exists tblizbr; 

  CREATE TEMPORARY TABLE if not exists tblizbr (toa varchar(2), toaname varchar(45), izb_rajon varchar(2), name varchar(45));
    
  DROP TEMPORARY TABLE if exists tblvalues; 
  
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, toa varchar(2));

  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT id_sek, toa 
            FROM siks s
              inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
              inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
            WHERE Izb_Alias = @v_izbalias
              AND TUR = @v_tur
              AND TOA = prmToa
              AND status_sekcia = 1;               
              
      INSERT INTO tblizbr
        SELECT w.nkod, w.nime, w2.nkod, w2. nime
          FROM wntoa w 
              inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
              inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias
          WHERE w.nkod = prmTOA;
          
  ELSE
   CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
        nkod varchar(2),
        name varchar(45)
    );

    IF prmIZB_R = '00' THEN
       INSERT INTO tblizbr
          SELECT w.nkod, w.nime, w2.nkod, w2. nime
            FROM wntoa w 
                inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
                inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias
            WHERE w2.status = 1;
            
    ELSE
       INSERT INTO tblizbr
          SELECT w.nkod, w.nime, w2.nkod, w2. nime
            FROM wntoa w 
                inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
                inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias
            WHERE w2.nkod = prmIZB_R
              AND w2.status = 1;

    END IF;    
  
    INSERT INTO tblvalues           
       SELECT s.id_sek, s.toa
       FROM tblizbr t
            INNER JOIN siks s 
                ON s.TOA = t.toa 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
                    AND s.status_sekcia = 1
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1;

  END IF;
  
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
    SELECT x.TOA
          , x.id_sila
          , sum(k.sik_clenove) kvotatotmem
          , totmem
          , sum(if(k.Code_rolia<404,k.sik_clenove,0)) kvotaheadmem
          , headmem
      FROM (select t.TOA, i.id_sila
                  , count(i.id) totmem
                  , sum(if(i.Code_rolia<404,1,0)) headmem
               from tblvalues t 
                      inner join n_lica_izbori i on i.id_sik = t.Id
               GROUP BY t.TOA, i.id_sila) x
            left join n_top_partkvoti k on k.toa = x.toa and k.code_wnsila = x.id_sila
      group by x.TOA, x.ID_sila;


  SET @row_number = 0;

  IF prmType = 1 THEN
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,x.name as nmizbrajon
              , x.toaname as nmrajon
              , x.wnsilaname as wnsila
              , ifnull(z.kvotatotmem,0) as col1
              , ifnull(z.totmem,0) as col2
              , ifnull(z.totmem,0)-ifnull(z.kvotatotmem,0) as col3
              , ifnull(z.kvotaheadmem,0) as col4
              , ifnull(z.headmem,0) as col5
              ,ifnull(z.headmem,0)-ifnull(z.kvotaheadmem,0) as col6
         FROM(SELECT t.izb_rajon, t.toa, w.ID_Party, t.name, t.toaname, w.nime as wnsilaname, w.nkod as wnsilakod
                FROM tblizbr t cross join  wnsila w
                WHERE w.Status_Partii = 1 ) x
              left join tmptable z on z.toa = x.toa and z.id_sila = x.id_party            
         ORDER BY x.izb_rajon,x.toa,x.wnsilakod;
  ELSE
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,x.name as nmizbrajon
              , '' as nmrajon
              , x.wnsilaname as wnsila
              , SUM(ifnull(z.kvotatotmem,0)) as col1
              , SUM(ifnull(z.totmem,0)) as col2
              , SUM(ifnull(z.totmem,0)-ifnull(z.kvotatotmem,0)) as col3
              , SUM(ifnull(z.kvotaheadmem,0)) as col4
              , SUM(ifnull(z.headmem,0)) as col5
              , SUM(ifnull(z.headmem,0)-ifnull(z.kvotaheadmem,0)) as col6
         FROM(SELECT t.izb_rajon, t.toa, w.ID_Party, t.name, w.nime as wnsilaname, w.nkod as wnsilakod
                FROM tblizbr t cross join  wnsila w
                WHERE w.Status_Partii = 1) x                
              left join tmptable z on z.toa = x.toa and z.id_sila = x.id_party
         GROUP BY x.izb_rajon,x.wnsilakod 
         ORDER BY x.izb_rajon,x.wnsilakod;  
  END IF;
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tblizbr;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_4_3
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_4_3`(
  prmTOA     varchar(2)  
  ,prmSila    int
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_4_3',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

    
  DROP TEMPORARY TABLE if exists tblvalues; 
  
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, toa varchar(2), sik varchar(3));

  INSERT INTO tblvalues 
      SELECT id_sek, toa, sik 
        FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
        WHERE s.Izb_Alias = @v_izbalias
          AND s.TUR = @v_tur
          AND s.TOA = prmToa
          AND s.status_sekcia = 1;               
                
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
  SELECT i.id_sik,i.id_sila, t.sik
        , count(i.id) totmem
        , sum(if(i.Code_rolia=401,1,0)) rol401
        , sum(if(i.Code_rolia=402,1,0)) rol402
        , sum(if(i.Code_rolia=403,1,0)) rol403
        , sum(if(i.Code_rolia=404,1,0)) rol404
     from tblvalues t 
            inner join n_lica_izbori i on i.id_sik = t.Id
     WHERE i.Code_rolia < 410       
     GROUP BY i.id_sik, i.id_sila;

 SELECT w1.nime 
    INTO @nmizbrajon
    FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.nkod = w2.Izb_r and w2.nkod = prmTOA
    WHERE w1.status = 1;
    
  SELECT w2.nime 
    INTO @nmrajon
    FROM wntoa w2 
    WHERE w2.NKOD = prmTOA;
    
  SET @row_number = 0;

  IF prmSila = 0 THEN
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,@nmizbrajon as nmizbrajon
              , @nmrajon as nmrajon
              , w.nime as wnsila
              , ifnull(z.SIK,'')   as siknumb
              , ifnull(z.totmem,0) as col1
              , ifnull(z.rol401,0) as col2
              , ifnull(z.rol402,0) as col3
              , ifnull(z.rol403,0) as col4
              , ifnull(z.rol404,0) as col5
         FROM wnsila w left join tmptable z on w.id_PArty = z.id_sila
         WHERE w.Status_Partii = 1 
         ORDER BY w.id_PArty,z.sik;
  ELSE
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,@nmizbrajon as nmizbrajon
              , @nmrajon as nmrajon
              , w.nime as wnsila
              , ifnull(z.SIK,'')   as siknumb
              , ifnull(z.totmem,0) as col1
              , ifnull(z.rol401,0) as col2
              , ifnull(z.rol402,0) as col3
              , ifnull(z.rol403,0) as col4
              , ifnull(z.rol404,0) as col5
         FROM wnsila w cross join tmptable z
         WHERE w.id_Party = prmSila
         ORDER BY z.sik;
         
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tmptable;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_9_1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_9_1`( 
  prmToa    varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_9_1',prmToa,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  select count(id_sek)
    into @v_cntsik
    from siks s 
    where s.Izb_Alias = @v_izbalias
      AND s.TUR = @v_tur
      AND s.toa = prmToa
      AND convert(s.sik, unsigned integer)>0
      and s.Status_Sekcia=1;
  
  select count(i.id)
         ,sum(IF(i.code_rolia=401,1,0))
         ,sum(IF(i.code_rolia=402,1,0))
         ,sum(IF(i.code_rolia=403,1,0))
         ,sum(IF(i.code_rolia=404,1,0))
         ,sum(IF(i.code_rolia>409,1,0))
    into @v_cntlica, @v_cnt401, @v_cnt402, @v_cnt403, @v_cnt404, @v_others
    from n_lica_izbori i 
            inner join siks s 
            on i.id_sik = s.id_sek 
                  AND s.Izb_Alias = @v_izbalias
                  AND s.TUR = @v_tur
                  AND s.toa = prmToa
                  AND convert(s.sik, unsigned integer)>0
                  and s.Status_Sekcia=1;
  
  IF EXISTS (SELECT 1
                FROM siks s
                 where  s.Izb_Alias = @v_izbalias
                    AND s.TUR = @v_tur
                    AND s.toa = prmToa
                    AND convert(s.sik, unsigned integer)>0
                    and s.Status_Sekcia=1) THEN
      SET @row_number = 0;

      SELECT (@row_number := @row_number + 1) AS Id 
            ,'Секции' as n1
            ,IFNULL(@v_cntsik,0) as c1
            ,'Лица' as n2
            ,IFNULL(@v_cntlica,0) as c2
            ,MAX(IF(NKODE = 401,NIME,'')) as n3
            , IFNULL(@v_cnt401,0) as c3
            ,MAX(IF(NKODE = 402,NIME,'')) as n4
            , IFNULL(@v_cnt402,0) as c4
            ,MAX(IF(NKODE = 403,NIME,'')) as n5
            , IFNULL(@v_cnt403,0) as c5
            ,MAX(IF(NKODE = 404,NIME,'')) as n6
            , IFNULL(@v_cnt404,0) as c6
            ,MAX(IF(NKODE > 409,'Други','')) as n7
            , IFNULL(@v_others,0) as c7
        FROM siks s
              inner join n_lica_izbori i on i.id_sik = s.id_sek
              inner join n_list_codepositions c on c.nkode = i.code_rolia and c.PKODE = 4
         where  s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.toa = prmToa
            AND convert(s.sik, unsigned integer)>0
            and s.Status_Sekcia=1;
  ELSE
      SELECT 1 AS Id 
            ,'Секции' as n1
            ,0 as c1
            ,'Лица' as n2
            ,0 as c2
            ,' ' as n3
            ,0.0 as c3
            ,' ' as n4
            ,0.0 as c4
            ,' ' as n5
            ,0.0 as c5
            ,' ' as n6
            ,0.0 as c6
            ,' ' as n7
            ,0.0 as c7;
  END IF;
  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_9_2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_9_2`(
  prmIZB_R      varchar(2)
  ,prmToa       varchar(2)
  ,prmDate1     datetime
  ,prmDate2     datetime
  ,prmUSER      varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID = 1;
   
  DROP TEMPORARY TABLE if exists tblizbr; 
   
  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  IF IFNULL(prmToa,'00') <> '00' THEN
    INSERT INTO tblizbr
        SELECT w2.nkod, w1.nime
          FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
          WHERE w2.NKOD = prmToa;    
  ELSE
    IF prmIZB_R = '00' THEN
      INSERT INTO tblizbr
          SELECT w2.nkod, w1.nime
            FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
            WHERE w1.IZB_ALIAS = @v_izbalias
              AND w1.STATUS=1;
    ELSE
        INSERT INTO tblizbr
            SELECT w2.nkod, w1.nime
                FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
                WHERE w1.IZB_ALIAS = @v_izbalias
                  AND w1.NKOD = prmIZB_R
                  AND w1.STATUS=1;
    END IF;     
  END IF;
  
  SET @row_number = 0;

  SELECT 
       (@row_number:=@row_number + 1) AS Id 
        ,t.name as NmIzbRajon
        ,w3.NIME as NmRajon
      	,Koga
        ,USER
      	,TOA
      	,SIK
      	,Kod_Obrabotka as KodObr
      	,Kod_Tekst  as KodText
      	,Pole_Bilo  as OldVal
      	,Pole_Stava as NewVal
   FROM tblizbr t 
        inner join wntoa w3 on w3.NKOD = t.NKOD
        inner join n_log_sik_istoria l on l.TOA = w3.NKOD
   WHERE DATE(l.Koga) between prmDate1 and prmDate2    
   ORDER BY t.name, w3.nkod;  
 END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_9_3
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spravka_9_3`( 
  prmToa      varchar(2)
  ,prmCode    int
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_9_3',prmToa,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
   
  DROP TEMPORARY TABLE if exists tblvalues; 
  
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, toa varchar(2), sik varchar(3));

  INSERT INTO tblvalues 
      SELECT id_sek, toa, sik 
        FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
        WHERE s.Izb_Alias = @v_izbalias
          AND s.TUR = @v_tur
          AND s.TOA = prmToa
          AND s.status_sekcia = 1;               
                  
  select ifnull(count(i.Code_rolia),0) members 
    into @total
    from tblvalues t inner join n_lica_izbori i on t.id = i.id_sik    
    WHERE i.Code_rolia = if(prmCode=0,i.Code_rolia,prmCode) 
      AND i.Code_rolia < 410;
    
  SET @row_number = 0;
  SELECT (@row_number:=@row_number + 1) AS Id  
        , IFNULL(w.Short_name,w.nkod) as col1
        , w.nime as col2
        , ifnull(count(n.Code_rolia),0) as col3
        , ifnull(round((count(n.Code_rolia)/@total)*100,2),0)  as col4
    from wnsila w 
          left join (select i.id_sila, i.Code_rolia 
                       from tblvalues t 
                              inner join n_lica_izbori i 
                              on t.id = i.id_sik
                                and i.Code_rolia = if(prmCode=0,i.Code_rolia,prmCode) 
                                AND i.Code_rolia < 410) n                               
          on n.id_sila = w.ID_Party  
    where w.izb_alias = @v_izbalias 
      and w.Status_Partii=1           
    group by w.ID_Party;  
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_filter_lica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_filter_lica`(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(128)
  ,prmOper    int
  ,prmSik     varchar(3)
  ,prmFilter  varchar(30)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
  ,prmTUR     int
  ,prmGlobal  int  
)
BEGIN
  SET NAMES 'utf8';
  
  IF prmTUR > 0 THEN
     SET @v_tur = prmTUR;
  ELSE
    SELECT VALUE
      INTO @v_tur 
      FROM sys_main
      WHERE ID =2;
  END IF;
  
  SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID =1;

  IF length(prmSik) > 0 THEN
    INSERT INTO tblvalues 
        SELECT i.id
          FROM n_lica_izbori i 
               inner join siks s on i.id_sik = s.id_sek
          WHERE s.sik = prmSik;
  ELSE
    INSERT INTO tblvalues 
        SELECT i.id
          FROM n_lica_izbori i 
                inner join siks s on i.id_sik = s.id_sek
                 inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                 inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.TOA = IF(prmGlobal=1,s.TOA,prmToa)
            AND s.status_sekcia = 1;
  END IF;
  
  IF prmIdRolja > 0 THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE Code_rolia=prmIdRolja);
  END IF;
  
  IF prmIdSila > 0 THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE id_sila = prmIdSila);
  END IF;

  IF LENGTH(prmRe) > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE re = prmRe);
  END IF;

  IF prmOper > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT i.id 
                              FROM n_lica_izbori i inner join n_lica_dopylnenie d on i.id = d.Id_Lice and d.VidCodetable=3 
                              WHERE d.Idcodeposition = prmOper);
  END IF;

  IF LENGTH(prmFilter) > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT i.id
                              FROM n_lica l inner join n_lica_izbori i on l.id = i.ID_Lice
                              WHERE (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0));
  END IF;                                      
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_MORS
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_MORS`(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE lica_fullname, lica_egn  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description,n_toa_main_bul  varchar(100) default '' collate utf8_unicode_ci; 
  DECLARE n_top_main_datetur datetime;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 
  DECLARE v_id int;
  
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
       
 SELECT CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,s.AA_BB_CC
         ,s.TOA
         ,i.id
    INTO lica_fullname, lica_egn,siks_fullcode,v_toa, v_id                      
    FROM n_lica_izbori i 
          inner join n_lica l on l.id = i.id_lice
          inner join siks s on s.id_sek = i.id_sik
    WHERE i.ID_lice = prmIdLice
      AND i.izb_alias = @v_izbalias
      AND i.TUR =  prmTur;
      
  SELECT Description, if(prmTur = 2, DATE2TUR, DATE1TUR)
    INTO n_top_main_description, n_top_main_datetur
    FROM n_top_main
    WHERE IZB_ALIAS = @v_izbalias
      AND Status_parameters = 1;
            
  SELECT BUL
    INTO n_toa_main_bul
    FROM n_toa_main
    WHERE IZB_ALIAS = @v_izbalias
      AND TOA =v_toa 
      AND TUR = prmTur;

  SELECT SUM(pari)
    INTO @suma
  FROM  n_lice_pari_zaplashtane
  WHERE ID_Lice = v_id;
  

  CALL createLog(prmUSER,3,'Касов ордер',lica_fullname,v_toa,'');

  SELECT wntoa.nime as izr_rajon
         ,n_toa_main_bul as n_toa_main_bul
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,n_top_main_description as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y') as n_top_main_datetur
         ,siks_fullcode as siks_fullcode
         ,ifnull(ROUND(@suma,2),0) as suma
         ,fnSlovom(IFNULL(ROUND(@suma,2),0)) as slovom
    FROM wntoa
    WHERE NKOD = v_toa;          
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_MSB1
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_MSB1`(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia varchar(100) default  ''  collate utf8_unicode_ci;
  DECLARE siks_fullcode, siks_nas, siks_kmet, siks_toa  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description, n_toa_main_epod, v_toa  varchar(100) default  ''; 
  DECLARE n_top_main_datetur datetime;

  SET NAMES 'utf8';

  SELECT VALUE
     INTO @v_izbalias
     FROM sys_main
     WHERE ID = 1;
       
  SELECT CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,w0.NIME
         ,c.NIME 
         ,s.AA_BB_CC
         ,w1.nime
         ,w2.nime
         ,w3.NIME
         ,s.TOA
    INTO  lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia
          ,siks_fullcode, siks_nas, siks_kmet, siks_toa,v_toa                      
    FROM n_lica_izbori i 
          inner join n_lica l on l.id = i.id_lice
          inner join siks s on s.id_sek = i.id_sik
          inner join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
          left join wndocs w0 on w0.nkod = i.re
          left join wnasm w1 on w1.nkod = s.NAS
          left join wnkmetstva w2 on w1.Kmetstvo = w2.nkod 
          left join wntoa w3 on w3.nkod = s.TOA
    WHERE i.ID_lice = prmIdLice
      AND i.izb_alias = @v_izbalias
      AND i.TUR = prmTur;
    
  SELECT Description, if(prmTur = 2, DATE2TUR, DATE1TUR)
    INTO n_top_main_description, n_top_main_datetur
    FROM n_top_main
    WHERE IZB_ALIAS = @v_izbalias
      AND Status_parameters = 1;
            
  SELECT EPOD
    INTO @n_toa_main_epod
    FROM n_toa_main
    WHERE IZB_ALIAS = @v_izbalias
      AND TOA = v_toa 
      AND TUR = prmTur;

  CALL createLog(prmUSER,3,'Служебна бележка',lica_fullname,v_toa,'');

  SELECT wntoa.NIME as izr_rajon
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,IFNULL(lica_izbori_re,' ') as lica_izbori_re
         ,lica_izbori_rolia as lica_izbori_rolia
         ,siks_fullcode as siks_fullcode
         ,IFNULL(siks_nas,' ') as siks_nas
         ,IFNULL(siks_kmet,' ') as siks_kmet
         ,IFNULL(siks_toa,' ') as siks_toa
         ,n_top_main_description  collate utf8_unicode_ci as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y')  collate utf8_unicode_ci as n_top_main_datetur
         ,IFNULL(n_toa_main_epod,' ')  collate utf8_unicode_ci as n_toa_main_epod
    FROM wntoa
    WHERE NKOD = v_toa; 
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_MSBDECL
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_MSBDECL`(
  prmIdLice   int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE lica_fullname, lica_izbori_rolia, lica_egn  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 

  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
          
  SELECT s.AA_BB_CC 
         ,c.NIME 
         ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,s.TOA
    INTO  siks_fullcode,lica_izbori_rolia, lica_fullname, lica_egn, v_toa                      
    FROM n_lica l 
          inner join n_lica_izbori i on l.id = i.id_lice
          inner join siks s on i.id_sik = s.id_sek
          inner join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
    WHERE l.ID = prmIdLice
     and i.TUR = @v_tur;
    
  SELECT coef_stoinost
    INTO @par_dc_20
    FROM n_top_dancoef
    WHERE IZB_ALLIAS = @v_izbalias
      AND nred = '20';
    
  CALL createLog(prmUSER,3,'Декларация за осигурителен доход',lica_fullname,v_toa,'');

  SELECT siks_fullcode as siks_fullcode
         ,lica_izbori_rolia as lica_izbori_rolia                 
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,ROUND(@par_dc_20,2) as par_dc_20;

END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_MUDO
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_MUDO`(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode, siks_nas, siks_kmet, siks_toa  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description,n_toa_main_bul  varchar(100) default '' collate utf8_unicode_ci; 
  DECLARE n_top_main_datetur datetime;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 
  DECLARE v_idsek, v_udocnom, v_id, v_code_rolia int;

  SET NAMES 'utf8';

  SELECT VALUE
     INTO @v_izbalias
     FROM sys_main
     WHERE ID = 1;
 
  SELECT koga
      INTO @v_koga              
      FROM n_lica
      WHERE ID = prmIdLice;
                             
  SELECT CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,w0.NIME
         ,c.NIME 
         ,s.AA_BB_CC
         ,w1.nime
         ,w2.nime
         ,w3.NIME
         ,s.TOA
         ,s.id_sek
         ,i.id
         ,i.Code_rolia
    INTO  lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia
          ,siks_fullcode, siks_nas, siks_kmet, siks_toa
          ,v_toa, v_idsek, v_id, v_code_rolia                      
    FROM n_lica_izbori i 
          inner join n_lica l on l.id = i.id_lice
          inner join siks s on s.id_sek = i.id_sik
          inner join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
          left join wndocs w0 on w0.nkod = i.re
          left join wnasm w1 on w1.nkod = s.NAS
          left join wnkmetstva w2 on w1.Kmetstvo = w2.nkod 
          left join wntoa w3 on w3.nkod = s.TOA
    WHERE i.ID_lice = prmIdLice
      AND i.izb_alias = @v_izbalias
      AND i.TUR = prmTur;
      
  SELECT Description, if(prmTur = 2, DATE2TUR, DATE1TUR)
      INTO n_top_main_description, n_top_main_datetur
      FROM n_top_main
      WHERE IZB_ALIAS = @v_izbalias
        AND Status_parameters = 1;
    
                  
    IF  v_code_rolia >= 404 THEN
      SELECT (v_code_rolia-400-1)+order_
          INTO v_udocnom
          FROM (SELECT ID, @rownum := @rownum + 1 AS order_
                  FROM n_lica_izbori, (SELECT @rownum :=0) t 
                  WHERE id_sik = v_idsek
                    AND izb_alias = @v_izbalias
                    AND TUR = prmTur
                    AND Code_rolia = v_code_rolia
                  ORDER BY id) x
          WHERE ID = v_id;            
    ELSE  
        SET v_udocnom := (v_code_rolia-400);
    END IF;
    
  

  CALL createLog(prmUSER,3
                ,CONCAT('Удостоверение №',siks_fullcode,'-',TRIM(CAST(v_udocnom as CHAR(10))),'/',DATE_FORMAT(NOW(), '%d.%m.%Y г.'))
                ,lica_fullname
                ,v_toa,'');

  SELECT (SELECT NIME 
            FROM wnizbraion 
            WHERE NKOD = fnGetIzborenRajon(@v_izbalias,v_toa)
              AND IZB_ALIAS =@v_izbalias ) as izr_rajon
         ,CONCAT(siks_fullcode,'-',TRIM(CAST(v_udocnom as CHAR(10))),'/',DATE_FORMAT(NOW(), '%d.%m.%Y г.')) as udocnom
         ,IFNULL(lica_izbori_re,'') as lica_izbori_re
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,lica_izbori_rolia as lica_izbori_rolia
         ,siks_fullcode as siks_fullcode
         ,IFNULL(siks_nas,' ') as siks_nas
         ,IFNULL(siks_kmet,' ') as siks_kmet
         ,IFNULL(siks_toa,' ') as siks_toa
         ,n_top_main_description as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y') as n_top_main_datetur;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.spravka_select_lica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `spravka_select_lica`(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(128)
  ,prmOper    int
  ,prmSik     varchar(3)
  ,prmFilter  varchar(30)
  ,prmUSER    varchar(128)
  ,prmTip     int
  ,prmDummy   varchar(30)
  ,prmTUR     int
  ,prmGlobal  int
)
BEGIN
  SET NAMES 'utf8';

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF prmTUR > 0 THEN
     SET @v_tur = prmTUR;
  ELSE
    SELECT VALUE
      INTO @v_tur 
      FROM sys_main
      WHERE ID =2;
  END IF;
  
  CALL spravka_filter_lica(
            prmTOA
            ,prmIdRolja
            ,prmIdSila
            ,prmRe    
            ,prmOper  
            ,prmSik   
            ,prmFilter
            ,prmUSER  
            ,prmDummy
            ,@v_tur
            ,prmGlobal
  );

  SELECT s.AA_BB_CC as SIK
        ,lc.ID
        ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.NIME as dlyzjnost
        ,w.NIME as partia
        ,lc.tel as telefon
        ,ifnull(x.nime,'') as Deistvie
        ,ifnull(w1.nime,'') as Reshenie
        ,@v_tur as Tur
     FROM tblvalues t
          inner join n_lica_izbori i on i.id = t.id
          INNER JOIN siks s ON s.id_sek = i.id_sik
          inner join n_lica lc on lc.Id = i.id_lice
          inner join n_list_codepositions p on p.NKODE = i.Code_rolia and p.PKODE=4
          left join wnsila w on w.id_party = i.id_sila
          left join (SELECT d.Id_Lice, GROUP_CONCAT(p1.NIME SEPARATOR ', ') as nime
                       FROM n_lica_dopylnenie d 
                              inner join n_list_codepositions p1 
                              on d.idcodeposition = p1.nkode and d.vidcodetable = p1.pkode
                       WHERE d.VidCodetable=3
                       GROUP BY d.Id_Lice) x
            on t.id = x.Id_Lice
           
          left join wndocs w1 on w1.nkod = i.re  
    WHERE i.Code_rolia < IF(prmTip=0,999,410)
    ORDER BY s.AA_BB_CC, p.nkode;

  DROP TEMPORARY TABLE tblvalues;
                                     
END//
DELIMITER ;

-- Дъмп структура за таблица votingregister.sys_main
CREATE TABLE IF NOT EXISTS `sys_main` (
  `Id` int(11) NOT NULL,
  `Name` longtext CHARACTER SET latin1 COMMENT 'Поле FINANCE => Райони направили фин. изчисл.',
  `Value` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.sys_main: ~6 rows (приблизително)
DELETE FROM `sys_main`;
/*!40000 ALTER TABLE `sys_main` DISABLE KEYS */;
INSERT INTO `sys_main` (`Id`, `Name`, `Value`) VALUES
	(1, 'IZBALIAS', 'PR2021'),
	(2, 'TUR', '2'),
	(3, 'DB', 'ТЕСТ'),
	(4, 'TUR2KOGA', '1577708865'),
	(6, 'FINANCE', '19');
/*!40000 ALTER TABLE `sys_main` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.sys_toamain
CREATE TABLE IF NOT EXISTS `sys_toamain` (
  `Izb_alias` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `Tur` int(11) NOT NULL,
  `Toa` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `IdSek` int(11) NOT NULL,
  `Name` longtext COLLATE utf8_unicode_ci,
  `Value` int(11) DEFAULT NULL,
  PRIMARY KEY (`Izb_alias`,`Toa`,`IdSek`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Номерация на удостоверения';

-- Дъмп данни за таблица votingregister.sys_toamain: ~0 rows (приблизително)
DELETE FROM `sys_toamain`;
/*!40000 ALTER TABLE `sys_toamain` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_toamain` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.sys_usermain
CREATE TABLE IF NOT EXISTS `sys_usermain` (
  `User` longtext COLLATE utf8_unicode_ci,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext COLLATE utf8_unicode_ci,
  `Value` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.sys_usermain: ~21 rows (приблизително)
DELETE FROM `sys_usermain`;
/*!40000 ALTER TABLE `sys_usermain` DISABLE KEYS */;
INSERT INTO `sys_usermain` (`User`, `Id`, `Name`, `Value`) VALUES
	('0d7bc87d-69bb-4b6d-a0bb-7f64eeb05ccf', 167, 'TOA', '01'),
	('305ac9e7-8a94-43d3-9233-040d21c6dbc9', 168, 'TOA', '01'),
	('3c64a971-e74f-4ce8-910a-5cf3a84212e9', 169, 'TOA', '01'),
	('3d391af3-d54b-438a-a4f8-3b36b4bb1f3f', 170, 'TOA', '01'),
	('78752568-4ac7-4809-8eab-491a00c3bb9c', 172, 'TOA', '02'),
	('7b33da3b-8347-47cc-b7c5-7f4340d81bce', 173, 'TOA', '19'),
	('a4905182-408b-4afd-850c-ffe46d0157b7', 174, 'TOA', '02'),
	('c5fdb7ed-ab63-47b1-bf76-b67847378bbc', 175, 'TOA', '01'),
	('e4a646df-ea45-4501-94cd-b9766bcc77c6', 176, 'TOA', '01'),
	('edd2e70d-b73b-4bd9-a75c-748ed81b464b', 177, 'TOA', '01'),
	('f1b51a37-1200-43be-bd17-2a9926e07e5e', 178, 'TOA', '01'),
	('f7ab7308-5809-41eb-a587-c926412631f7', 179, 'TOA', '01'),
	('600651e3-c3c8-433a-8b19-36785eb562fa', 180, 'TOA', '01'),
	('7780fe39-6cf5-4955-82d8-9226050679f0', 181, 'TOA', '01'),
	('881d7629-e62b-4142-981f-aac7016f538d', 182, 'TOA', '02'),
	('2af4ccff-d3ae-43f8-8faa-5f4f22a2ce1f', 183, 'TOA', '03'),
	('530f5e77-5371-45a4-9dd2-9e08395bcf57', 184, 'TOA', '07'),
	('46e85934-8386-46ed-9b14-bb77ca5694d6', 185, 'TOA', '12'),
	('987577a2-5ca1-4cad-bae0-df58a3598cbb', 186, 'TOA', '19'),
	('28a78b41-8cb0-41ed-aaab-3996de19f747', 187, 'TOA', '23'),
	('0264cf8d-1437-405e-981b-e4c161b91e0a', 188, 'TOA', '24');
/*!40000 ALTER TABLE `sys_usermain` ENABLE KEYS */;

-- Дъмп структура за процедура votingregister.updateLica
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `updateLica`(
   prmID      int
  ,prmVid_id  int
  ,prmEGN     varchar(128)
  ,prmIM1     varchar(128)
  ,prmIM2     varchar(128)
  ,prmIM3     varchar(128)
  ,prmObra    varchar(16)
  ,prmSpec    varchar(16)
  ,prmTEL     varchar(14) 
  ,prmPAS1    varchar(1)
  ,prmPAS2    varchar(10)
  ,prmPAS3    datetime
  ,prmPAS4    varchar(2)
  ,prmNAZ     varchar(2)
  ,prmOBL     varchar(2)
  ,prmOBS     varchar(4)
  ,prmRAJ     varchar(2)
  ,prmNAS     varchar(5)
  ,prmULKOD   varchar(5)
  ,prmNOM     varchar(6)
  ,prmJK_KV   varchar(2)
  ,prmBLOK    varchar(5)
  ,prmVH      varchar(2)
  ,prmET      varchar(2)
  ,prmAP      varchar(3)
  ,prmPK      varchar(4)
  ,prmimpstatus   int
  ,prmimpmessage  varchar(100)
  ,prmUSER      varchar(128) 
  ,prmToa       varchar(2)
  ,prmDummy     varchar(30)
)
BEGIN
    DECLARE prmIME      varchar(250);

    SET NAMES 'utf8';

    IF NOT EXISTS(SELECT 1 
                    FROM n_lica l 
                          inner join n_lica_izbori i on l.ID = i.id_lice
                          inner join siks s on i.ID_sik = s.id_sek                    
                    WHERE l.VID_ID =  prmVid_id 
                      AND l.EGN = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
                      and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
                      AND i.ID  <> prmID                      
                   )
    THEN                      

        UPDATE n_lica 
          SET  Vid_id  = prmVid_id
              ,EGN    = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
              ,IM1    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy))
              ,IM2    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy))
              ,IM3    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy))
              ,Obra   = prmObra
              ,Spec   = prmSpec
              ,TEL    = prmTEL
              ,PAS1   = prmPAS1
              ,PAS2   = prmPAS2
              ,PAS3   = prmPAS3
              ,PAS4   = prmPAS4
              ,NAZ    = prmNAZ
              ,OBL    = prmOBL
              ,OBS    = prmOBS
              ,RAJ    = prmRAJ
              ,NAS    = prmNAS
              ,UL     = prmULKOD
              ,NOM    = prmNOM
              ,JK_KV  = prmJK_KV
              ,BLOK   = prmBLOK
              ,VH     = prmVH
              ,ET     = prmET
              ,AP     = prmAP
              ,PK     = prmPK
              ,impstatus  = prmimpstatus
              ,impmessage = prmimpmessage
              ,USER   = prmUSER
              ,KOGA   = now()
          WHERE ID = prmID;
      
       SET prmIME =  CONCAT(TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy)),' ',
                           IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy)),''),' ',
                           IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy)),''));

       call createLog (prmUSER, 1,'Редактиране',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');      
       SELECT prmID as ID FROM DUAL;
    ELSE
       SELECT -1 as ID FROM DUAL;
    END IF;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.updateLicaDeinost
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `updateLicaDeinost`(
  prmIdLice          int
  ,prmDeinost        int
  ,prmAdd            int
  ,prmUSER           varchar(128)
  ,prmDummy     varchar(30)
)
BEGIN
   DECLARE prmIME varchar(100);
   
   SET NAMES 'utf8';
   
   SELECT cast(value as unsigned integer)
      INTO @v_tur
      FROM sys_main 
      WHERE ID = 2;
      
    
   SELECT i.ID , s.TOA
      INTO @v_id_lice_izbori, @v_toa
      FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.Id_sek 
      WHERE i.ID_LICE = prmIdLice
        AND s.TUR = @v_tur;        
        
   SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        INTO prmIME
        FROM n_lica
        WHERE ID = prmIdLice;
        
   SELECT NIME 
      INTO @v_name
      FROM n_list_codepositions
      WHERE PKODE = 3
        AND NKODE = prmDeinost;
      
   DELETE FROM n_lica_dopylnenie
      WHERE Id_Lice  = @v_id_lice_izbori
        AND VidCodetable = 3
        AND Idcodeposition = prmDeinost;
    
    
   IF prmAdd = 1 THEN
      INSERT INTO n_lica_dopylnenie (Id_Lice, VidCodetable, Idcodeposition, Status, User, Koga)
          VALUES (@v_id_lice_izbori, 3,prmDeinost,1,prmUSER, NOW());          

      call createLog (prmUSER, 4, @v_name,prmIME,@v_toa,'Да');   
   ELSE
      call createLog (prmUSER, 4, @v_name,prmIME,@v_toa,'Не');   
   END IF;
   
   
   SELECT prmIdLice as 'Id' FROM DUAL;    
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.updateLicaZamestvane
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `updateLicaZamestvane`(
  prmId           int
  ,prmIdLiceStaro int(11)
  ,prmUSER        varchar(128)
)
BEGIN
    SET NAMES 'utf8';
 
    SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR
      INTO @v_idsik, @v_IzbAlias, @v_toa, @v_tur
      FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
      WHERE i.id = prmIdLiceStaro;
      
    
    SELECT Id_sek 
      INTO @v_idnullsik
      FROM siks
      WHERE sik = '000'
        AND IZB_ALIAS  = @v_IzbAlias
        AND Toa = @v_Toa
        AND TUR = @v_TUR;  

    UPDATE n_lica_izbori
      SET Id_Sik = @v_idnullsik
      WHERE ID = prmIdLiceStaro;

    UPDATE n_lica_izbori_zamestvane 
        SET `Id_Lice_staro` = prmIdLiceStaro
            ,`USER` = prmUSER
            ,`KOGA` = now()
        WHERE ID = prmId;    
 
    SELECT prmId as 'Id' FROM DUAL;    
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.updateSik
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `updateSik`(
  prmID         int
  ,prmIzb_Alias  varchar(6)
  ,prmTUR       int
  ,prmIzb_rajon varchar(2)
  ,prmTOA       varchar(2)
  ,prmAA_BB_CC  varchar(6)
  ,prmSik       varchar(3)
  ,prmObl       varchar(3)
  ,prmObs       varchar(5)
  ,prmNAS       varchar(5)
  ,prmJK_KV     varchar(2)
  ,prmUL        varchar(5)
  ,prmNom       varchar(5)
  ,prmBLok      varchar(5)
  ,prmADR_IME   varchar(250)
  ,prmStatus_Sekcia int
  ,prmBroiMembers int  
  ,prmUSER      varchar(128)
)
BEGIN
    SET NAMES 'utf8';
    SET @v_izbrajon = IFNULL(fnGetIzborenRajon(prmIzb_Alias,prmTOA),'00');
    SET @v_fullSik = CONCAT(fnGetFullSikNumber(prmTOA),prmSik) collate utf8_unicode_ci;
    
    SELECT AA_BB_CC, Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,broimembers,Status_Sekcia
    INTO @v_AA_BB_CC, @v_Sik,@v_Obl,@v_Obs,@v_NAS,@v_JK_KV,@v_UL,@v_Nom,@v_BLok
        ,@v_ADR_IME,@v_broimembers,@v_Status_Sekcia
    FROM siks         
    WHERE Id_sek = prmID;
    
    SET @v_oldaddress = fnGetSikAddress(prmID);
    
    UPDATE siks 
      SET Izb_Alias   = prmIzb_Alias
      ,TUR            = prmTUR
      ,Izb_rajon      = @v_izbrajon 
      ,TOA            = prmTOA
      ,AA_BB_CC       = @v_fullSik
      ,Sik            = prmSik
      ,Obl            = prmObl
      ,Obs            = prmObs
      ,NAS            = prmNAS
      ,JK_KV          = prmJK_KV
      ,UL             = prmUL
      ,Nom            = prmNom
      ,BLok           = prmBLok
      ,ADR_IME        = prmADR_IME
      ,Status_Sekcia  = prmStatus_Sekcia
      ,USER           = prmUSER
      ,KOGA           = now()
      ,broimembers    = prmBroiMembers        
    WHERE Id_sek = prmID;
    
    SET @v_newaddress = fnGetSikAddress(prmID);

    IF @v_Status_Sekcia <> prmStatus_Sekcia THEN
      IF prmStatus_Sekcia = 1 THEN
        call createSikLog (prmUser, prmTOA, @v_FullSIK, 13, 'Активирана','','');
      ELSE
        call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 14, 'Деактивирана','','');
      END IF;  
    ELSE    
      IF  @v_oldaddress <> @v_newaddress THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 21
                            ,'Смяна в адрес',@v_oldaddress,@v_newaddress);
      END IF;
      
      IF  @v_ADR_IME <> prmADR_IME THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 22
                            ,'Смяна в описание',@v_ADR_IME,prmADR_IME);      
      END IF;
      
      IF  @v_broimembers <> prmBroiMembers THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 23
                            ,'Смяна брой членове в СИК', @v_broimembers ,prmBroiMembers);      
      END IF;
        
    END IF;
    
  	SELECT prmID as Id;
END//
DELIMITER ;

-- Дъмп структура за процедура votingregister.updateToaMain
DELIMITER //
CREATE DEFINER=`tbsoft2019`@`localhost` PROCEDURE `updateToaMain`(
  prmId             int
  ,prmIzb_Alias      varchar(6)
  ,prmTOA            varchar(2)
  ,prmTur            tinyint
  ,prmStatus_Master  int
  ,prmIME            varchar(30)
  ,prmTEL            varchar(10)
  ,prmTel1           varchar(10)
  ,prmIzr            varchar(15)
  ,prmOBL            varchar(3)
  ,prmOBS            varchar(5)
  ,prmRAJ            varchar(2)
  ,prmNAS            varchar(5)
  ,prmUL             varchar(5)
  ,prmNOM            varchar(4)
  ,prmJK_KV          varchar(2)
  ,prmBLOK           varchar(5)
  ,prmVH             varchar(2)
  ,prmET             varchar(2)
  ,prmAP             varchar(3)
  ,prmPK             varchar(4)
  ,prmEPOD           varchar(30)
  ,prmIPOD           varchar(20)
  ,prmPred           varchar(20)
  ,prmSekr           varchar(20)
  ,prmNsik           int
  ,prmPris           varchar(10)
  ,prmR1             varchar(20)
  ,prmR2             varchar(20)
  ,prmANO            int
  ,prmBul            varchar(13)
  ,prmUSER           varchar(128)
)
BEGIN
   SET NAMES 'utf8';
      
   SET @izbrajon =  fnGetIzborenRajon(prmIzb_Alias, prmToa);
   
   IF checkNumber (3,prmBul) = -1 THEN
     SET prmBul = '';
   END IF;  
   
   SELECT  NIME, PREFIX
      INTO @izbrajon_name, @izbrajon_predstavka
      FROM wnizbraion
      WHERE nkod =  @izbrajon
        AND IZB_ALIAS = prmIzb_Alias;
        
   UPDATE n_toa_main 
    SET `IZB_ALIAS` = prmIzb_Alias 
        ,`TOA`      = prmTOA
        ,`Tur`      = prmTur
        ,`Status_Master` = prmStatus_Master
        ,`IME`      = prmIME
        ,`TEL`      = prmTel
        ,`Tel1`     = prmTel1
        ,`Izr`      = prmIzr
        ,`OBL`      = prmObl
        ,`OBS`      = prmObs
        ,`RAJ`      = prmRaj
        ,`NAS`      = prmNas
        ,`UL`       = prmUl
        ,`NOM`      = prmNom
        ,`JK_KV`    = prmJK_KV
        ,`BLOK`     = prmBlok
        ,`VH`       = prmVH
        ,`ET`       = prmET
        ,`AP`       = prmAP
        ,`PK`       = prmPK
        ,`EPOD`     = prmEPOD
        ,`IPOD`     = prmIPOD
        ,`Pred`     = prmPred
        ,`Sekr`     = prmSekr
        ,`Nsik`     = prmNSIK
        ,`Pris`     = IFNULL(@izbrajon_predstavka,'0000')
        ,`R1`       = @izbrajon_name
        ,`R2`       = prmR2
        ,`ANO`      = prmANO
        ,`Bul`      = prmBul
    WHERE NREC = prmId;
    
    IF EXISTS (SELECT 1 FROM n_toa_main WHERE  NREC = prmId AND ANO <> prmANO) THEN
        UPDATE siks 
          SET broimembers =prmANO
          WHERE TOA = prmTOA;
    END IF;
    
    call createLog (prmUSER, 5,'Редактиране на Административен район',IFNULL(prmIME,''),IFNULL(prmToa,''),'');  
    SELECT prmId as 'Id' FROM DUAL;    
END//
DELIMITER ;

-- Дъмп структура за таблица votingregister.wnasm
CREATE TABLE IF NOT EXISTS `wnasm` (
  `nkod` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `nime` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Kmetstvo` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnasm: ~38 rows (приблизително)
DELETE FROM `wnasm`;
/*!40000 ALTER TABLE `wnasm` DISABLE KEYS */;
INSERT INTO `wnasm` (`nkod`, `nime`, `Kmetstvo`) VALUES
	('00357', 'гр.Нови Искър', 'SOF46-00'),
	('02511', 'с.Балша', 'SOF46-36'),
	('02659', 'гр.Банкя', 'SOF46-00'),
	('04234', 'с.Бистрица', 'SOF46-54'),
	('07106', 'с.Бусманци', 'SOF46-31'),
	('07140', 'гр.Бухово', 'SOF46-49'),
	('11394', 'с.Владая', 'SOF46-32'),
	('11884', 'с.Войнеговци', 'SOF46-37'),
	('12084', 'с.Волуяк', 'SOF46-35'),
	('14831', 'с.Герман', 'SOF46-55'),
	('16448', 'с.Горни Богров', 'SOF46-50'),
	('21662', 'с.Доброславци', 'SOF46-38'),
	('22304', 'с.Долни Богров', 'SOF46-51'),
	('22472', 'с.Долни Пасарел', 'SOF46-56'),
	('29150', 'с.Железница', 'SOF46-57'),
	('29204', 'с.Желява', 'SOF46-52'),
	('29430', 'с.Житен', 'SOF46-39'),
	('32216', 'с.Иваняне', 'SOF46-63'),
	('35239', 'с.Казичене', 'SOF46-58'),
	('37280', 'с.Клисура', 'SOF46-00'),
	('37914', 'с.Кокаляне', 'SOF46-59'),
	('39791', 'с.Кривина', 'SOF46-60'),
	('40436', 'с.Кубратово', 'SOF46-40'),
	('41010', 'с.Кътина', 'SOF46-41'),
	('44063', 'с.Лозен', 'SOF46-61'),
	('44224', 'с.Локорско', 'SOF46-42'),
	('46721', 'с.Мало Бучино', 'SOF46-34'),
	('48393', 'с.Мировяне', 'SOF46-43'),
	('49206', 'с.Мрамор', 'SOF46-44'),
	('49597', 'с.Мърчаево', 'SOF46-33'),
	('51250', 'с.Негован', 'SOF46-45'),
	('55419', 'с.Панчарево', 'SOF46-00'),
	('56624', 'с.Плана', 'SOF46-00'),
	('57011', 'с.Подгумер', 'SOF46-46'),
	('65601', 'с.Световрачене', 'SOF46-47'),
	('68134', 'гр.София', 'SOF46-00'),
	('80409', 'с.Чепинци', 'SOF46-48'),
	('87401', 'с.Яна', 'SOF46-53');
/*!40000 ALTER TABLE `wnasm` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wndocs
CREATE TABLE IF NOT EXISTS `wndocs` (
  `NKOD` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status_ndocs` tinyint(1) DEFAULT '1',
  `Izb_Alias` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wndocs: ~17 rows (приблизително)
DELETE FROM `wndocs`;
/*!40000 ALTER TABLE `wndocs` DISABLE KEYS */;
INSERT INTO `wndocs` (`NKOD`, `NIME`, `Status_ndocs`, `Izb_Alias`, `TOA`) VALUES
	('01', '№ 224604-МИ1 от 27.09.2019 г.', 1, 'PR2021', '03'),
	('02', '№ ........... от Протокол № .../ .....2019 г.', 1, 'PR2021', NULL),
	('1f1bafdc-e864-4de3-9856-34f498e7e9b2', 'PAN5-МИ/30.09.2019 г.', 1, 'PR2021', '23'),
	('201bda45-f592-47c0-9c2a-6910b676173d', '№777-МИ/22', 1, 'PR2021', '07'),
	('2df089c6-c6e1-41f7-9358-be3b625c8677', 'СРД15-МИ/2.10.2019 г.', 1, 'PR2021', '01'),
	('344ee08a-9b8b-412b-a35c-5c6452b1b2a1', '987', 1, 'PR2021', '19'),
	('41cbf6af-2440-436a-a7db-6ec077ffa455', 'К19-2019', 1, 'PR2021', '19'),
	('62696f08-388d-46bc-a0fe-c40e17e05e05', '707-МИ/27.09.2019 г.', 1, 'PR2021', '02'),
	('65d3138c-9206-4508-a4e5-eec0172a5bcd', '714-МИ/27.09.2019 г.', 1, 'PR2021', '01'),
	('68283754-54c6-436e-a6ab-b63c2f4cc9a7', '706-МИ/27.09.2019 г.', 1, 'PR2021', '23'),
	('7b0dc137-c984-4acd-94d5-55f3ae9dbf65', 'БАН19-Еми', 1, 'PR2021', '24'),
	('7fefa84d-6945-4f3f-9caf-1022502993b7', 'БАН19-МИ/1.10.2019 г.', 1, 'PR2021', '24'),
	('83832616-c399-4761-8454-2e3c7b392d4a', 'КРС-1-МИ/2.10.2019 г.', 1, 'PR2021', '02'),
	('99', 'Test', 1, 'PR2021', NULL),
	('ba7e103c-0f33-4fe4-9539-8b540de2a708', '№225-МИ/TEST', 1, 'PR2021', '01'),
	('bf77aa9c-26c1-4cd1-a703-d63f9aacbd08', 'LOZ-1560', 1, 'PR2021', '09'),
	('c2079894-6b38-455d-8832-9c3dd1a8eedf', '724-МИ/29.09.2019 г.', 1, 'PR2021', '24');
/*!40000 ALTER TABLE `wndocs` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnizbraion
CREATE TABLE IF NOT EXISTS `wnizbraion` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IZB_ALIAS` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PREFIX` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MIN_BROI_SIK` int(2) DEFAULT NULL,
  `MAX_BROI_SIK` int(2) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnizbraion: ~4 rows (приблизително)
DELETE FROM `wnizbraion`;
/*!40000 ALTER TABLE `wnizbraion` DISABLE KEYS */;
INSERT INTO `wnizbraion` (`ID`, `IZB_ALIAS`, `NKOD`, `NIME`, `PREFIX`, `MIN_BROI_SIK`, `MAX_BROI_SIK`, `status`) VALUES
	(4, 'PR2021', '22', '22-ри Район - София', '2246', 5, 7, 1),
	(7, 'PR2021', '23', '23-ти Район - София', '2346', 5, 7, 0),
	(8, 'PR2021', '24', '24-ти Район - София', '2446', 5, 7, 0),
	(9, 'PR2021', '25', '25-ти Район - София', '2546', 5, 7, 0);
/*!40000 ALTER TABLE `wnizbraion` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnjk_kv
CREATE TABLE IF NOT EXISTS `wnjk_kv` (
  `nkod` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `nime` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnjk_kv: ~141 rows (приблизително)
DELETE FROM `wnjk_kv`;
/*!40000 ALTER TABLE `wnjk_kv` DISABLE KEYS */;
INSERT INTO `wnjk_kv` (`nkod`, `nime`) VALUES
	('01', 'ж.к. БАНИШОРА'),
	('02', 'ж.к. БЕЛИТЕ БРЕЗИ'),
	('03', 'ж.к. БОРОВО'),
	('04', 'ж.к. БОТУНЕЦ'),
	('05', 'ж.к. БОТУНЕЦ 2'),
	('06', 'ж.к. БУХОВО'),
	('07', 'ж.к. БЪКСТОН'),
	('08', 'ж.к. ВОЕННИ ЖИЛИЩА'),
	('09', 'ж.к. ВРЪБНИЦА 1'),
	('10', 'ж.к. ВРЪБНИЦА 2'),
	('100', 'кв. ГОРНА БАНЯ'),
	('101', 'кв. ГОРУБЛЯНЕ'),
	('102', 'кв. ГРАДОМАН'),
	('103', 'кв. ДЖУРДЖА'),
	('104', 'кв. ДИМИТЪР МИЛЕНКОВ'),
	('105', 'кв. ДРАГАЛЕВЦИ'),
	('106', 'кв. ЗООПАРК'),
	('107', 'кв. ИЗГРЕВ 1'),
	('108', 'кв. ИЗГРЕВ 2'),
	('109', 'кв. ИЛИЯНЦИ'),
	('11', 'ж.к. ВРЪХ МАНЧО'),
	('110', 'кв. КАРПУЗИЦА'),
	('111', 'кв. КНЯЖЕВО'),
	('112', 'кв. КРЕМИКОВЦИ'),
	('113', 'кв. КРИВА РЕКА'),
	('114', 'кв. КРЪСТОВА ВАДА'),
	('115', 'кв. КУМАРИЦА'),
	('116', 'кв. КУРИЛО'),
	('117', 'кв. МАЛАШЕВЦИ'),
	('118', 'кв. МАЛИНОВА ДОЛИНА 2'),
	('119', 'кв. МАНАСТИРСКИ ЛИВАДИ'),
	('12', 'ж.к. ГЕВГЕЛИЙСКИ'),
	('120', 'кв. МЕЧТА'),
	('121', 'кв. МИХАЙЛОВО'),
	('122', 'кв. МОДЕРНО ПРЕДГРАДИЕ'),
	('123', 'кв. ОБЕЛЯ'),
	('124', 'кв. ОВЧА КУПЕЛ'),
	('125', 'кв. ОРЛАНДОВЦИ'),
	('126', 'кв. ПОДУЯНЕ'),
	('127', 'кв. ПОЛИГОНА'),
	('128', 'кв. РЕПУБЛИКА'),
	('129', 'кв. РЕПУБЛИКА 2'),
	('13', 'ж.к. ГЕО МИЛЕВ'),
	('130', 'кв. СВ. СТЕФАН'),
	('131', 'кв. СЕСЛАВЦИ'),
	('132', 'кв. СИМЕОНОВО'),
	('133', 'кв. СЛАВОВЦИ'),
	('134', 'кв. СУХОДОЛ'),
	('135', 'кв. ТРЕБИЧ'),
	('136', 'кв. ФАКУЛТЕТА'),
	('137', 'кв. ФИЛИПОВЦИ'),
	('138', 'кв. ХЛАДИЛНИКА'),
	('139', 'кв. ХРИСТО БОТЕВ'),
	('14', 'ж.к. ГОРУБЛЯНЕ'),
	('140', 'кв. ЧЕЛОПЕЧЕНЕ'),
	('141', 'кв. ШИПКА'),
	('15', 'ж.к. ГОЦЕ ДЕЛЧЕВ'),
	('16', 'ж.к. ДИАНАБАД'),
	('17', 'ж.к. ДРУЖБА 1'),
	('18', 'ж.к. ДРУЖБА 2'),
	('19', 'ж.к. ДЪРВЕНИЦА'),
	('20', 'ж.к. ЗАПАДЕН ПАРК'),
	('21', 'ж.к. ЗАХАРНА ФАБРИКА'),
	('22', 'ж.к. ЗОНА Б-18'),
	('23', 'ж.к. ЗОНА Б-19'),
	('24', 'ж.к. ЗОНА Б-5'),
	('25', 'ж.к. ЗОНА Б-5-3'),
	('26', 'ж.к. ИВАН ВАЗОВ'),
	('27', 'ж.к. ИЗГРЕВ'),
	('28', 'ж.к. ИЗТОК'),
	('29', 'ж.к. ИЛИНДЕН'),
	('30', 'ж.к. КРАСНА ПОЛЯНА 1'),
	('31', 'ж.к. КРАСНА ПОЛЯНА 2'),
	('32', 'ж.к. КРАСНА ПОЛЯНА 3'),
	('33', 'ж.к. КРАСНО СЕЛО'),
	('34', 'ж.к. КРЕМИКОВЦИ'),
	('35', 'ж.к. ЛАГЕРА'),
	('36', 'ж.к. ЛЕВ ТОЛСТОЙ'),
	('37', 'ж.к. ЛЕВСКИ В'),
	('38', 'ж.к. ЛЕВСКИ Г'),
	('39', 'ж.к. ЛОЗЕНЕЦ'),
	('40', 'ж.к. ЛЮЛИН 1'),
	('41', 'ж.к. ЛЮЛИН 10'),
	('42', 'ж.к. ЛЮЛИН 2'),
	('43', 'ж.к. ЛЮЛИН 3'),
	('44', 'ж.к. ЛЮЛИН 4'),
	('45', 'ж.к. ЛЮЛИН 5'),
	('46', 'ж.к. ЛЮЛИН 6'),
	('47', 'ж.к. ЛЮЛИН 7'),
	('48', 'ж.к. ЛЮЛИН 8'),
	('49', 'ж.к. ЛЮЛИН 9'),
	('50', 'ж.к. МЛАДОСТ 1'),
	('51', 'ж.к. МЛАДОСТ 1А'),
	('52', 'ж.к. МЛАДОСТ 2'),
	('53', 'ж.к. МЛАДОСТ 3'),
	('54', 'ж.к. МЛАДОСТ 4'),
	('55', 'ж.к. МОТОПИСТА'),
	('56', 'ж.к. МУСАГЕНИЦА'),
	('57', 'ж.к. НАДЕЖДА 1'),
	('58', 'ж.к. НАДЕЖДА 2'),
	('59', 'ж.к. НАДЕЖДА 3'),
	('60', 'ж.к. НАДЕЖДА 4'),
	('61', 'ж.к. НАДЕЖДА 5'),
	('62', 'ж.к. НАДЕЖДА 6'),
	('63', 'ж.к. ОБЕЛЯ 1'),
	('64', 'ж.к. ОБЕЛЯ 2'),
	('65', 'ж.к. ОВЧА КУПЕЛ 1'),
	('66', 'ж.к. ОВЧА КУПЕЛ 2'),
	('67', 'ж.к. ПАВЛОВО - БЪКСТОН'),
	('68', 'ж.к. РАЗСАДНИКА-КОНЬОВИЦА'),
	('69', 'ж.к. СВЕТА ТРОИЦА'),
	('70', 'ж.к. СВОБОДА'),
	('71', 'ж.к. СЕРДИКА'),
	('72', 'ж.к. СЛАВИЯ'),
	('73', 'ж.к. СОФИЯ - ВИЛИДЖ'),
	('74', 'ж.к. СОФИЯ ПАРК'),
	('75', 'ж.к. СТРЕЛБИЩЕ'),
	('76', 'ж.к. СТУДЕНТСКИ ГРАД'),
	('77', 'ж.к. СУХАТА РЕКА'),
	('78', 'ж.к. ТЕРАСИТЕ'),
	('79', 'ж.к. ТРИЪГЪЛНИКА-НАДЕЖДА'),
	('80', 'ж.к. ФИЛИПОВЦИ'),
	('81', 'ж.к. ФОНДОВИ ЖИЛИЩА'),
	('82', 'ж.к. ХАДЖИ ДИМИТЪР'),
	('83', 'ж.к. ХИПОДРУМА'),
	('84', 'ж.к. ХРИСТО СМИРНЕНСКИ'),
	('85', 'ж.к. ЮЖЕН ПАРК'),
	('86', 'ж.к. ЯВОРОВ'),
	('87', 'кв. АБДОВИЦА'),
	('88', 'кв. БЕНКОВСКИ'),
	('89', 'кв. БОТУНЕЦ'),
	('90', 'кв. БОЯНА'),
	('91', 'кв. БУСМАНЦИ'),
	('92', 'кв. ВАСИЛ ЛЕВСКИ'),
	('93', 'кв. ВЕРДИКАЛ'),
	('94', 'кв. ВИДНИТЕ'),
	('95', 'кв. ВИТОША'),
	('96', 'кв. ВОЕННА РАМПА'),
	('97', 'кв. ВРАЖДЕБНА'),
	('98', 'кв. ВРЪБНИЦА'),
	('99', 'кв. ГНИЛЯНЕ');
/*!40000 ALTER TABLE `wnjk_kv` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnkmetstva
CREATE TABLE IF NOT EXISTS `wnkmetstva` (
  `nkod` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `nime` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnkmetstva: ~32 rows (приблизително)
DELETE FROM `wnkmetstva`;
/*!40000 ALTER TABLE `wnkmetstva` DISABLE KEYS */;
INSERT INTO `wnkmetstva` (`nkod`, `nime`) VALUES
	('SOF46-31', 'Бусманци'),
	('SOF46-32', 'Владая'),
	('SOF46-33', 'Мърчаево'),
	('SOF46-34', 'Мало Бучино'),
	('SOF46-35', 'Волуяк'),
	('SOF46-36', 'Балша'),
	('SOF46-37', 'Войнеговци'),
	('SOF46-38', 'Доброславци'),
	('SOF46-39', 'Житен'),
	('SOF46-40', 'Кубратово'),
	('SOF46-41', 'Кътина'),
	('SOF46-42', 'Локорско'),
	('SOF46-43', 'Мировяне'),
	('SOF46-44', 'Мрамор'),
	('SOF46-45', 'Негован'),
	('SOF46-46', 'Подгумер'),
	('SOF46-47', 'Световрачене'),
	('SOF46-48', 'Чепинци'),
	('SOF46-49', 'Бухово'),
	('SOF46-50', 'Горни Богров'),
	('SOF46-51', 'Долни Богров'),
	('SOF46-52', 'Желява'),
	('SOF46-53', 'Яна'),
	('SOF46-54', 'Бистрица'),
	('SOF46-55', 'Герман'),
	('SOF46-56', 'Долни Пасарел'),
	('SOF46-57', 'Железница'),
	('SOF46-58', 'Казичене'),
	('SOF46-59', 'Кокаляне'),
	('SOF46-60', 'Кривина'),
	('SOF46-61', 'Лозен'),
	('SOF46-63', 'Иваняне');
/*!40000 ALTER TABLE `wnkmetstva` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnnaz
CREATE TABLE IF NOT EXISTS `wnnaz` (
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnnaz: ~236 rows (приблизително)
DELETE FROM `wnnaz`;
/*!40000 ALTER TABLE `wnnaz` DISABLE KEYS */;
INSERT INTO `wnnaz` (`NKOD`, `NIME`) VALUES
	('AD', 'АНДОРА'),
	('AE', 'ОАЕ'),
	('AF', 'АФГАНИСТАН'),
	('AG', 'АНТИГУА и БАРБУДА'),
	('AI', 'АНГУИЛA'),
	('AL', 'АЛБАНИЯ'),
	('AM', 'АРМЕНИЯ'),
	('AN', 'НИДЕРЛАНДСКИ АНТИЛИ'),
	('AQ', 'АНТАРКТИКА'),
	('AR', 'АРЖЕНТИНА'),
	('AS', 'ИЗТОЧНИ САМОА'),
	('AT', 'АВСТРИЯ'),
	('AU', 'АВСТРАЛИЯ'),
	('AW', 'АРУБА'),
	('AZ', 'АЗЕРБАЙДЖАН'),
	('BA', 'БОСНА и ХЕРЦЕГОВИНА'),
	('BB', 'БАРБЕЙДОС'),
	('BD', 'БАНГЛАДЕШ'),
	('BE', 'БЕЛГИЯ'),
	('BF', 'БУРКИНА ФАСО'),
	('BG', 'БЪЛГАРИЯ'),
	('BH', 'БАХРЕЙН'),
	('BI', 'БУРУНДИ'),
	('BJ', 'БЕНИН'),
	('BM', 'БЕРМУДСКИ ОСТРОВИ'),
	('BN', 'БРУНЕЙ ДАРУССАЛАМ'),
	('BO', 'БОЛИВИЯ'),
	('BR', 'БРАЗИЛИЯ'),
	('BS', 'БАХАМСКИ ОСТРОВИ'),
	('BT', 'БРИТ.ТЕР.ИНД.ОКЕАН'),
	('BV', 'БУВЕ'),
	('BW', 'БОТСУАНА'),
	('BY', 'БЕЛАРУС'),
	('BZ', 'БЕЛИЗ'),
	('CA', 'КАНАДА'),
	('CC', 'КОКОСОВИ ОСТРОВИ'),
	('CF', 'ЦЕНТР.АФР.РЕПУБЛИКА'),
	('CG', 'КОНГО'),
	('CH', 'ШВЕЙЦАРИЯ'),
	('CI', 'КОТ Д`ИВОАР'),
	('CK', 'KУК'),
	('CL', 'ЧИЛИ'),
	('CN', 'КИТАЙ'),
	('CO', 'КОЛУМБИЯ'),
	('CR', 'КОСТА РИКА'),
	('CU', 'КУБА'),
	('CV', 'КАБО ВЕРДЕ'),
	('CX', 'РОЖДЕСТВО'),
	('CY', 'КИПЪР'),
	('CZ', 'ЧЕШКА РЕПУБЛИКА'),
	('DE', 'ГЕРМАНИЯ'),
	('DJ', 'ДЖИБУТИ'),
	('DK', 'ДАНИЯ'),
	('DM', 'ДОМИНИКА'),
	('DO', 'ДОМИНИКАНСКА РЕПУБЛИКА'),
	('DZ', 'АЛЖИР'),
	('EC', 'ЕКВАДОР'),
	('EE', 'EСТОНИЯ'),
	('EG', 'ЕГИПЕТ'),
	('EH', 'ЗАПАДНА САХАРА'),
	('ER', 'ЕРИТРЕЯ'),
	('ES', 'ИСПАНИЯ'),
	('ET', 'EТИОПИЯ'),
	('FI', 'ФИНЛАНДИЯ'),
	('FJ', 'ФИДЖИ'),
	('FK', 'ФОЛКЛАНДСКИ О-ВИ'),
	('FM', 'МИКРОНЕЗИЯ'),
	('FO', 'ФЕРЬОРСКИ ОСТРОВИ'),
	('FR', 'ФРАНЦИЯ'),
	('FX', 'ФРАНЦИЯ,МЕТРОПОЛИЯ'),
	('GA', 'ГАБОН'),
	('GB', 'ВЕЛИКОБРИТАНИЯ'),
	('GE', 'ГРУЗИЯ'),
	('GF', 'ФРЕНСКА ГИАНА'),
	('GH', 'ГАНА'),
	('GI', 'ГИБРАЛТАР'),
	('GL', 'ГРЕНЛАНДИЯ'),
	('GM', 'ГАМБИЯ'),
	('GN', 'ГВИНЕЯ'),
	('GP', 'ГВАДЕЛУПА'),
	('GQ', 'ЕКВАТОРИАЛНА ГВИНЕЯ'),
	('GR', 'ГЪРЦИЯ'),
	('GS', 'САНДВИЧЕВИ ОСТРОВИ'),
	('GT', 'ГВАТЕМАЛА'),
	('GU', 'ГУАМ'),
	('GW', 'ГВИНЕЯ-БИСАУ'),
	('GY', 'ГАЯНА'),
	('HK', 'ХОНКОНГ'),
	('HM', 'ХЪРД И МАКДОНАЛД,о-ви'),
	('HN', 'ХОНДУРАС'),
	('HR', 'ХЪРВАТСКО'),
	('HT', 'ХАИТИ'),
	('HU', 'УНГАРИЯ'),
	('ID', 'ИНДОНЕЗИЯ'),
	('IE', 'ИРЛАНДИЯ (ЕЙРЕ)'),
	('IL', 'ИЗРАЕЛ'),
	('IN', 'ИНДИЯ'),
	('IQ', 'ИРАК'),
	('IR', 'ИРАН'),
	('IS', 'ИСЛАНДИЯ'),
	('IT', 'ИТАЛИЯ'),
	('JM', 'ЯМАЙКА'),
	('JO', 'ЙОРДАНИЯ'),
	('JP', 'ЯПОНИЯ'),
	('KE', 'КЕНИЯ'),
	('KG', 'КИРГИЗСТАН'),
	('KH', 'КАМБОДЖА'),
	('KI', 'КИРИБАТИ'),
	('KM', 'КОМОРСКИ ОСТРОВИ'),
	('KN', 'СЕИНТ КИТС И НЕЙВИС'),
	('KP', 'КОРЕЯ,ДНР'),
	('KR', 'КОРЕЯ, Репюблика'),
	('KW', 'КУВЕЙТ'),
	('KZ', 'КАЗАХСТАН'),
	('LA', 'ЛАОС'),
	('LB', 'ЛИВАН'),
	('LC', 'СЕЙНТ ЛУСИЯ'),
	('LI', 'ЛИХТЕНЩАЙН'),
	('LK', 'ШРИ ЛАНКА'),
	('LR', 'ЛИБЕРИЯ'),
	('LS', 'ЛЕСОТО'),
	('LT', 'ЛИТВА'),
	('LU', 'ЛЮКСЕМБУРГ'),
	('LV', 'ЛАТВИЯ'),
	('LY', 'ЛИБИЯ'),
	('MA', 'МАРОКО'),
	('MC', 'МОНАКО'),
	('MD', 'МОЛДОВА'),
	('MG', 'МАДАГАСКАР'),
	('MH', 'МАРШАЛСКИ ОСТРОВИ'),
	('MK', 'МАКЕДОНИЯ'),
	('ML', 'МАЛИ'),
	('MN', 'МОНГОЛИЯ'),
	('MO', 'МАКАО'),
	('MP', 'СЕВ.МАРИАНСКИ О-ВИ'),
	('MQ', 'МАРТИНИКА'),
	('MR', 'МАВРИТАНИЯ'),
	('MS', 'МОНТСЕРАТ'),
	('MT', 'МАЛТА'),
	('MU', 'МАВРИЦИЙ'),
	('MV', 'МАЛДИВИ'),
	('MW', 'МАЛАВИ'),
	('MX', 'МЕКСИКО'),
	('MY', 'МАЛАЙЗИЯ'),
	('MZ', 'МОЗАМБИК'),
	('MМ', 'МИАНМА (Биюма)'),
	('NA', 'НАМИБИЯ'),
	('NC', 'НОВА КАЛЕДОНИЯ'),
	('NE', 'НИГЕР'),
	('NF', 'НОРФОЛК'),
	('NG', 'НИГЕРИЯ'),
	('NI', 'НИКАРАГУА'),
	('NL', 'НИДЕРЛАНДИЯ'),
	('NO', 'НОРВЕГИЯ'),
	('NP', 'НЕПАЛ'),
	('NR', 'НАУРУ'),
	('NU', 'НИУЕ'),
	('NZ', 'НОВА ЗЕЛАНДИЯ'),
	('OM', 'ОМАН'),
	('PA', 'ПАНАМА'),
	('PE', 'ПЕРУ'),
	('PF', 'ФРЕНСКА ПОЛИНЕЗИЯ'),
	('PG', 'ПАПУА-НОВА ГВИНЕЯ'),
	('PH', 'ФИЛИПИНИ'),
	('PK', 'ПАКИСТАН'),
	('PL', 'ДЪРЖАВАТА ПАЛЕСТИНА'),
	('PM', 'СЕН ПИЕР И МИКЕЛОН'),
	('PN', 'ПИТКЕЪРН'),
	('PR', 'ПУЕРТО РИКО'),
	('PT', 'ПОРТУГАЛИЯ'),
	('PW', 'ПАЛАУ'),
	('PY', 'ПАРАГВАЙ'),
	('QA', 'КАТАР'),
	('RE', 'РЕЮНИОН'),
	('RO', 'РУМЪНИЯ'),
	('RU', 'РУСКА ФЕДЕРАЦИЯ'),
	('RW', 'РУАНДА'),
	('SA', 'САУДИТСКА АРАБИЯ'),
	('SB', 'СОЛОМОНОВИ ОСТРОВИ'),
	('SC', 'СЕЙШЕЛИ'),
	('SD', 'СУДАН'),
	('SE', 'ШВЕЦИЯ'),
	('SG', 'СИНГАПУР'),
	('SH', 'СВЕТА ЕЛЕНА'),
	('SI', 'СЛОВЕНИЯ'),
	('SJ', 'СВАЛБАР И ЯН МАЙЕН'),
	('SK', 'СЛОВАКИЯ'),
	('SL', 'СИЕРА ЛЕОНЕ'),
	('SM', 'САН МАРИНО'),
	('SN', 'СЕНЕГАЛ'),
	('SO', 'СОМАЛИЯ'),
	('SR', 'СУРИНАМ'),
	('ST', 'САО ТОМЕ И ПРИНСИПИ'),
	('SV', 'САЛВАДОР'),
	('SY', 'СИРИЯ'),
	('SZ', 'СУАЗИЛЕНД'),
	('TC', 'ТЪРКС И КАЙКОС о-ви'),
	('TD', 'ЧАД'),
	('TF', 'ФРЕНСКИ ЮЖНИ ТЕР.'),
	('TG', 'ТОГО'),
	('TH', 'ТАЙЛАНД'),
	('TJ', 'ТАДЖИКИСТАН'),
	('TK', 'ТОКЕЛАУ'),
	('TM', 'ТУРКМЕНИСТАН'),
	('TN', 'ТУНИС'),
	('TO', 'ТОНГА'),
	('TP', 'ИЗТОЧЕН ТИМОР'),
	('TR', 'ТУРЦИЯ'),
	('TT', 'ТРИНИДАД И ТОБАГО'),
	('TV', 'ТУВАЛУ'),
	('TW', 'ТАЙВАН'),
	('TZ', 'ТАНЗАНИЯ'),
	('UA', 'УКРАЙНА'),
	('UG', 'УГАНДА'),
	('US', 'САЩ'),
	('UY', 'УРУГВАЙ'),
	('UZ', 'УЗБЕКИСТАН'),
	('VA', 'ВАТИКАНА'),
	('VC', 'СЕЙНТ ВИНСЕНТ И ГРЕНАДИНИ'),
	('VE', 'ВЕНЕСУЕЛА'),
	('VG', 'ВИРДЖИНСКИ О-ВИ(бю.)'),
	('VI', 'ВИРДЖИНСКИ О-ВИ(САЩ)'),
	('VN', 'ВИЕТНАМ'),
	('VU', 'ВАНУАТУ'),
	('WF', 'УОЛИС И ФУТУНА о-ви'),
	('WS', 'САМОА'),
	('YE', 'ЙЕМЕН'),
	('YT', 'МАЙОТ'),
	('YU', 'ЮГОСЛАВИЯ'),
	('ZA', 'ЮЖНА АФРИКА'),
	('ZM', 'ЗАМБИЯ'),
	('ZR', 'ЗАИР'),
	('ZW', 'ЗИМБАБВЕ'),
	('АО', 'АНГОЛА'),
	('КY', 'КАЙМАНОВИ ОСТРОВИ'),
	('СМ', 'КАМЕРУН');
/*!40000 ALTER TABLE `wnnaz` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnnru
CREATE TABLE IF NOT EXISTS `wnnru` (
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnnru: ~7 rows (приблизително)
DELETE FROM `wnnru`;
/*!40000 ALTER TABLE `wnnru` DISABLE KEYS */;
INSERT INTO `wnnru` (`NKOD`, `NIME`) VALUES
	('00', 'МВР-София'),
	('11', 'СДВР'),
	('12', 'РДВР-Сливен'),
	('13', 'МВР-Кърджали'),
	('14', 'МВР - Пловдив'),
	('15', 'РУнаМВР-гр.Разлог'),
	('17', 'РПУ-ДУПНИЦА');
/*!40000 ALTER TABLE `wnnru` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnobl
CREATE TABLE IF NOT EXISTS `wnobl` (
  `NKOD` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnobl: ~0 rows (приблизително)
DELETE FROM `wnobl`;
/*!40000 ALTER TABLE `wnobl` DISABLE KEYS */;
INSERT INTO `wnobl` (`NKOD`, `NIME`) VALUES
	('SOF', 'София (столица)');
/*!40000 ALTER TABLE `wnobl` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnobs
CREATE TABLE IF NOT EXISTS `wnobs` (
  `NKOD` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ekatte` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnobs: ~0 rows (приблизително)
DELETE FROM `wnobs`;
/*!40000 ALTER TABLE `wnobs` DISABLE KEYS */;
INSERT INTO `wnobs` (`NKOD`, `NIME`, `ekatte`) VALUES
	('SOF46', 'Столична община', '68134');
/*!40000 ALTER TABLE `wnobs` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnsila
CREATE TABLE IF NOT EXISTS `wnsila` (
  `ID_Party` int(5) NOT NULL AUTO_INCREMENT,
  `IZB_ALIAS` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `Short_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Legal_Kod` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status_Partii` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID_Party`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnsila: ~6 rows (приблизително)
DELETE FROM `wnsila`;
/*!40000 ALTER TABLE `wnsila` DISABLE KEYS */;
INSERT INTO `wnsila` (`ID_Party`, `IZB_ALIAS`, `NKOD`, `Short_name`, `NIME`, `Legal_Kod`, `Status_Partii`) VALUES
	(1, 'PR2021', '01', 'ПП ГЕРБ', 'ГЕРБ', NULL, 1),
	(2, 'PR2021', '02', 'КП БСП', 'Коалиция "БСП за България"', NULL, 1),
	(3, 'PR2021', '03', 'ПП ДПС', 'партия "Движение за права и свободи"', NULL, 1),
	(4, 'PR2021', '04', 'КП ОП', 'Коалиция "Об. патриоти- НФСБ, Атака и ВМРО', NULL, 1),
	(6, 'PR2021', '06', 'ПП Воля', 'партия ВОЛЯ', NULL, 1),
	(7, 'PR2021', '09', 'К ДБО', 'Коалиция "Демократична България - Обединение', NULL, 1);
/*!40000 ALTER TABLE `wnsila` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnspec
CREATE TABLE IF NOT EXISTS `wnspec` (
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnspec: ~11 rows (приблизително)
DELETE FROM `wnspec`;
/*!40000 ALTER TABLE `wnspec` DISABLE KEYS */;
INSERT INTO `wnspec` (`NKOD`, `NIME`) VALUES
	('00', 'Няма'),
	('01', 'Инженер'),
	('02', 'Юрист'),
	('03', 'Икономист'),
	('04', 'Медик'),
	('05', 'Информатик'),
	('06', 'Финансист'),
	('07', 'Журналист'),
	('08', 'Работник'),
	('09', 'Педагог'),
	('10', 'Друга');
/*!40000 ALTER TABLE `wnspec` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnszem
CREATE TABLE IF NOT EXISTS `wnszem` (
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnszem: ~9 rows (приблизително)
DELETE FROM `wnszem`;
/*!40000 ALTER TABLE `wnszem` DISABLE KEYS */;
INSERT INTO `wnszem` (`NKOD`, `NIME`) VALUES
	('00', 'Няма'),
	('01', 'Магистър'),
	('02', 'Бакалавър'),
	('03', 'Висше'),
	('04', 'Полувисше'),
	('05', 'Средно специално'),
	('06', 'Средно'),
	('07', 'Основно'),
	('08', 'Без образование');
/*!40000 ALTER TABLE `wnszem` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wntipizbori
CREATE TABLE IF NOT EXISTS `wntipizbori` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nkod` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `nime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tur` int(1) NOT NULL DEFAULT '1',
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wntipizbori: ~5 rows (приблизително)
DELETE FROM `wntipizbori`;
/*!40000 ALTER TABLE `wntipizbori` DISABLE KEYS */;
INSERT INTO `wntipizbori` (`id`, `nkod`, `nime`, `tur`, `status`) VALUES
	(1, 'NS', 'Народно събрание', 1, 1),
	(2, 'PR', 'Президент', 2, 1),
	(3, 'MI', 'Местни избори', 2, 1),
	(4, 'EP', 'Европейски парламент', 1, 1),
	(5, 'NR', 'Национален референдум', 1, 1);
/*!40000 ALTER TABLE `wntipizbori` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wntoa
CREATE TABLE IF NOT EXISTS `wntoa` (
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `NIME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NKOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wntoa: ~25 rows (приблизително)
DELETE FROM `wntoa`;
/*!40000 ALTER TABLE `wntoa` DISABLE KEYS */;
INSERT INTO `wntoa` (`NKOD`, `NIME`) VALUES
	('01', 'СРЕДЕЦ'),
	('02', 'КРАСНО СЕЛО'),
	('03', 'ВЪЗРАЖДАНЕ'),
	('04', 'ОБОРИЩЕ'),
	('05', 'СЕРДИКА'),
	('06', 'ПОДУЯНЕ'),
	('07', 'СЛАТИНА'),
	('08', 'ИЗГРЕВ'),
	('09', 'ЛОЗЕНЕЦ'),
	('10', 'ТРИАДИЦА'),
	('11', 'КРАСНА ПОЛЯНА'),
	('12', 'ИЛИНДЕН'),
	('13', 'НАДЕЖДА'),
	('14', 'ИСКЪР'),
	('15', 'МЛАДОСТ'),
	('16', 'СТУДЕНТСКИ'),
	('17', 'ВИТОША'),
	('18', 'ОВЧА КУПЕЛ'),
	('19', 'ЛЮЛИН'),
	('20', 'ВРЪБНИЦА'),
	('21', 'НОВИ ИСКЪР'),
	('22', 'КРЕМИКОВЦИ'),
	('23', 'ПАНЧАРЕВО'),
	('24', 'БАНКЯ'),
	('25', 'Резервна позиция');
/*!40000 ALTER TABLE `wntoa` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wntoa_izbraion
CREATE TABLE IF NOT EXISTS `wntoa_izbraion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NKOD` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `IZB_R` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BROI_SIK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wntoa_izbraion: ~48 rows (приблизително)
DELETE FROM `wntoa_izbraion`;
/*!40000 ALTER TABLE `wntoa_izbraion` DISABLE KEYS */;
INSERT INTO `wntoa_izbraion` (`id`, `NKOD`, `IZB_R`, `BROI_SIK`) VALUES
	(1, '01', '24', NULL),
	(2, '02', '23', NULL),
	(3, '03', '24', NULL),
	(4, '04', '24', NULL),
	(5, '05', '24', NULL),
	(6, '06', '24', NULL),
	(7, '07', '24', NULL),
	(8, '08', '23', NULL),
	(9, '09', '23', NULL),
	(10, '10', '23', NULL),
	(11, '11', '25', NULL),
	(12, '12', '25', NULL),
	(13, '13', '25', NULL),
	(14, '14', '24', NULL),
	(15, '15', '23', NULL),
	(16, '16', '23', NULL),
	(17, '17', '23', NULL),
	(18, '18', '25', NULL),
	(19, '19', '25', NULL),
	(20, '20', '25', NULL),
	(21, '21', '25', NULL),
	(22, '22', '24', NULL),
	(23, '23', '23', NULL),
	(24, '24', '25', NULL),
	(25, '01', '22', NULL),
	(26, '02', '22', NULL),
	(27, '03', '22', NULL),
	(28, '04', '22', NULL),
	(29, '05', '22', NULL),
	(30, '06', '22', NULL),
	(31, '07', '22', NULL),
	(32, '08', '22', NULL),
	(33, '09', '22', NULL),
	(34, '10', '22', NULL),
	(35, '11', '22', NULL),
	(36, '12', '22', NULL),
	(37, '13', '22', NULL),
	(38, '14', '22', NULL),
	(39, '15', '22', NULL),
	(40, '16', '22', NULL),
	(41, '17', '22', NULL),
	(42, '18', '22', NULL),
	(43, '19', '22', NULL),
	(44, '20', '22', NULL),
	(45, '21', '22', NULL),
	(46, '22', '22', NULL),
	(47, '23', '22', NULL),
	(48, '24', '22', NULL);
/*!40000 ALTER TABLE `wntoa_izbraion` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.wnuli
CREATE TABLE IF NOT EXISTS `wnuli` (
  `nkod` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `wnasm_nkod` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wnuli_nkod` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nime` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.wnuli: ~5 080 rows (приблизително)
DELETE FROM `wnuli`;
/*!40000 ALTER TABLE `wnuli` DISABLE KEYS */;
INSERT INTO `wnuli` (`nkod`, `wnasm_nkod`, `wnuli_nkod`, `nime`) VALUES
	('00001', '00357', '75013', 'УЛ.КОЦЕ ПЕТРОВ БУРГОВ'),
	('00002', '00357', '75023', 'УЛ.СВ.КЛИМЕНТ ОХРИДСКИ'),
	('00003', '00357', '75037', 'УЛ.АКАЦИИТЕ'),
	('00004', '00357', '75040', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('00005', '00357', '75054', 'УЛ.ВЕЧЕРНИЦА'),
	('00006', '00357', '75068', 'УЛ.БОРОВЕЦ'),
	('00007', '00357', '75071', 'УЛ.ХАДЖИ ДИМИТЪР'),
	('00008', '00357', '75085', 'УЛ.БАНСКА'),
	('00009', '00357', '75099', 'УЛ.БРЯСТОВЕТЕ'),
	('00010', '00357', '75109', 'УЛ.БЪДЕЩЕ'),
	('00011', '00357', '75112', 'УЛ.БРЕЗА'),
	('00012', '00357', '75126', 'УЛ.БЯЛ КРЕМ'),
	('00013', '00357', '75139', 'УЛ.БЕЛАСИЦА'),
	('00014', '00357', '75143', 'УЛ.БАЛКАН'),
	('00015', '00357', '75157', 'УЛ.БРЕЗОВА ГОРА'),
	('00016', '00357', '75160', 'УЛ.БИЛКА'),
	('00017', '00357', '75174', 'УЛ.ПЕНЧО СЛАВЕЙКОВ'),
	('00018', '00357', '75188', 'УЛ.БИСЕР'),
	('00019', '00357', '75191', 'УЛ.БЯЛАТА МОГИЛА'),
	('00020', '00357', '75201', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('00021', '00357', '75215', 'УЛ.ВИРОВЕТЕ'),
	('00022', '00357', '75229', 'УЛ.СВЕЩ.ЮРДАН АНГЕЛОВ'),
	('00023', '00357', '75232', 'УЛ.ВУТЕ ВЕЛЕВ'),
	('00024', '00357', '75246', 'УЛ.ВЕЛИКО ТЪРНОВО'),
	('00025', '00357', '75254', 'УЛ.ВИХРЕН'),
	('00026', '00357', '75263', 'УЛ.ВЪРБОВКА'),
	('00027', '00357', '75277', 'УЛ.ВИТОША'),
	('00028', '00357', '75280', 'УЛ.ВЪРБИТЕ'),
	('00029', '00357', '75294', 'УЛ.ВАРНА'),
	('00030', '00357', '75304', 'УЛ.РОДОПИ'),
	('00031', '00357', '75318', 'УЛ.НАДЕЖДА'),
	('00032', '00357', '75321', 'УЛ.ВИЛНА'),
	('00033', '00357', '75335', 'УЛ.ВОДОПАД'),
	('00034', '00357', '75349', 'УЛ.ВРАНЯ'),
	('00035', '00357', '75352', 'УЛ.ДОДО НАКОВ'),
	('00036', '00357', '75366', 'УЛ.ГРОЗДАНКА'),
	('00037', '00357', '75370', 'УЛ.ОБРОЧИЩЕ'),
	('00038', '00357', '75383', 'УЛ.ГОРСКО ПИЛЕ'),
	('00039', '00357', '75397', 'УЛ.ГРАДИНА'),
	('00040', '00357', '75407', 'УЛ.СВ.ИВАН РИЛСКИ'),
	('00041', '00357', '75410', 'УЛ.ГЕРОЙ'),
	('00042', '00357', '75424', 'УЛ.ГОЛО БЪРДО'),
	('00043', '00357', '75438', 'УЛ.ДЕТСКА ПЕСЕН'),
	('00044', '00357', '75441', 'УЛ.ДЕТЕЛИНА'),
	('00045', '00357', '75455', 'УЛ.ДЯДО СТОИЛ'),
	('00046', '00357', '75469', 'УЛ.ДВЕ МОГИЛИ'),
	('00047', '00357', '75472', 'УЛ.ДЪБИЦИТЕ'),
	('00048', '00357', '75486', 'УЛ.ПЪРВА ШОПСКА ДИВИЗИЯ'),
	('00049', '00357', '75495', 'УЛ.ДЪБ'),
	('00050', '00357', '75500', 'УЛ.ДОБЪР МИЛЕ'),
	('00051', '00357', '75513', 'УЛ.ВЯРА'),
	('00052', '00357', '75527', 'УЛ.ДОЛНА ЛАКА'),
	('00053', '00357', '75530', 'УЛ.ЕДЕЛВАЙС'),
	('00054', '00357', '75544', 'УЛ.ЖЕРАВНА'),
	('00055', '00357', '75558', 'УЛ.ЖЪЛТУРЧЕ'),
	('00056', '00357', '75561', 'УЛ.ЗИМНИЦА'),
	('00057', '00357', '75575', 'УЛ.ЗАВОДСКО ШОСЕ'),
	('00058', '00357', '75589', 'УЛ.ШЕСТИ СЕПТЕМВРИ'),
	('00059', '00357', '75592', 'УЛ.ЙЕРОМОНАХ ТЕОДОСИ КУМАРИШКИ'),
	('00060', '00357', '75602', 'УЛ.ИСКЪРСКО ДЕФИЛЕ'),
	('00061', '00357', '75616', 'УЛ.ИВАН ФЕЛДШЕРА'),
	('00062', '00357', '75626', 'УЛ.БАБА ТОНКА'),
	('00063', '00357', '75633', 'УЛ.ИГЛИКА'),
	('00064', '00357', '75650', 'УЛ.ЗОРА'),
	('00065', '00357', '75664', 'УЛ.КРУШАТА'),
	('00066', '00357', '75678', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('00067', '00357', '75681', 'УЛ.КОМ'),
	('00068', '00357', '75695', 'УЛ.КИТКА'),
	('00069', '00357', '75705', 'УЛ.КАЛИАКРА'),
	('00070', '00357', '75719', 'УЛ.КУМАРИЦА'),
	('00071', '00357', '75722', 'УЛ.КЪТИНСКИ ПЪТ'),
	('00072', '00357', '75736', 'УЛ.КОЗНИЦА'),
	('00073', '00357', '75741', 'УЛ.КОПРИВЩИЦА'),
	('00074', '00357', '75753', 'УЛ.КОСМОНАВТ'),
	('00075', '00357', '75767', 'УЛ.КЕСТЕН'),
	('00076', '00357', '75770', 'УЛ.КОКИЧЕ'),
	('00077', '00357', '75784', 'УЛ.КРУШЕТАТА'),
	('00078', '00357', '75798', 'УЛ.БОЖУР'),
	('00079', '00357', '75808', 'УЛ.КАПИНА'),
	('00080', '00357', '75811', 'УЛ.СЪГЛАСИЕ'),
	('00081', '00357', '75825', 'УЛ.КОГИЧИН КЛАДЕНЕЦ'),
	('00082', '00357', '75839', 'УЛ.ЙОВЕ ВОЙВОДА'),
	('00083', '00357', '75842', 'УЛ.ЛИПИТЕ'),
	('00084', '00357', '75856', 'УЛ.ЛЕТЕЦ'),
	('00085', '00357', '75867', 'УЛ.ЛЮЛЯК'),
	('00086', '00357', '75873', 'УЛ.ЛОЗАРСКИ ПЪТ'),
	('00087', '00357', '75887', 'УЛ.ЛАЛЕ'),
	('00088', '00357', '75890', 'УЛ.ЛАСКА'),
	('00089', '00357', '75900', 'УЛ.ЛОЗАРСКА'),
	('00090', '00357', '75914', 'УЛ.ЛИВАДСКИ ПЪТ'),
	('00091', '00357', '75928', 'УЛ.ЛОЗЯНСКИ ДОЛ'),
	('00092', '00357', '75931', 'УЛ.ЛИВАДИТЕ'),
	('00093', '00357', '75945', 'УЛ.ЛАТИНКА'),
	('00094', '00357', '75959', 'УЛ.ЛОЗЯТА'),
	('00095', '00357', '75962', 'УЛ.СРЕДНА ГОРА'),
	('00096', '00357', '75976', 'УЛ.ЧЕРКОВНА'),
	('00097', '00357', '75982', 'УЛ.МАЛИНА'),
	('00098', '00357', '75993', 'УЛ.МАРГАРИТА'),
	('00099', '00357', '76008', 'УЛ.МОМИНА СЪЛЗА'),
	('00100', '00357', '76011', 'УЛ.МАЛЬОВИЦА'),
	('00101', '00357', '76025', 'УЛ.МАЛКО БЪРДО'),
	('00102', '00357', '76039', 'УЛ.МИМОЗА'),
	('00103', '00357', '76042', 'УЛ.МАРТЕНИЧКА'),
	('00104', '00357', '76056', 'УЛ.МИНЗУХАР'),
	('00105', '00357', '76064', 'УЛ.МУРТЕНИЦА'),
	('00106', '00357', '76073', 'УЛ.МИЛИН КАМЪК'),
	('00107', '00357', '76087', 'УЛ.ДИМИТЪР ИВАНОВ'),
	('00108', '00357', '76090', 'УЛ.НЕЗАБРАВКА'),
	('00109', '00357', '76100', 'УЛ.НЕВЕН'),
	('00110', '00357', '76114', 'УЛ.НОВ ЖИВОТ'),
	('00111', '00357', '76128', 'УЛ.ОТДИХ'),
	('00112', '00357', '76131', 'УЛ.ОКОЛЧИЦА'),
	('00113', '00357', '76145', 'УЛ.ОБНОВЛЕНИЕ'),
	('00114', '00357', '76159', 'УЛ.ПОБЕДА'),
	('00115', '00357', '76162', 'УЛ.ГЕОРГИ С.РАКОВСКИ'),
	('00116', '00357', '76180', 'УЛ.ПРЕСЛАВ'),
	('00117', '00357', '76193', 'УЛ.ПЛАМЪК'),
	('00118', '00357', '76203', 'УЛ.СМАГОВО'),
	('00119', '00357', '76217', 'УЛ.ПРОСВЕТА'),
	('00120', '00357', '76220', 'УЛ.РАВНЕЦ'),
	('00121', '00357', '76234', 'УЛ.ИВАН ВАЗОВ'),
	('00122', '00357', '76248', 'УЛ.РОПОТАМО'),
	('00123', '00357', '76265', 'УЛ.ДЕКО БЕБЕВ'),
	('00124', '00357', '76279', 'УЛ.РОЗОВА ДОЛИНА'),
	('00125', '00357', '76282', 'УЛ.РУБИН'),
	('00126', '00357', '76296', 'УЛ.РОДЕН КЪТ'),
	('00127', '00357', '76306', 'УЛ.КРЕМЕНИЦА'),
	('00128', '00357', '76310', 'УЛ.СЪЛЗИЦА'),
	('00129', '00357', '76323', 'УЛ.СЛАВОВЦИ'),
	('00130', '00357', '76337', 'УЛ.СРЕДЕЦ'),
	('00131', '00357', '76340', 'УЛ.СТАРАТА ВЪРБА'),
	('00132', '00357', '76354', 'УЛ.ДИМИТЪР ВАЧЕВ'),
	('00133', '00357', '76368', 'УЛ.СНЕЖАНКА'),
	('00134', '00357', '76371', 'УЛ.СВЕТЛИНА'),
	('00135', '00357', '76385', 'УЛ.СТАДИОН'),
	('00136', '00357', '76399', 'УЛ.СТЕФАН КАРАДЖА'),
	('00137', '00357', '76412', 'УЛ.СВЕТЪЛ ПЪТ'),
	('00138', '00357', '76426', 'УЛ.ЗОРНИЦА'),
	('00139', '00357', '76436', 'УЛ.СВЕЖЕСТ'),
	('00140', '00357', '76457', 'УЛ.БАЧО КИРО'),
	('00141', '00357', '76460', 'УЛ.СПОРТНА'),
	('00142', '00357', '76474', 'УЛ.СПОРТИСТ'),
	('00143', '00357', '76488', 'УЛ.СМОЛНИЧЕТО'),
	('00144', '00357', '76491', 'УЛ.ИСКЪР'),
	('00145', '00357', '76501', 'УЛ.ХРИСТО БОТЕВ'),
	('00146', '00357', '76529', 'УЛ.ТИНТЯВА'),
	('00147', '00357', '76532', 'УЛ.ТАТАРСКА'),
	('00148', '00357', '76546', 'УЛ.СТОЕ ДЖУРОВ'),
	('00149', '00357', '76551', 'УЛ.ТОПОЛА'),
	('00150', '00357', '76563', 'УЛ.ТЕМЕНУГА'),
	('00151', '00357', '76577', 'УЛ.ТОДОРИНИ КУКЛИ'),
	('00152', '00357', '76580', 'УЛ.ТЪРГОВСКА'),
	('00153', '00357', '76594', 'УЛ.ТОПОЛИТЕ'),
	('00154', '00357', '76604', 'УЛ.ТРАПЕЗИЦА'),
	('00155', '00357', '76618', 'УЛ.СТАРА ПЛАНИНА'),
	('00156', '00357', '76621', 'УЛ.ХРИЗАНТЕМА'),
	('00157', '00357', '76635', 'УЛ.ЦАРЕВЕЦ'),
	('00158', '00357', '76649', 'УЛ.ЦИКЛАМА'),
	('00159', '00357', '76652', 'УЛ.ПОРОДИН'),
	('00160', '00357', '76666', 'УЛ.БОГДАН ВОЙВОДА'),
	('00161', '00357', '76677', 'УЛ.СПАС БЕНЕВ'),
	('00162', '00357', '76683', 'УЛ.ЧАВДАР ВОЙВОДА'),
	('00163', '00357', '76697', 'УЛ.ЧЕРЕШИТЕ'),
	('00164', '00357', '76707', 'УЛ.ШОПСКА'),
	('00165', '00357', '76710', 'УЛ.ГИНА КУНЧЕВА'),
	('00166', '00357', '76724', 'УЛ.ЮРИЙ ГАГАРИН'),
	('00167', '00357', '76738', 'УЛ.ЯВОР'),
	('00168', '00357', '76741', 'УЛ.ЯНТРА'),
	('00169', '00357', '76755', 'УЛ.ВЕСЛЕЦ'),
	('00170', '00357', '76772', 'УЛ.Д-Р ПЕТЪР БЕРОН'),
	('00171', '00357', '76786', 'УЛ.ПЛИСКА'),
	('00172', '00357', '76813', 'УЛ.ПЕРЛА'),
	('00173', '00357', '76827', 'УЛ.ПОП БОНЕ НАЙДЕНОВ'),
	('00174', '00357', '76830', 'УЛ.ОБОРИЩЕ'),
	('00175', '00357', '76861', 'ПЛ.ПЪРВИ МАЙ'),
	('00176', '00357', '76947', 'УЛ.СЛАВЕЙЧЕ'),
	('00177', '00357', '76950', 'УЛ.ЛЕЯРСКА'),
	('00178', '00357', '76995', 'УЛ.ПРОЛЕТ'),
	('00179', '00357', '77120', 'УЛ.ЗДРАВЕЦ'),
	('00180', '00357', '77298', 'УЛ.ЗЕНИТ'),
	('00181', '00357', '77308', 'УЛ.НАДЕЖДА'),
	('00182', '00357', '77311', 'УЛ.ПИРИН'),
	('00183', '00357', '77325', 'УЛ.КИПАРИС'),
	('00184', '00357', '77339', 'УЛ.РАКЕТА'),
	('00185', '00357', '77342', 'УЛ.НАРЦИС'),
	('00186', '00357', '77356', 'УЛ.ЧЕМШИР'),
	('00187', '00357', '77361', 'УЛ.ШИПКА'),
	('00188', '00357', '77373', 'УЛ.РИЛА'),
	('00189', '00357', '77387', 'УЛ.ОРАНЖЕРИИ'),
	('00190', '00357', '77414', 'УЛ.МЛАДОСТ'),
	('00191', '00357', '35969', 'УЛ.ФАНАГОРИЯ'),
	('00192', '00357', '00014', 'УЛ.МИРОЛЮБИВА'),
	('00193', '00357', '77618', 'УЛ.ВРЪХ МОГИЛАТА'),
	('00194', '00357', '04474', 'УЛ.ГОРСКИ РАЙ'),
	('00195', '02511', '00014', 'УЛ.ИВАН ДЕНКОГЛУ (1-ВА)'),
	('00196', '02511', '00028', 'УЛ.ОРЕХОВА (2-РА)'),
	('00197', '02511', '00031', 'УЛ.ВРЪПЛИНА (3-ТА)'),
	('00198', '02511', '00045', 'УЛ.БАНИШОРА (4-ТА)'),
	('00199', '02511', '00059', 'УЛ.ВЪЗРОЖДЕНСКА (5-ТА)'),
	('00200', '02511', '00062', 'УЛ.БОРОВА'),
	('00201', '02511', '00076', 'УЛ.ВАСИЛ ЛЕВСКИ (7-МА)'),
	('00202', '02511', '00084', 'УЛ.ПРОСВЕТА (8-МА)'),
	('00203', '02511', '00093', 'УЛ.ЛИПА'),
	('00204', '02511', '00103', 'УЛ.ГАДЖОВИЦА (10-ТА)'),
	('00205', '02511', '00117', 'УЛ.СВОБОДА (11-ТА)'),
	('00206', '02511', '00120', 'УЛ.СПОРТИСТ (12-ТА)'),
	('00207', '02511', '00134', 'УЛ.ЧАВДАР ВОЙВОДА (13-ТА)'),
	('00208', '02511', '00148', 'УЛ.СТАРА ПЛАНИНА (14-ТА)'),
	('00209', '02511', '00151', 'УЛ.ЧЕМШИР (15-ТА)'),
	('00210', '02511', '00165', 'УЛ.ХРИСТО БОТЕВ (16-ТА)'),
	('00211', '02511', '00179', 'УЛ.МЕДНА ГЛАВА (17-ТА)'),
	('00212', '02511', '00182', 'УЛ.РАКОВСКА'),
	('00213', '02511', '00196', 'УЛ.МИР (19-ТА)'),
	('00214', '02511', '00206', 'УЛ.СРЕДОРЕК (20-ТА)'),
	('00215', '02511', '00215', 'УЛ.СВИЛЕН ДИМИТРОВ'),
	('00216', '02511', '00223', 'УЛ.БРЕСТА (22-РА)'),
	('00217', '02511', '00237', 'УЛ.АКАЦИЯ'),
	('00218', '02511', '00240', 'УЛ.ЛЮЛЯК (24-ТА)'),
	('00219', '02511', '00254', 'УЛ.ЮРИЙ ГАГАРИН (25-ТА)'),
	('00220', '02511', '00268', 'УЛ.ШИПЧЕНСКИ ПРОХОД (26-ТА)'),
	('00221', '02659', '95011', 'УЛ.АВЛИГА'),
	('00222', '02659', '95025', 'УЛ.ЗОРА'),
	('00223', '02659', '95039', 'УЛ.ПРОЛЕТ'),
	('00224', '02659', '95056', 'УЛ.АПРИЛЦИ'),
	('00225', '02659', '95066', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('00226', '02659', '95073', 'УЛ.АНГЕЛ КАРАЛИЙЧЕВ'),
	('00227', '02659', '95087', 'УЛ.АНТИМ I'),
	('00228', '02659', '95090', 'УЛ.ЛЕТОСТРУЙ'),
	('00229', '02659', '95100', 'УЛ.БАБА ТОНКА'),
	('00230', '02659', '95114', 'УЛ.БАЛЧИК'),
	('00231', '02659', '95128', 'УЛ.БЕЛАСИЦА'),
	('00232', '02659', '95131', 'УЛ.БЕЛИ БРЕГ'),
	('00233', '02659', '95145', 'УЛ.БОР'),
	('00234', '02659', '95159', 'УЛ.БОРИМЕЧКАТА'),
	('00235', '02659', '95162', 'УЛ.БРЕЗА'),
	('00236', '02659', '95176', 'УЛ.БРЯСТ'),
	('00237', '02659', '95181', 'УЛ.БУК'),
	('00238', '02659', '95193', 'УЛ.БУЛАИР'),
	('00239', '02659', '95203', 'УЛ.ВЕЖЕН'),
	('00240', '02659', '95217', 'УЛ.ВЕНЕРА'),
	('00241', '02659', '95220', 'УЛ.ВИХРЕН'),
	('00242', '02659', '95234', 'УЛ.ВОСТОК'),
	('00243', '02659', '95248', 'УЛ.АРБАНАСИ'),
	('00244', '02659', '95251', 'УЛ.ВЪРБА'),
	('00245', '02659', '95265', 'УЛ.ВЪРШЕЦ'),
	('00246', '02659', '95279', 'УЛ.ГАБЪР'),
	('00247', '02659', '95282', 'УЛ.ТУНДЖА'),
	('00248', '02659', '95296', 'УЛ.ГЕО МИЛЕВ'),
	('00249', '02659', '95306', 'УЛ.ЦАРИБРОДСКА'),
	('00250', '02659', '95312', 'УЛ.ГЕОРГИ САВА РАКОВСКИ'),
	('00251', '02659', '95323', 'УЛ.ГУРГУЛЯТ'),
	('00252', '02659', '95337', 'УЛ.20-ТИ АПРИЛ'),
	('00253', '02659', '95340', 'УЛ.ИЛАРИОН МАКАРИОПОЛСКИ'),
	('00254', '02659', '95354', 'УЛ.ПЕРУНИКА'),
	('00255', '02659', '95368', 'УЛ.ДЕТЕЛИНА'),
	('00256', '02659', '95371', 'УЛ.МОРАВА'),
	('00257', '02659', '95385', 'УЛ.КИПАРИС'),
	('00258', '02659', '95399', 'УЛ.КНЯЗ БОРИС I'),
	('00259', '02659', '95409', 'УЛ.ДОБРИ ВОЙНИКОВ'),
	('00260', '02659', '95412', 'УЛ.ДОБРУДЖА'),
	('00261', '02659', '95426', 'УЛ.ЕДЕЛВАЙС'),
	('00262', '02659', '95438', 'УЛ.ЕЛИН ПЕЛИН'),
	('00263', '02659', '95443', 'УЛ.ЕМИНЕ'),
	('00264', '02659', '95457', 'УЛ.ЕРМА'),
	('00265', '02659', '95460', 'УЛ.ЕСПЕРАНТО'),
	('00266', '02659', '95474', 'УЛ.ЖАН ДЬО ЛАФОНТЕН'),
	('00267', '02659', '95488', 'УЛ.ЖЕЛЕЗНИЧАРСКА'),
	('00268', '02659', '95491', 'УЛ.ЗДРАВЕЦ'),
	('00269', '02659', '95501', 'УЛ.ЗОРА'),
	('00270', '02659', '95515', 'УЛ.ЗОРНИЦА'),
	('00271', '02659', '95529', 'УЛ.ИВАН ВАЗОВ'),
	('00272', '02659', '95532', 'УЛ.ИСКРА'),
	('00273', '02659', '95546', 'УЛ.ИСКЪР'),
	('00274', '02659', '95553', 'УЛ.КАРАМФИЛ'),
	('00275', '02659', '95577', 'УЛ.БЛЯН'),
	('00276', '02659', '95580', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('00277', '02659', '95594', 'УЛ.КИТНА ПРОЛЕТ'),
	('00278', '02659', '95604', 'УЛ.КИТКАТА'),
	('00279', '02659', '95621', 'УЛ.КОКИЧЕ'),
	('00280', '02659', '95635', 'УЛ.МАЛЬОВИЦА'),
	('00281', '02659', '95649', 'УЛ.КОПРИВЩИЦА'),
	('00282', '02659', '95652', 'УЛ.КОС'),
	('00283', '02659', '95666', 'УЛ.КОСМОНАВТ'),
	('00284', '02659', '95679', 'УЛ.КРАКРА'),
	('00285', '02659', '95683', 'УЛ.ПРЕСЛАВ'),
	('00286', '02659', '95697', 'УЛ.КУКУВИЦА'),
	('00287', '02659', '95707', 'УЛ.ЛАЛЕ'),
	('00288', '02659', '95710', 'УЛ.ЛАТИНКА'),
	('00289', '02659', '95724', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('00290', '02659', '95738', 'УЛ.ЛИПА'),
	('00291', '02659', '95741', 'УЛ.ЛОТОС'),
	('00292', '02659', '95755', 'УЛ.ЛУНОХОД'),
	('00293', '02659', '95769', 'УЛ.ЛЮЛИН'),
	('00294', '02659', '95772', 'УЛ.ЛЮЛЯК'),
	('00295', '02659', '95786', 'УЛ.МАКСИМ ГОРКИ'),
	('00296', '02659', '95794', 'УЛ.МАЛИНА'),
	('00297', '02659', '95800', 'УЛ.РАДОСТ'),
	('00298', '02659', '95813', 'УЛ.МАРИЦА'),
	('00299', '02659', '95827', 'УЛ.МЕТОДИ ИВАНОВ'),
	('00300', '02659', '95830', 'УЛ.МИР'),
	('00301', '02659', '95844', 'УЛ.ВИТОША'),
	('00302', '02659', '95858', 'УЛ.ИВАНЯНСКО ШОСЕ'),
	('00303', '02659', '95861', 'УЛ.МОМИНА СЪЛЗА'),
	('00304', '02659', '95875', 'УЛ.НАРЦИС'),
	('00305', '02659', '95892', 'УЛ.НЕКРАСОВ'),
	('00306', '02659', '95902', 'УЛ.НЕСЕБЪР'),
	('00307', '02659', '95916', 'УЛ.НИКОЛА ЙОНКОВ ВАПЦАРОВ'),
	('00308', '02659', '95925', 'УЛ.ОБОРИЩЕ'),
	('00309', '02659', '95933', 'УЛ.ОГРАЖДЕН'),
	('00310', '02659', '95947', 'УЛ.ОКОЛ'),
	('00311', '02659', '95950', 'УЛ.ОРЕХ'),
	('00312', '02659', '95964', 'УЛ.ОТЕЦ ПАИСИЙ'),
	('00313', '02659', '95978', 'УЛ.ПАНАЙОТ ВОЛОВ'),
	('00314', '02659', '95981', 'УЛ.ТЪРНОВ РИД'),
	('00315', '02659', '95995', 'УЛ.ПАТРИАРХ ЕВТИМИЙ'),
	('00316', '02659', '96007', 'УЛ.ПЕЙО ЯВОРОВ'),
	('00317', '02659', '96013', 'УЛ.ПЕТКО Д.ПЕТКОВ'),
	('00318', '02659', '96027', 'УЛ.ПЕТЪР НИКИФОРОВ'),
	('00319', '02659', '96030', 'УЛ.КОЧО ЧЕСТИМЕНСКИ'),
	('00320', '02659', '96044', 'УЛ.ПЛИСКА'),
	('00321', '02659', '96058', 'УЛ.ЛИСТОПАД'),
	('00322', '02659', '96061', 'УЛ.ПИРОТ'),
	('00323', '02659', '96075', 'УЛ.АХЕЛОЙ'),
	('00324', '02659', '96089', 'УЛ.ПОЖАРЕВСКИ ПЪТ'),
	('00325', '02659', '96092', 'УЛ.ПОМОРИЕ'),
	('00326', '02659', '96116', 'УЛ.ПРИМОРСКА'),
	('00327', '02659', '96122', 'УЛ.РАЗТОВАРИЩНА'),
	('00328', '02659', '96133', 'УЛ.РАЙКО ДАСКАЛОВ'),
	('00329', '02659', '96150', 'УЛ.РЕПУБЛИКАНСКА'),
	('00330', '02659', '96164', 'УЛ.РИЛА'),
	('00331', '02659', '96178', 'УЛ.РОДИНА'),
	('00332', '02659', '96181', 'УЛ.РОЗА'),
	('00333', '02659', '96195', 'УЛ.РОПОТАМО'),
	('00334', '02659', '96205', 'УЛ.РОСИЦА'),
	('00335', '02659', '96219', 'УЛ.РУЙ'),
	('00336', '02659', '96222', 'УЛ.РУЧЕЙ'),
	('00337', '02659', '96236', 'УЛ.СВИЛЕН МИЛАНОВ'),
	('00338', '02659', '96248', 'УЛ.ЛУТРАКИ'),
	('00339', '02659', '96253', 'УЛ.СВОБОДА'),
	('00340', '02659', '96267', 'УЛ.СЕРДИКА'),
	('00341', '02659', '96270', 'УЛ.СИНЧЕЦ'),
	('00342', '02659', '96284', 'УЛ.СКАКАЧ'),
	('00343', '02659', '96298', 'УЛ.СЛАВЕЙЧЕ'),
	('00344', '02659', '96308', 'УЛ.СЛИВНИЦА'),
	('00345', '02659', '96311', 'УЛ.СЛЪНЧЕВ БРЯГ'),
	('00346', '02659', '96325', 'УЛ.СОФИЯ'),
	('00347', '02659', '96339', 'УЛ.СОЧИ'),
	('00348', '02659', '96356', 'УЛ.СРЕДНА ГОРА'),
	('00349', '02659', '96363', 'УЛ.СТАРА ПЛАНИНА'),
	('00350', '02659', '96373', 'УЛ.СТРАНДЖА'),
	('00351', '02659', '96387', 'УЛ.БОГДАНОВ ДОЛ'),
	('00352', '02659', '96390', 'УЛ.СТРЪМНА'),
	('00353', '02659', '96400', 'УЛ.ТЕМЕНУГА I'),
	('00354', '02659', '96428', 'УЛ.МАЙОР КОСТА ПАНИЦА'),
	('00355', '02659', '96431', 'УЛ.ТОПЛИКА'),
	('00356', '02659', '96445', 'УЛ.ТРАКИЯ'),
	('00357', '02659', '96459', 'УЛ.ТРАПЕЗИЦА'),
	('00358', '02659', '96462', 'УЛ.ТРЕБЕТО'),
	('00359', '02659', '96476', 'УЛ.ХЕМУС'),
	('00360', '02659', '96489', 'УЛ.ХИСАРЯ'),
	('00361', '02659', '96493', 'УЛ.ХРИСТО БОТЕВ'),
	('00362', '02659', '96503', 'УЛ.ХРИСТО СМИРНЕНСКИ'),
	('00363', '02659', '96517', 'УЛ.ХУМАТА'),
	('00364', '02659', '96520', 'УЛ.ХЪШОВЕ'),
	('00365', '02659', '96534', 'УЛ.ЦАР КАЛОЯН'),
	('00366', '02659', '96548', 'УЛ.ХАН КРУМ'),
	('00367', '02659', '96551', 'УЛ.ЦАР СИМЕОН'),
	('00368', '02659', '96565', 'УЛ.ЦАР ОСВОБОДИТЕЛ'),
	('00369', '02659', '96579', 'УЛ.ЧАВДАРИЦА'),
	('00370', '02659', '96582', 'УЛ.САКАР'),
	('00371', '02659', '96596', 'УЛ.ЦАРЕВЕЦ'),
	('00372', '02659', '96606', 'УЛ.ЧЕШМА II'),
	('00373', '02659', '96610', 'УЛ.ШЕЙНОВО'),
	('00374', '02659', '96623', 'УЛ.ШИПКА'),
	('00375', '02659', '96637', 'УЛ.ЮРИЙ ГАГАРИН'),
	('00376', '02659', '96640', 'УЛ.ЯВОР'),
	('00377', '02659', '96654', 'УЛ.ЯЗОВИРСКИ ПЪТ'),
	('00378', '02659', '96668', 'УЛ.ЯГОДА'),
	('00379', '02659', '96671', 'УЛ.ЯСЕН'),
	('00380', '02659', '96685', 'УЛ.ИВАЙЛО'),
	('00381', '02659', '96699', 'УЛ.ВИСКЯР'),
	('00382', '02659', '96709', 'УЛ.ГОЦЕ ДЕЛЧЕВ'),
	('00383', '02659', '96726', 'УЛ.ЦАНКО ЦЕРКОВСКИ (4-ТА)'),
	('00384', '02659', '96743', 'УЛ.6-ТА'),
	('00385', '02659', '96757', 'УЛ.7-МА'),
	('00386', '02659', '96760', 'УЛ.БРАЦИГОВО (8-МА)'),
	('00387', '02659', '96774', 'УЛ.13-ТА'),
	('00388', '02659', '96788', 'УЛ.НИКОЛА ОБРЕТЕНОВ'),
	('00389', '02659', '96815', 'УЛ.АЛЕКО КОНСТАНТИНОВ'),
	('00390', '02659', '96829', 'УЛ.РОДЕН КЪТ (14-ТА)'),
	('00391', '02659', '96832', 'УЛ.МУСАЛА (15-ТА)'),
	('00392', '02659', '96846', 'УЛ.РЕКАТА'),
	('00393', '02659', '96850', 'УЛ.КРЕСНА'),
	('00394', '02659', '96863', 'УЛ.ПЕРУЩИЦА (19-ТА)'),
	('00395', '02659', '96877', 'УЛ.КАМЧИЯ (25-ТА)'),
	('00396', '02659', '96880', 'УЛ.СЕКВОЯ'),
	('00397', '02659', '96894', 'УЛ.РОДОЛЮБИЕ (27-МА)'),
	('00398', '02659', '96904', 'УЛ.МОСКВА'),
	('00399', '02659', '96918', 'УЛ.РУДОЗЕМ'),
	('00400', '02659', '96921', 'УЛ.СТЕФАН СТАМБОЛОВ'),
	('00401', '02659', '96935', 'УЛ.БРАТЯ МИЛАДИНОВИ'),
	('00402', '02659', '96949', 'УЛ.ЗАХАРИ СТОЯНОВ'),
	('00403', '02659', '97166', 'УЛ.ПЕРСЕНК'),
	('00404', '02659', '97173', 'УЛ.ВАРНА'),
	('00405', '02659', '97183', 'УЛ.ТИНТЯВА'),
	('00406', '02659', '97197', 'УЛ.СТРУМА'),
	('00407', '02659', '97207', 'УЛ.ВЛАДО МАРКОВ'),
	('00408', '02659', '97210', 'УЛ.РОДОПИ'),
	('00409', '02659', '97224', 'УЛ.ГЕОРГИ БЕНКОВСКИ'),
	('00410', '02659', '97238', 'УЛ.ВЕРДИКАЛСКА РЕКА'),
	('00411', '02659', '97241', 'УЛ.ПЕТКО КАРАВЕЛОВ'),
	('00412', '02659', '97255', 'УЛ.ПЛАНА'),
	('00413', '02659', '97269', 'УЛ.ГОРСКИ ПЪТ'),
	('00414', '02659', '97286', 'УЛ.ИЗВОРНА'),
	('00415', '02659', '97299', 'УЛ.ЗВЪН'),
	('00416', '02659', '97304', 'УЛ.ОРЛОВО ГНЕЗДО'),
	('00417', '02659', '97313', 'УЛ.СПЪТНИК'),
	('00418', '02659', '97327', 'УЛ.ЯНТРА'),
	('00419', '02659', '97344', 'УЛ.ДРЕН'),
	('00420', '02659', '97361', 'УЛ.КОМ'),
	('00421', '02659', '97375', 'УЛ.18-ТА'),
	('00422', '02659', '97392', 'УЛ.ПЕРЕ ТОШЕВ'),
	('00423', '02659', '97402', 'УЛ.БАЧО КИРО'),
	('00424', '02659', '97416', 'УЛ.СЕРГЕЙ РУМЯНЦЕВ'),
	('00425', '02659', '97433', 'УЛ.ХАН КАРДАМ'),
	('00426', '02659', '97447', 'УЛ.ХРИСТО ЯСЕНОВ'),
	('00427', '02659', '97478', 'УЛ.ЛЮБЕН КАРАВЕЛОВ'),
	('00428', '02659', '97481', 'УЛ.ИГЛИКА'),
	('00429', '02659', '97495', 'УЛ.ЙОРДАН ЙОВКОВ'),
	('00430', '02659', '97505', 'УЛ.ДАМЕ ГРУЕВ'),
	('00431', '02659', '97519', 'УЛ.ИЗЛЕТ'),
	('00432', '02659', '97522', 'УЛ.АСЕН РАЗЦВЕТНИКОВ'),
	('00433', '02659', '97536', 'УЛ.ПЕНЧО СЛАВЕЙКОВ'),
	('00434', '02659', '97545', 'УЛ.ДИМЧО ДЕБЕЛЯНОВ'),
	('00435', '02659', '97567', 'УЛ.СОЗОПОЛ'),
	('00436', '02659', '97570', 'УЛ.ХАН АСПАРУХ'),
	('00437', '02659', '97584', 'УЛ.БОТЬО ПЕТКОВ'),
	('00438', '02659', '97598', 'УЛ.ГЕН.СТЕФАН СЛАВЧЕВ'),
	('00439', '02659', '97608', 'УЛ.ТОДОР КАБЛЕШКОВ'),
	('00440', '02659', '97611', 'УЛ.АНГЕЛ КЪНЧЕВ'),
	('00441', '02659', '97625', 'УЛ.ШУМАНИЦА'),
	('00442', '02659', '97639', 'УЛ.ВРЪХ БОГДАН'),
	('00443', '02659', '97642', 'УЛ.ТЕПЕТО'),
	('00444', '02659', '97656', 'УЛ.ХАН ОМУРТАГ'),
	('00445', '02659', '97700', 'УЛ.ВАСИЛ ПЕТЛЕШКОВ'),
	('00446', '02659', '97803', 'УЛ.ЕЛА'),
	('00447', '02659', '97817', 'УЛ.ТУТРАКАН'),
	('00448', '02659', '97820', 'УЛ.16-ТА'),
	('00449', '02659', '94006', 'УЛ.МИЛЕНИУМ'),
	('00450', '02659', '94109', 'УЛ.ЛИЛИУМ'),
	('00451', '02659', '97848', 'УЛ.МАДАРА'),
	('00452', '02659', '96342', 'УЛ.СИНЕМОРЕЦ'),
	('00453', '02659', '94112', 'УЛ.ЛИЛИЯ'),
	('00454', '02659', '94126', 'УЛ.ХРИЗАНТЕМА'),
	('00455', '02659', '94130', 'УЛ.АСТРА'),
	('00456', '02659', '97851', 'УЛ.ЕЛЕДЖИК'),
	('00457', '02659', '97865', 'УЛ.МАДАРСКИ КОННИК'),
	('00458', '02659', '95563', 'УЛ.ЛОМ'),
	('00459', '02659', '97879', 'УЛ.БИЗОВИЦА'),
	('00460', '02659', '96952', 'УЛ.ТЕНЕВ БАИР'),
	('00461', '02659', '97272', 'УЛ.БРИЗ'),
	('00462', '02659', '88777', 'УЛ.БОЖУР'),
	('00463', '02659', '88780', 'УЛ.ГЕРГИНА'),
	('00464', '02659', '88794', 'УЛ.КЛОКОТНИЦА'),
	('00465', '02659', '88804', 'УЛ.КОЗЛОДУЙ'),
	('00466', '02659', '99574', 'УЛ.МАЙСКА КИТКА'),
	('00467', '02659', '12019', 'УЛ.НЕВЕН'),
	('00468', '02659', '78207', 'УЛ.ОРХИДЕЯ'),
	('00469', '02659', '99588', 'УЛ.ЕЛИСА'),
	('00470', '02659', '33324', 'УЛ.РАДОВО'),
	('00471', '02659', '24150', 'УЛ.ЗНЕПОЛЕ'),
	('00472', '02659', '24058', 'УЛ.ДУНАВСКО ХОРО'),
	('00473', '02659', '12022', 'УЛ.АКАД.ЛЮБОМИР ЧАКАЛОВ'),
	('00474', '02659', '13487', 'УЛ.АРХ.АТАНАС АГУРА'),
	('00475', '02659', '14489', 'УЛ.ГОРСКО ЦВЕТЕ'),
	('00476', '02659', '98355', 'УЛ.ЖУЛ ЛЕВИ'),
	('00477', '02659', '98034', 'УЛ.ДОБРИН ПЕТКОВ'),
	('00478', '02659', '97882', 'УЛ.КРЪСТЬО МИЯТЕВ'),
	('00479', '02659', '93004', 'УЛ.АЛОЕ'),
	('00480', '02659', '93018', 'УЛ.ГРАДОМАНСКИ ПЪТ'),
	('00481', '02659', '00360', 'УЛ.АВРАМИЦА'),
	('00482', '02659', '00374', 'УЛ.ДАСКАЛ МИТО'),
	('00483', '02659', '97896', 'УЛ.КАРЕЛ ШКОРПИЛ'),
	('00484', '02659', '97714', 'УЛ.РАЙНА КНЯГИНЯ'),
	('00485', '02659', '97906', 'УЛ.МУСАЛА (КВ.ИЗГРЕВ)'),
	('00486', '02659', '99156', 'УЛ.ТЕМЕНУГА'),
	('00487', '02659', '98048', 'УЛ.СЛЪНЧЕВА СКАЛА'),
	('00488', '02659', '39791', 'УЛ.ИВОНИНИ ЛИВАДИ'),
	('00489', '02659', '99632', 'УЛ.3'),
	('00490', '02659', '97834', 'УЛ.ШИПКОВ ХРАСТ'),
	('00491', '02659', '39493', 'УЛ.ЖЪЛТУГА'),
	('00492', '02659', '39640', 'УЛ.ХРИСТО ТРАЯНОВ'),
	('00493', '02659', '38203', 'УЛ.МИРТА'),
	('00494', '02659', '36600', 'УЛ.СТАНИСЛАВ СТРАТИЕВ'),
	('00495', '02659', '38042', 'УЛ.МИТО МЛАДЕНОВ ИВАНОВ'),
	('00496', '04234', '00031', 'УЛ.СПОРТИСТ (3-ТА)'),
	('00497', '04234', '00045', 'УЛ.СЪЛЗИЦА (4-ТА)'),
	('00498', '04234', '00076', 'УЛ.КАМЕНОДЕЛСКА (7-МА)'),
	('00499', '04234', '00084', 'УЛ.ДЕТЕЛИНА (8-МА)'),
	('00500', '04234', '00093', 'УЛ.МАРИНА ПОЛЯНА (9-ТА)'),
	('00501', '04234', '00117', 'УЛ.СИНЧЕЦ (11-ТА)'),
	('00502', '04234', '00120', 'УЛ.ЯНЧОВСКА РЕКА'),
	('00503', '04234', '00148', 'УЛ.ПЕРУНИКА (14-ТА)'),
	('00504', '04234', '00151', 'УЛ.АЛЕКО (15-ТА)'),
	('00505', '04234', '00165', 'УЛ.РЕЗНЬОВЕТЕ (16-ТА)'),
	('00506', '04234', '00179', 'УЛ.КАТУНИЩЕ'),
	('00507', '04234', '00182', 'УЛ.ХАЙДУШКИ ЧУКАР (18-ТА)'),
	('00508', '04234', '00206', 'УЛ.СТАРА РЕКА (20-ТА)'),
	('00509', '04234', '00223', 'УЛ.ХРИЗАНТЕМА'),
	('00510', '04234', '00237', 'УЛ.ЯБЪЛКОВА ГРАДИНА'),
	('00511', '04234', '00268', 'УЛ.БОРОВА ГОРА'),
	('00512', '04234', '00271', 'УЛ.ПРОСВЕТА'),
	('00513', '04234', '00285', 'УЛ.ШИПКА'),
	('00514', '04234', '00299', 'УЛ.ЩАСТЛИВЕЦА'),
	('00515', '04234', '00309', 'УЛ.КАЛУГЕРИЦА'),
	('00516', '04234', '00312', 'УЛ.МИНЗУХАР'),
	('00517', '04234', '00326', 'УЛ.ВИТОША'),
	('00518', '04234', '00330', 'УЛ.ЕДЕЛВАЙС'),
	('00519', '04234', '00343', 'УЛ.КООПЕРАТИВЕН ТРУД'),
	('00520', '04234', '00357', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('00521', '04234', '00360', 'УЛ.ТИНТЯВА (36-ТА)'),
	('00522', '04234', '00374', 'УЛ.МЛАДОСТ (37-МА)'),
	('00523', '04234', '00388', 'УЛ.МАЛИ ДОЛ'),
	('00524', '04234', '00391', 'УЛ.МЛАДЕН АНГЕЛОВ (39-ТА)'),
	('00525', '04234', '00415', 'УЛ.ПРОФ.ТРАЙКО ЗАПРЯНОВ'),
	('00526', '04234', '00429', 'УЛ.ИВАЙЛО (42-РА)'),
	('00527', '04234', '00432', 'УЛ.ВЕНЕЦ'),
	('00528', '04234', '00446', 'УЛ.КАЛИНА (44-ТА)'),
	('00529', '04234', '00456', 'УЛ.БАНОВЕЦ (45-ТА)'),
	('00530', '04234', '00463', 'УЛ.ШОПСКО ХОРО (46-ТА)'),
	('00531', '04234', '00477', 'УЛ.ШОПЛУК'),
	('00532', '04234', '00480', 'УЛ.БУЧАРО'),
	('00533', '04234', '00494', 'УЛ.ПРЕСПА (49-ТА)'),
	('00534', '04234', '00504', 'УЛ.БЕЛИКАТА'),
	('00535', '04234', '00518', 'УЛ.ТРЕПЕТЛИКА (51-ВА)'),
	('00536', '04234', '00521', 'УЛ.ГЪБЕШНИЦА (52-РА)'),
	('00537', '04234', '00535', 'УЛ.ТОПОЛИТЕ (53-ТА)'),
	('00538', '04234', '00549', 'УЛ.КЛИСУРГОВЕЦ'),
	('00539', '04234', '00552', 'УЛ.ЧЕМШИР'),
	('00540', '04234', '00566', 'УЛ.ЯГОДА (56-ТА)'),
	('00541', '04234', '00571', 'УЛ.ЛЮЛЯК'),
	('00542', '04234', '00583', 'УЛ.ВЕДРИНА'),
	('00543', '04234', '00597', 'УЛ.ЦВЕТНА ГРАДИНА (59-ТА)'),
	('00544', '04234', '00607', 'УЛ.ЧИПРОВИЦА (60-ТА)'),
	('00545', '04234', '00610', 'УЛ.ПЧЕЛАРСКА (61-ВА)'),
	('00546', '04234', '00624', 'УЛ.ВЕЧЕРНИЦА (62-РА)'),
	('00547', '04234', '00638', 'УЛ.ЗОРНИЦА (63-ТА)'),
	('00548', '04234', '00641', 'УЛ.ЛАТИНКА (64-ТА)'),
	('00549', '04234', '00655', 'УЛ.ВИТОШКО ЛАЛЕ'),
	('00550', '04234', '00669', 'УЛ.ЗАГРЕНЕ'),
	('00551', '04234', '00672', 'УЛ.КРИВОЛАК'),
	('00552', '04234', '00686', 'УЛ.БИСТРИШКА ЧЕТВОРКА (68-МА)'),
	('00553', '04234', '00697', 'УЛ.ВАСИЛ ЛЕВСКИ (69-ТА)'),
	('00554', '04234', '00702', 'УЛ.ПАМЕТНИКА'),
	('00555', '04234', '00727', 'УЛ.3-ТИ МАРТ'),
	('00556', '04234', '01025', 'УЛ.ГОРСКИ ПЪТ'),
	('00557', '04234', '01050', 'УЛ.БРЕЗА'),
	('00558', '04234', '01119', 'УЛ.ВЪРЛА ПОЛЯНА (111-ТА)'),
	('00559', '04234', '01122', 'УЛ.МАЛИНА'),
	('00560', '04234', '01136', 'УЛ.8-МИ МАРТ'),
	('00561', '04234', '01153', 'УЛ.ЧЕРНИ ВРЪХ'),
	('00562', '04234', '01167', 'УЛ.БУКЕТ'),
	('00563', '04234', '01208', 'УЛ.ДЪБОВА ГОРА'),
	('00564', '04234', '01290', 'УЛ.ЛИПА'),
	('00565', '04234', '01362', 'УЛ.КАПИНА'),
	('00566', '04234', '01376', 'УЛ.МОРЕНИТЕ'),
	('00567', '04234', '01393', 'УЛ.БОЖУР'),
	('00568', '04234', '01403', 'УЛ.РОЗА'),
	('00569', '04234', '01417', 'УЛ.КОСМОНАВТ'),
	('00570', '04234', '01420', 'УЛ.РОСИЦА'),
	('00571', '04234', '01434', 'УЛ.МОМИН ПРОХОД'),
	('00572', '04234', '01448', 'УЛ.БИСТРИШКО БРАНИЩЕ'),
	('00573', '04234', '01479', 'УЛ.СВЕТА ПЕТКА (МИР)'),
	('00574', '04234', '01482', 'УЛ.ЦАР АСЕНОВ ПЪТ'),
	('00575', '04234', '01496', 'УЛ.МАНАСТИРА'),
	('00576', '04234', '01506', 'УЛ.ИВАТА'),
	('00577', '04234', '01512', 'УЛ.БОГДАНА'),
	('00578', '04234', '01523', 'УЛ.ПЛАДНИЩЕТО'),
	('00579', '04234', '01537', 'УЛ.ДЖЕЙМЗ БАУЧЪР'),
	('00580', '04234', '01599', 'УЛ.ЧУЧУЛИГА'),
	('00581', '04234', '01609', 'УЛ.ПРОЛЕТ'),
	('00582', '04234', '01612', 'УЛ.СИНИГЕР'),
	('00583', '04234', '32980', 'УЛ.4-ТА (МАЛИНОВА ДОЛИНА)'),
	('00584', '04234', '17083', 'УЛ.МАНАСТИРСКА(В.З.МАНАСТИРА)'),
	('00585', '04234', '18023', 'УЛ.НЕЗАБРАВКА'),
	('00586', '04234', '00196', 'УЛ.БИСТРИШКО ШОСЕ'),
	('00587', '04234', '03441', 'УЛ.СИМЕОНОВСКО ШОСЕ'),
	('00588', '04234', '01701', 'УЛ.1 (МАЛИНОВА ДОЛИНА)'),
	('00589', '04234', '02498', 'УЛ.27 (МАЛИНОВА ДОЛИНА-ГЕРЕНА)'),
	('00590', '04234', '02511', 'УЛ.38(МАЛИНОВА ДОЛИНА-БУНКЕРА)'),
	('00591', '04234', '02508', 'УЛ.43 (МАЛИНОВА ДОЛИНА-ГЕРЕНА)'),
	('00592', '04234', '01804', 'УЛ.5 (МАЛИНОВА ДОЛИНА)'),
	('00593', '04234', '01715', 'УЛ.8 (МАЛИНОВА ДОЛИНА)'),
	('00594', '04234', '00028', 'УЛ.НИКОЛА КРУШКИН (2-РА)'),
	('00595', '04234', '00014', 'УЛ.СТЕФАН СТАМБОЛОВ(НИК.ПОПОВ)'),
	('00596', '04234', '20571', 'УЛ.29-ТА (В.З.МАЛИНОВА ДОЛИНА)'),
	('00597', '04234', '04755', 'УЛ.ГОРАТА'),
	('00598', '04234', '12245', 'УЛ.БУЙНОВСКО ЖДРЕЛО (КАЛФ.ДОЛ)'),
	('00599', '04234', '12259', 'УЛ.СТРЯМА (КАЛФИН ДОЛ)'),
	('00600', '04234', '12262', 'УЛ.ПОЛЕЖАН (КАЛФИН ДОЛ)'),
	('00601', '04234', '12276', 'УЛ.СИВА ГРАМАДА (КАЛФИН ДОЛ)'),
	('00602', '04234', '12283', 'УЛ.ЯРЛОВСКИ КУПЕН (КАЛФИН ДОЛ)'),
	('00603', '04234', '10001', 'УЛ.ХУБАВО ПОЛЕ (КОСАНИН ДОЛ)'),
	('00604', '04234', '10015', 'УЛ.ЗАБЕЛ (КОСАНИН ДОЛ)'),
	('00605', '04234', '10029', 'УЛ.ПЕПЕЛИВ РИД (КОСАНИН ДОЛ)'),
	('00606', '04234', '10032', 'УЛ.МРАЗОВЕЦ (КОСАНИН ДОЛ)'),
	('00607', '04234', '10046', 'УЛ.СТАРОПЛАНИНСКИ ЛЕГЕНДИ'),
	('00608', '04234', '10050', 'УЛ.ЕСЕННИ МОТИВИ (КОСАНИН ДОЛ)'),
	('00609', '04234', '10063', 'УЛ.ВЕТРЕНАТА МЕЛНИЦА (КОС.ДОЛ)'),
	('00610', '04234', '10077', 'УЛ.ЛОБЕЛИЯ (КОСАНИН ДОЛ)'),
	('00611', '04234', '10080', 'УЛ.ПОПОВ ИЗВОР (КОСАНИН ДОЛ)'),
	('00612', '04234', '10094', 'УЛ.БАНИЩЕ (КОСАНИН ДОЛ)'),
	('00613', '04234', '10104', 'УЛ.БАЛКАНСКИ РОЗИ (КОСАН. ДОЛ)'),
	('00614', '04234', '10118', 'УЛ.ТЪЖА (КОСАНИН ДОЛ)'),
	('00615', '04234', '10121', 'УЛ.МОМИНА ПОЛЯНА (КОСАНИН ДОЛ)'),
	('00616', '04234', '10135', 'УЛ.ПЛАНИНСКИ ИЗВОРИ'),
	('00617', '04234', '10149', 'УЛ.СКОПАРНИК (КОСАНИН ДОЛ)'),
	('00618', '04234', '10152', 'УЛ.БУКОВЕЦ (КОСАНИН ДОЛ)'),
	('00619', '04234', '10166', 'УЛ.ПЕТРОВ КРЪСТ (КОСАНИН ДОЛ)'),
	('00620', '04234', '10176', 'УЛ.МОРОВИЦА (КОСАНИН ДОЛ)'),
	('00621', '04234', '10183', 'УЛ.СТРАЖАТА (КОСАНИН ДОЛ)'),
	('00622', '04234', '10197', 'УЛ.ЛОПУШКИ ВРЪХ (КОСАНИН ДОЛ)'),
	('00623', '04234', '10207', 'УЛ.ЕЛЕНИ ВРЪХ (КОСАНИН ДОЛ)'),
	('00624', '04234', '10210', 'УЛ.ПОНОРА (КОСАНИН ДОЛ)'),
	('00625', '04234', '10224', 'УЛ.ВЪРХОВРЪХ (КОСАНИН ДОЛ)'),
	('00626', '04234', '10238', 'УЛ.МИЛЕВИ СКАЛИ (КОСАН.ДОЛ)'),
	('00627', '04234', '10241', 'УЛ.СИНИ ВРЪХ (КОСАНИН ДОЛ)'),
	('00628', '04234', '10255', 'УЛ.СКАЛНИ МОСТОВЕ(КОСАНИН ДОЛ)'),
	('00629', '04234', '10269', 'УЛ.ЗАЕКА (КОСАНИН ДОЛ)'),
	('00630', '04234', '10272', 'УЛ.ГОЛЯМА ТОДОРКА(КОСАНИН ДОЛ)'),
	('00631', '04234', '10286', 'УЛ.ЯГОДИНСКА ПЕЩЕРА (КОС. ДОЛ)'),
	('00632', '04234', '10291', 'УЛ.МАЯНИЦА (КОСАНИН ДОЛ)'),
	('00633', '04234', '10307', 'УЛ.СРЕБЪРНО КОПИЕ(КОСАНИН ДОЛ)'),
	('00634', '04234', '10313', 'УЛ.ТЕВНО ЕЗЕРО (КОСАНИН ДОЛ)'),
	('00635', '04234', '10327', 'УЛ.МЕЧИ ВРЪХ (КОСАНИН ДОЛ)'),
	('00636', '04234', '10330', 'УЛ.ДЪЛГОТО ЕЗЕРО (КОСАНИН ДОЛ)'),
	('00637', '04234', '10344', 'УЛ.МУРАТОВО ЕЗЕРО(КОСАНИН ДОЛ)'),
	('00638', '04234', '10358', 'УЛ.ТОРФЕНО БРАНИЩЕ (КОС. ДОЛ)'),
	('00639', '04234', '10361', 'УЛ.ЧЕРНИ ИСКЪР (КОСАНИН ДОЛ)'),
	('00640', '04234', '10375', 'УЛ.ЧАШКОДРЯН (КОСАНИН ДОЛ)'),
	('00641', '04234', '10389', 'УЛ.ГОРНО ЛИВАДЕ (КОСАНИН ДОЛ)'),
	('00642', '04234', '10392', 'УЛ.СЕВАР (КОСАНИН ДОЛ)'),
	('00643', '04234', '10402', 'УЛ.СМОКИНЯ (КОСАНИН ДОЛ)'),
	('00644', '04234', '10416', 'УЛ.НАР (КОСАНИН ДОЛ)'),
	('00645', '04234', '10422', 'УЛ.ГЛОГ (КОСАНИН ДОЛ)'),
	('00646', '04234', '10433', 'УЛ.НОЛИНА (КОСАНИН ДОЛ)'),
	('00647', '04234', '10447', 'УЛ.ЖЕРАВ (КОСАНИН ДОЛ)'),
	('00648', '04234', '10450', 'УЛ.СОКОЛ (КОСАНИН ДОЛ)'),
	('00649', '04234', '10464', 'УЛ.РАЙСКА ПТИЦА (КОСАНИН ДОЛ)'),
	('00650', '04234', '10478', 'УЛ.ЗИМА (КОСАНИН ДОЛ)'),
	('00651', '04234', '10481', 'УЛ.ЕВКАЛИПТ (КОСАНИН ДОЛ)'),
	('00652', '04234', '10495', 'УЛ.СТЕВИЯ (КОСАНИН ДОЛ)'),
	('00653', '04234', '10505', 'УЛ.РУСЕЛИЯ (КОСАНИН ДОЛ)'),
	('00654', '04234', '10519', 'УЛ.МЕКИШ (КОСАНИН ДОЛ)'),
	('00655', '04234', '10522', 'УЛ.ВЪРБИНКА (КОСАНИН ДОЛ)'),
	('00656', '04234', '10536', 'УЛ.ВЕЛИКДЕНЧЕ (КОСАНИН ДОЛ)'),
	('00657', '04234', '10548', 'УЛ.РАНИЛИСТ (КОСАНИН ДОЛ)'),
	('00658', '04234', '10553', 'УЛ.ВЕТРОГОН (КОСАНИН ДОЛ)'),
	('00659', '04234', '10567', 'УЛ.АМАРАНТ (КОСАНИН ДОЛ)'),
	('00660', '04234', '10570', 'УЛ.СЕДЕФЧЕ (КОСАНИН ДОЛ)'),
	('00661', '04234', '10584', 'УЛ.МАРКОВИ КЛАДЕНЦИ (КОС.ДОЛ)'),
	('00662', '04234', '10598', 'УЛ.КРЕМЕНСКО ЕЗЕРО (КОСАН.ДОЛ)'),
	('00663', '04234', '12901', 'УЛ.СВЕТИ ЙОАН КРЪСТИТЕЛ'),
	('00664', '04234', '15000', 'УЛ.БЯЛА РЕКА (В.З. МАЛ.ДОЛИНА)'),
	('00665', '04234', '15014', 'УЛ.КЛЕН (В.З.МАЛИНОВА ДОЛИНА)'),
	('00666', '04234', '15028', 'УЛ.ЕСЕН (В.З.МАЛИНОВА ДОЛИНА)'),
	('00667', '04234', '15031', 'УЛ.ЖЪТВА (В.З.МАЛИНОВА ДОЛИНА)'),
	('00668', '04234', '15045', 'УЛ.ПОЛСКИ БРЯСТ (МАЛ.ДОЛИНА)'),
	('00669', '04234', '15059', 'УЛ.МАЛИНАЖА (МАЛИНОВА ДОЛИНА)'),
	('00670', '04234', '15062', 'УЛ.ШИБИЛ (В.З.МАЛИНОВА ДОЛИНА)'),
	('00671', '04234', '15076', 'УЛ.ЗЕФИР (В.З.МАЛИНОВА ДОЛИНА)'),
	('00672', '04234', '15085', 'УЛ.АРХ.ИВАН ТАТАРОВ'),
	('00673', '04234', '15093', 'УЛ.ШИРОКИ ПЪТ (МАЛ. ДОЛИНА)'),
	('00674', '04234', '15103', 'УЛ.ВОЛОВАР (МАЛИНОВА ДОЛИНА)'),
	('00675', '04234', '15117', 'УЛ.ПЕЙОВА БУКА (МАЛ. ДОЛИНА)'),
	('00676', '04234', '15120', 'УЛ.РАЙЧОВА ДУПКА (МАЛ.ДОЛИНА)'),
	('00677', '04234', '15134', 'УЛ.БЛАЖИЦА (МАЛИНОВА ДОЛИНА)'),
	('00678', '04234', '15148', 'УЛ.ЗЕЛЕНИ ВРЪХ (МАЛ.ДОЛИНА)'),
	('00679', '04234', '15151', 'УЛ.ТРИЛИСТНИК (МАЛ.ДОЛИНА)'),
	('00680', '04234', '15165', 'УЛ.ОРЛОВО БЛАТО (МАЛ.ДОЛИНА)'),
	('00681', '04234', '15179', 'УЛ.ПАПУР (МАЛИНОВА ДОЛИНА)'),
	('00682', '04234', '15182', 'УЛ.БЕЛИ ЛОМ (МАЛИНОВА ДОЛИНА)'),
	('00683', '04234', '15196', 'УЛ.ДЕЛЕЙНА (МАЛИНОВА ДОЛИНА)'),
	('00684', '04234', '15206', 'УЛ.ЖРЕБЧЕВО (МАЛИНОВА ДОЛИНА)'),
	('00685', '04234', '15216', 'УЛ.ДУШАНЦИ (МАЛИНОВА ДОЛИНА)'),
	('00686', '04234', '15223', 'УЛ.ЙОВКОВЦИ (МАЛИНОВА ДОЛИНА)'),
	('00687', '04234', '15237', 'УЛ.КОПРИНКА (В.З.БУНКЕРА)'),
	('00688', '04234', '15240', 'УЛ.ДЯВОЛСКА РЕКА (В.З.БУНКЕРА)'),
	('00689', '04234', '15254', 'УЛ.ЧЕРНА РЕКА (В.З.БУНКЕРА)'),
	('00690', '04234', '15268', 'УЛ.ПЛИТВИШКИ ЕЗЕРА (БУНКЕРА)'),
	('00691', '04234', '15271', 'УЛ.ДУХЛАТА (В.З. БУНКЕРА)'),
	('00692', '04234', '15285', 'УЛ.ОРФЕЕВИ СКАЛИ (БУНКЕРА)'),
	('00693', '04234', '15299', 'УЛ.ЛЕЩАВА (В.З. БУНКЕРА)'),
	('00694', '04234', '15309', 'УЛ.БУКОВА ПЛАНИНА (БУНКЕРА)'),
	('00695', '04234', '15312', 'УЛ.ЮРУШКА ЦЪРКВА (БУНКЕРА)'),
	('00696', '04234', '15326', 'УЛ.ШИШМАНКА (В.З. БУНКЕРА)'),
	('00697', '04234', '15331', 'УЛ.САМОДИВСКИ ЕЗЕРА (БУНКЕРА)'),
	('00698', '04234', '15343', 'УЛ.ЕЛЕНСКИ ЕЗЕРА (БУНКЕРА)'),
	('00699', '04234', '15357', 'УЛ.БУКА (В.З.МАЛИНОВА ДОЛИНА)'),
	('00700', '04234', '15360', 'УЛ.БАШЛИЙСКИ ЕЗЕРА (МАЛ.ДОЛИНА'),
	('00701', '04234', '15374', 'УЛ.РЕКА ВЕДЕНА (МАЛ.ДОЛИНА)'),
	('00702', '04234', '15388', 'УЛ.ПРЕСЛАП (МАЛИНОВА ДОЛИНА)'),
	('00703', '04234', '15391', 'УЛ.ТРЕЩЕНИК (МАЛ.ДОЛИНА)'),
	('00704', '04234', '15401', 'УЛ.ЧИСТА ГОРА (МАЛ.ДОЛИНА)'),
	('00705', '04234', '15415', 'УЛ.ВОДИСЛАВ (МАЛ.ДОЛИНА)'),
	('00706', '04234', '15429', 'УЛ.РЕКА ПАЛАКАРИЯ (МАЛ.ДОЛИНА)'),
	('00707', '04234', '15432', 'УЛ.КАМЕН РИД (МАЛ.ДОЛИНА)'),
	('00708', '04234', '15446', 'УЛ.АРАПИЦА (МАЛИНОВА ДОЛИНА)'),
	('00709', '04234', '15457', 'УЛ.МУРГАНА (МАЛИНОВА ДОЛИНА)'),
	('00710', '04234', '15463', 'УЛ.ЛУДА РЕКА (МАЛ.ДОЛИНА)'),
	('00711', '04234', '15477', 'УЛ.ВЪРЛА РЕКА (МАЛ.ДОЛИНА)'),
	('00712', '04234', '15480', 'УЛ.ДЯДОВИК (МАЛ.ДОЛИНА)'),
	('00713', '04234', '15494', 'УЛ.ТИЧИНО (МАЛИНОВА ДОЛИНА)'),
	('00714', '04234', '15504', 'УЛ.НАДАРИШКО ЕЗЕРО (МАЛ.ДОЛИНА'),
	('00715', '04234', '15518', 'УЛ.СИЛЯН (МАЛИНОВА ДОЛИНА)'),
	('00716', '04234', '15521', 'УЛ.СТУДЕНА (МАЛИНОВА ДОЛИНА)'),
	('00717', '04234', '15535', 'УЛ.БОХОВСКА ПЛАНИНА(МАЛ.ДОЛИНА'),
	('00718', '04234', '15549', 'УЛ.ВРЕЛОТО (МАЛИНОВА ДОЛИНА)'),
	('00719', '04234', '15552', 'УЛ.ХОТНИШКИ ВОДОПАД(МАЛ.ДОЛИНА'),
	('00720', '04234', '15566', 'УЛ.ЛЮБАШ (МАЛИНОВА ДОЛИНА)'),
	('00721', '04234', '15572', 'УЛ.ЧУДИНСКА ПЛАНИНА (БУНКЕРА)'),
	('00722', '04234', '15583', 'УЛ.СОКОЛНА (МАЛИНОВА ДОЛИНА)'),
	('00723', '04234', '15597', 'УЛ.КАМЕННА РЕКА (МАЛ.ДОЛИНА)'),
	('00724', '04234', '15607', 'УЛ.ДАФИНА (МАЛИНОВА ДОЛИНА)'),
	('00725', '04234', '16242', 'УЛ.ЕГУЛЯ (МАЛИНОВА ДОЛИНА)'),
	('00726', '04234', '15610', 'УЛ.МАЛЪК РЕЗЕН(МАЛ.ДОЛИНА)'),
	('00727', '04234', '15624', 'УЛ.ГОЛЕМИ ДОЛ'),
	('00728', '04234', '15638', 'УЛ.КАРАЧИАР (КОСАНИН ДОЛ)'),
	('00729', '04234', '16122', 'УЛ.КЛЕН(В.З.МАЛИНОВА ДОЛНА)'),
	('00730', '04234', '16239', 'УЛ.РАКОВЕЦ (В.З.ШУМАКО)'),
	('00731', '04234', '16136', 'УЛ.СЛАВЕЙ (В.З.МАНАСТИРА)'),
	('00732', '04234', '18037', 'УЛ.ИГЛИКА'),
	('00733', '04234', '17659', 'УЛ.ПРАВЕЦ'),
	('00734', '04234', '16482', 'УЛ.КЛЕНО (В.З.МАНАСТИРА)'),
	('00735', '04234', '18616', 'УЛ.ИЗГЛЕД'),
	('00736', '04234', '18620', 'УЛ.ОРЕШКОВИЦА'),
	('00737', '04234', '18647', 'УЛ.САМОДИВСКО ЦВЕТЕ'),
	('00738', '04234', '18650', 'УЛ.МЕНЧЕТО'),
	('00739', '04234', '18664', 'УЛ.ПОЛСКИ ХВОЩ'),
	('00740', '04234', '18678', 'УЛ.САМАРСКА РЕКА'),
	('00741', '04234', '18681', 'УЛ.ТОНКИНА РЕКА'),
	('00742', '04234', '17720', 'УЛ.ВЕДРИЦА'),
	('00743', '04234', '17734', 'УЛ.ОБРОК'),
	('00744', '04234', '98630', 'УЛ.СТРУМСКИ ИЗВОР'),
	('00745', '04234', '98644', 'УЛ.ВЕТРОВАЛ'),
	('00746', '07106', '00014', 'УЛ.КИРИЛ И МЕТОДИЙ(12 И 14)'),
	('00747', '07106', '00028', 'УЛ.АСЕН ИГНАТОВ (16-ТА)'),
	('00748', '07106', '00045', 'УЛ.ВУЧКО ИГНАТОВ (23-ТА)'),
	('00749', '07106', '00059', 'УЛ.РОДИНАТА (21-ВА)'),
	('00750', '07106', '00062', 'УЛ.БЕГОВИЦА (2-РА)'),
	('00751', '07106', '00076', 'УЛ.ВЛАДИМИР ГЕОРГИЕВ (4-ТА)'),
	('00752', '07106', '00084', 'УЛ.ГЕН.ГУРКО (27 И 10)'),
	('00753', '07106', '00093', 'УЛ.КРИВА ЛИВАДА (3-ТА)'),
	('00754', '07106', '00103', 'УЛ.Д-Р ИВАН СТАМЕНОВ (24-ТА)'),
	('00755', '07106', '00117', 'УЛ.ТРОЯНСКИ ПЪТ (18 И 19)'),
	('00756', '07106', '00120', 'УЛ.ЛАШОВА (15-ТА)'),
	('00757', '07106', '00148', 'УЛ.ПЧЕЛИНА (20-ТА)'),
	('00758', '07106', '00165', 'УЛ.ПРОСВЕТА (1-ВА)'),
	('00759', '07106', '00179', 'УЛ.СРЕДНО ЛИВАДЕ (31-ВА)'),
	('00760', '07106', '00182', 'УЛ.СУХ ИСКЪР (13-ТА)'),
	('00761', '07106', '00196', 'УЛ.ПЕРУНИКА (11-ТА)'),
	('00762', '07106', '00206', 'УЛ.МОМА ИРИНА (5-ТА)'),
	('00763', '07106', '00215', 'УЛ.ДЕТСКА РАДОСТ (30-ТА)'),
	('00764', '07106', '00223', 'УЛ.ЛОВДЖИЙСКА (22-РА)'),
	('00765', '07106', '00240', 'УЛ.ЧУКУРА (29-ТА)'),
	('00766', '07106', '00254', 'УЛ.МИЛИН КАМЪК (17-ТА)'),
	('00767', '07106', '00268', 'УЛ.ГЪЛЪБЕЦ (25-ТА)'),
	('00768', '07106', '00271', 'УЛ.ЦИКЛАМА (7-МА)'),
	('00769', '07106', '00285', 'УЛ.ПРОБУДА (6-ТА)'),
	('00770', '07106', '00309', 'УЛ.ТАТАРСКИ ПЪТ (26 И 28)'),
	('00771', '07106', '00326', 'УЛ.6-ТИ МАЙ'),
	('00772', '07106', '00401', 'ПЛ.ЕЛИН ПЕЛИН'),
	('00773', '07140', '85010', 'УЛ.АНДРЕЙ СТОИЧКОВ'),
	('00774', '07140', '85038', 'УЛ.АТАНАС СПАСОВ'),
	('00775', '07140', '85041', 'УЛ.БОГДАН ДЕЧЕВ'),
	('00776', '07140', '85055', 'УЛ.БОЛНИЧНА'),
	('00777', '07140', '85072', 'УЛ.БРЕГАЛНИЦА'),
	('00778', '07140', '85086', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('00779', '07140', '85105', 'УЛ.ВИТОША'),
	('00780', '07140', '85113', 'УЛ.ГЕОРГИ РАКОВСКИ'),
	('00781', '07140', '85127', 'УЛ.ГОРОЦВЕТ'),
	('00782', '07140', '85130', 'УЛ.ГОТЕН'),
	('00783', '07140', '85144', 'УЛ.ГРАДИНА'),
	('00784', '07140', '85158', 'УЛ.САН СТЕФАНО'),
	('00785', '07140', '85161', 'УЛ.ТРЕТИ МАРТ'),
	('00786', '07140', '85189', 'УЛ.ДЕТЕЛИНА'),
	('00787', '07140', '85192', 'УЛ.ДЯДО МИЛОТИН'),
	('00788', '07140', '85216', 'УЛ.ЗДРАВЕЦ'),
	('00789', '07140', '85220', 'УЛ.ИГЛИКА'),
	('00790', '07140', '85233', 'УЛ.КАМЪКА'),
	('00791', '07140', '85247', 'УЛ.КИРИЛ И МЕТОДИЙ'),
	('00792', '07140', '85264', 'УЛ.ЛАЗАР ПЕШЕВ'),
	('00793', '07140', '85281', 'УЛ.МУРГАШ'),
	('00794', '07140', '85295', 'УЛ.НИКОЛА БОНЕВ'),
	('00795', '07140', '85346', 'УЛ.1-ВИ МАЙ'),
	('00796', '07140', '85353', 'УЛ.РИЛА'),
	('00797', '07140', '85367', 'УЛ.СРЕДО БЪРДО'),
	('00798', '07140', '85370', 'УЛ.СТАРА ПЛАНИНА'),
	('00799', '07140', '85384', 'УЛ.СТЕФАН И ВЕЛКО'),
	('00800', '07140', '85398', 'УЛ.СТЕФАН ВИТКОВ'),
	('00801', '07140', '85439', 'УЛ.СТЕФАН КАРАДЖА'),
	('00802', '07140', '85456', 'УЛ.СТЕФАН КУЦАРОВ'),
	('00803', '07140', '85461', 'УЛ.СТОЯН ИЛИЕВ'),
	('00804', '07140', '85473', 'УЛ.СТРУМА'),
	('00805', '07140', '85487', 'УЛ.ТЕМЕНУЖКА'),
	('00806', '07140', '85490', 'УЛ.ХРИСТО БОТЕВ'),
	('00807', '07140', '85500', 'УЛ.ЧАВДАР ВОЙВОДА'),
	('00808', '07140', '85514', 'УЛ.ЧЕМШИР'),
	('00809', '07140', '85528', 'УЛ.ЧЕРНИЦА'),
	('00810', '07140', '85531', 'УЛ.ЧУЧУРА'),
	('00811', '07140', '85545', 'УЛ.ШЕЙНОВО'),
	('00812', '07140', '85559', 'УЛ.ШИПКА'),
	('00813', '07140', '85562', 'УЛ.ШУМНИ ДОЛ'),
	('00814', '07140', '85576', 'УЛ.ЯНТРА'),
	('00815', '07140', '85723', 'УЛ.ЗАХАРИ ПОПОВ'),
	('00816', '07140', '85737', 'УЛ.ДАНАИЛ БЕНЕВ'),
	('00817', '07140', '85754', 'УЛ.ПАНАЙОТ ВОЛОВ'),
	('00818', '07140', '85024', 'УЛ.МИНА БУХОВО'),
	('00819', '07140', '80162', 'УЛ.СЕСЛАВСКИ ПЪТ'),
	('00820', '07140', '80176', 'УЛ.КРАЙГРАДСКА'),
	('00821', '07140', '80180', 'УЛ.ВОДЕН БИК'),
	('00822', '07140', '80193', 'УЛ.АНДРЕЯ МАНЧОВ'),
	('00823', '07140', '80203', 'УЛ.РОСНИ ЛИВАДИ'),
	('00824', '07140', '80217', 'УЛ.ЮЖЕН СКЛОН'),
	('00825', '11394', '00014', 'УЛ.СРЕБРИСТ БОР'),
	('00826', '11394', '00028', 'УЛ.ЯНКИНО УСОЕ'),
	('00827', '11394', '00031', 'УЛ.ВОЙНИШКО ВЪСТАНИЕ'),
	('00828', '11394', '00045', 'УЛ.БРЕЗОВА ГОРА'),
	('00829', '11394', '00059', 'УЛ.БЕЛИ БРЕГ'),
	('00830', '11394', '00062', 'УЛ.ВЪРБИТЕ'),
	('00831', '11394', '00076', 'УЛ.ПРОФ.ИВАН ШИШМАНОВ'),
	('00832', '11394', '00084', 'УЛ.ЮРУШКИ МОСТОВЕ'),
	('00833', '11394', '00093', 'УЛ.ПЛИСКА'),
	('00834', '11394', '00103', 'УЛ.ЛЮБОМИР МИЛАНОВ'),
	('00835', '11394', '00117', 'УЛ.БАЛАБАНОВЕЦ'),
	('00836', '11394', '00120', 'УЛ.АКАДЕМИК ПЕТКО СТАЙНОВ'),
	('00837', '11394', '00134', 'УЛ.АЛЕКО КОНСТАНТИНОВ(ОФЕЛИИТЕ'),
	('00838', '11394', '00148', 'УЛ.ШИПЕТО'),
	('00839', '11394', '00151', 'УЛ.ЕЛА'),
	('00840', '11394', '00179', 'УЛ.БУКОВ ДОЛ'),
	('00841', '11394', '00182', 'УЛ.ОРНИЦА'),
	('00842', '11394', '00196', 'УЛ.ПРИПЛАТ'),
	('00843', '11394', '00206', 'УЛ.РЕКАТА'),
	('00844', '11394', '00215', 'УЛ.СЪРНА'),
	('00845', '11394', '00223', 'УЛ.АЛЕКО КОНСТАНТИНОВ(К.ДИМИТР'),
	('00846', '11394', '00237', 'УЛ.ВИРОВ ДОЛ'),
	('00847', '11394', '00240', 'УЛ.КАЙЛЪКА'),
	('00848', '11394', '00254', 'УЛ.КАЛИНИЦА'),
	('00849', '11394', '00268', 'УЛ.АМБАРИЦА'),
	('00850', '11394', '00271', 'УЛ.ВИТОШКИ ГРАНИТ'),
	('00851', '11394', '00285', 'УЛ.БИСТЪР ПОТОК'),
	('00852', '11394', '00299', 'УЛ.РАВНИЩЕ'),
	('00853', '11394', '00309', 'УЛ.ЛЕСКОВЕЦ'),
	('00854', '11394', '00312', 'УЛ.БОРОВИНКА'),
	('00855', '11394', '00330', 'УЛ.ТОПОЛИТЕ'),
	('00856', '11394', '00343', 'УЛ.ЗДРАВЕЦ'),
	('00857', '11394', '00357', 'УЛ.ЕЛЕН'),
	('00858', '11394', '00360', 'УЛ.ЧАЛАДИНКА'),
	('00859', '11394', '00374', 'УЛ.МОРЕНИТЕ'),
	('00860', '11394', '00388', 'УЛ.КИТЕН'),
	('00861', '11394', '00391', 'УЛ.МОМИНА СЪЛЗА'),
	('00862', '11394', '00401', 'УЛ.ПРЕВАЛСКИ ЕЗЕРА'),
	('00863', '11394', '00415', 'УЛ.ПОЛСКИ СИНЧЕЦ'),
	('00864', '11394', '00429', 'УЛ.МАРИН ЧУКАР'),
	('00865', '11394', '00432', 'УЛ.ЖЪЛТА ВОДА'),
	('00866', '11394', '00456', 'УЛ.МАРГАРИТКА'),
	('00867', '11394', '00463', 'УЛ.СЛЪНЧЕВ ЗАЛЕЗ'),
	('00868', '11394', '00477', 'УЛ.СПОРТИСТ'),
	('00869', '11394', '00494', 'УЛ.СТРАНАТА'),
	('00870', '11394', '00504', 'УЛ.РУДИЩЕ'),
	('00871', '11394', '00518', 'УЛ.СУХА ЛЕШНИЦА'),
	('00872', '11394', '00521', 'УЛ.ПРОЛЕТ'),
	('00873', '11394', '00535', 'УЛ.ШАВАРНИЦА'),
	('00874', '11394', '00549', 'УЛ.БУРГИЙСКА СКАЛА'),
	('00875', '11394', '00552', 'УЛ.ПОДКРАИЩЕ'),
	('00876', '11394', '00566', 'УЛ.ГОРЕЛИЦА'),
	('00877', '11394', '00571', 'УЛ.КАТЕРИЧКА'),
	('00878', '11394', '00597', 'УЛ.ПИРИН'),
	('00879', '11394', '00607', 'УЛ.ПЕРНИШКО ШОСЕ'),
	('00880', '11394', '00641', 'УЛ.ЕЛЕШНИЦА'),
	('00881', '11394', '00655', 'УЛ.БОЕВ РИД'),
	('00882', '11394', '00669', 'УЛ.МОМИН ВРЪХ'),
	('00883', '11394', '00672', 'УЛ.НОВО СЕЛО'),
	('00884', '11394', '00702', 'УЛ.СТОПАНСКИ ПЪТ'),
	('00885', '11394', '00730', 'УЛ.МАЙСКО УТРО'),
	('00886', '11394', '00761', 'УЛ.АСАНОВА ЧЕШМА'),
	('00887', '11394', '00775', 'УЛ.ИВЕТО'),
	('00888', '11394', '00789', 'УЛ.ЯЗБИНЕ'),
	('00889', '11394', '00792', 'УЛ.МАЛКА ПОЛЯНА'),
	('00890', '11394', '00802', 'УЛ.БОР'),
	('00891', '11394', '00816', 'УЛ.СИАНИТ'),
	('00892', '11394', '00828', 'УЛ.ХЕБРОС'),
	('00893', '11394', '26404', 'УЛ.БОРИКА'),
	('00894', '11394', '06063', 'УЛ.ЕДЕЛВАЙС (В.З.ПРИПЛАТ)'),
	('00895', '11394', '00905', 'УЛ.КАЛДЪРЪМЧЕ (В.З.ПРИПЛАТ)'),
	('00896', '11394', '00919', 'УЛ.ЛАНТАНА (В.З.ПРИПЛАТ)'),
	('00897', '11394', '00922', 'УЛ.ЧЕХЪЛЧЕ (В.З.ПРИПЛАТ)'),
	('00898', '11394', '00936', 'УЛ.ПЕРУНИКА (В.З.ПРИПЛАТ)'),
	('00899', '11394', '00943', 'УЛ.БОЖУР (В.З.ПРИПЛАТ)'),
	('00900', '11394', '00953', 'УЛ.ЗЕЛЕНИКА (В.З.ПРИПЛАТ)'),
	('00901', '11394', '00967', 'УЛ.КЪРПИ-КОЖУХ (В.З.ПРИПЛАТ)'),
	('00902', '11394', '00970', 'УЛ.КУКУРЯК (В.З.ПРИПЛАТ)'),
	('00903', '11394', '01033', 'УЛ.БУКОВА ГОРА'),
	('00904', '11884', '00014', 'УЛ.СПОРТИСТ'),
	('00905', '11884', '00031', 'УЛ.СТАРА ПЛАНИНА'),
	('00906', '11884', '00045', 'УЛ.РЕКАТА'),
	('00907', '11884', '00059', 'УЛ.КОКИЧЕ'),
	('00908', '11884', '00062', 'УЛ.ВЪРШЕЦ'),
	('00909', '11884', '00076', 'УЛ.ЧЕРНОМОРЕЦ'),
	('00910', '11884', '00084', 'УЛ.РУСАЛКА'),
	('00911', '11884', '00093', 'УЛ.РОЗА'),
	('00912', '11884', '00103', 'УЛ.ДЕТЕЛИНА'),
	('00913', '11884', '00117', 'УЛ.СИНЧЕЦ'),
	('00914', '11884', '00120', 'УЛ.ФЕНЕРА'),
	('00915', '11884', '00134', 'УЛ.ЕДЕЛВАЙС'),
	('00916', '11884', '00148', 'УЛ.РОСИЦА'),
	('00917', '11884', '00151', 'УЛ.ВАСИЛ ЛЕВСКИ (12-ТА)'),
	('00918', '11884', '00165', 'УЛ.ГОРСКА ПОЛЯНА'),
	('00919', '11884', '00215', 'УЛ.КАМЪКЪТ'),
	('00920', '11884', '00268', 'УЛ.ДЕТСКИ СВЯТ'),
	('00921', '11884', '00415', 'УЛ.СТАРОСЕЛСКА'),
	('00922', '11884', '00429', 'УЛ.ЩАСТЛИВ ДОМ'),
	('00923', '11884', '01609', 'УЛ.ПРЕЛОЗИТЕ'),
	('00924', '11884', '00504', 'УЛ.СЛЪНЧЕВА'),
	('00925', '12084', '00014', 'УЛ.ЗОРНИЦА'),
	('00926', '12084', '00028', 'УЛ.ДРУЖБА'),
	('00927', '12084', '00031', 'УЛ.МАЛИНА'),
	('00928', '12084', '00045', 'УЛ.БОЖУР'),
	('00929', '12084', '00059', 'БУЛ.ЛОМСКО ШОСЕ'),
	('00930', '12084', '00062', 'УЛ.НИКОДИМ ТОДОРОВ'),
	('00931', '12084', '00076', 'УЛ.ЧЕРВЕНО ЗНАМЕ'),
	('00932', '12084', '00084', 'УЛ.ЗАВОЯ'),
	('00933', '12084', '00093', 'УЛ.КОКИЧЕ'),
	('00934', '12084', '00103', 'УЛ.КАРАМФИЛ'),
	('00935', '12084', '00117', 'УЛ.БРЕЗА'),
	('00936', '12084', '00120', 'УЛ.РОЗА'),
	('00937', '12084', '00134', 'УЛ.СВОБОДА'),
	('00938', '12084', '00148', 'УЛ.МАРГАРИТА'),
	('00939', '12084', '00151', 'УЛ.ДУНАВ'),
	('00940', '12084', '00165', 'УЛ.АЛЕН МАК'),
	('00941', '12084', '00179', 'УЛ.РОСНА КИТКА'),
	('00942', '12084', '00182', 'УЛ.ЛАЛЕ'),
	('00943', '12084', '00196', 'УЛ.МИНЗУХАР'),
	('00944', '12084', '00206', 'УЛ.ВИОЛЕТА'),
	('00945', '12084', '00215', 'УЛ.ПАРТИЗАНИН'),
	('00946', '12084', '00223', 'УЛ.ПЛАМЪК'),
	('00947', '12084', '00237', 'УЛ.ЛИПА'),
	('00948', '12084', '00240', 'УЛ.МЛАДОСТ'),
	('00949', '12084', '00254', 'УЛ.ЕДЕЛВАЙС'),
	('00950', '12084', '00271', 'УЛ.СВЕТЛО БЪДЕЩЕ'),
	('00951', '12084', '00285', 'УЛ.СИНЧЕЦ'),
	('00952', '12084', '00299', 'УЛ.ЛИЛИЯ'),
	('00953', '12084', '00309', 'УЛ.41-ВА'),
	('00954', '12084', '00312', 'УЛ.НЕЗАБРАВКА'),
	('00955', '12084', '00326', 'УЛ.ПОБЕДА'),
	('00956', '12084', '00343', 'УЛ.ДЕТЕЛИНА'),
	('00957', '12084', '00357', 'УЛ.КАЛИНКА'),
	('00958', '12084', '00360', 'УЛ.ГРАДИНА'),
	('00959', '12084', '00374', 'УЛ.ЗДРАВЕЦ'),
	('00960', '12084', '00388', 'УЛ.ОПЪЛЧЕНЕЦ'),
	('00961', '12084', '00391', 'УЛ.ТЕМЕНУГА'),
	('00962', '12084', '00401', 'УЛ.ЕДИНСТВО'),
	('00963', '12084', '00415', 'УЛ.ЯВОР'),
	('00964', '12084', '00429', 'УЛ.РУЖА'),
	('00965', '12084', '00432', 'УЛ.ПРОСВЕТА'),
	('00966', '12084', '00446', 'УЛ.ПЕТУНИЯ'),
	('00967', '12084', '00456', 'УЛ.ЛАТИНКА'),
	('00968', '12084', '00463', 'УЛ.СЕРДИКА'),
	('00969', '12084', '00477', 'УЛ.ШИПКА'),
	('00970', '12084', '00480', 'УЛ.35-ТА'),
	('00971', '12084', '00494', 'УЛ.ОГОСТА'),
	('00972', '12084', '00504', 'УЛ.40-ТА'),
	('00973', '12084', '00518', 'УЛ.ГЕРГИНА'),
	('00974', '12084', '00521', 'УЛ.ИСКЪР'),
	('00975', '12084', '00535', 'УЛ.51-ВА'),
	('00976', '12084', '00549', 'УЛ.52-РА'),
	('00977', '12084', '00552', 'УЛ.53-ТА'),
	('00978', '12084', '00566', 'УЛ.54-ТА'),
	('00979', '12084', '00571', 'УЛ.ГОРИЦВЕТ (55-ТА)'),
	('00980', '12084', '00583', 'УЛ.56-ТА'),
	('00981', '12084', '00597', 'УЛ.57-МА'),
	('00982', '12084', '00607', 'УЛ.50-ТА'),
	('00983', '12084', '37530', 'УЛ.ЛЮЛЯК'),
	('00984', '12084', '19491', 'УЛ.НИКОЛА КАРАСТОЯНОВ'),
	('00985', '12084', '11065', 'УЛ.ИВАН ДРАСОВ'),
	('00986', '12084', '02676', 'УЛ.РИД'),
	('00987', '12084', '00610', 'УЛ.ПАНОРАМА'),
	('00988', '12084', '01064', 'УЛ.СМИЛЯНА'),
	('00989', '12084', '01078', 'УЛ.СЕЛИМ'),
	('00990', '12084', '01081', 'УЛ.ПОРТОКАЛОВ ЦВЯТ'),
	('00991', '12084', '01095', 'УЛ.СЕНА'),
	('00992', '12084', '01105', 'УЛ.ЗОКУМ'),
	('00993', '12084', '01119', 'УЛ.КОТЕШКА СТЪПКА'),
	('00994', '12084', '01122', 'УЛ.ЛЮБОВНО ЦВЕТЕ'),
	('00995', '12084', '01136', 'УЛ.ЛОЗИЧКА'),
	('00996', '12084', '01140', 'УЛ.ФИТОНИЯ'),
	('00997', '12084', '01153', 'УЛ.ДАМСКО СЪРЦЕ'),
	('00998', '12084', '01167', 'УЛ.КАЛАТЕЯ'),
	('00999', '12084', '01170', 'УЛ.ЦИНИЯ'),
	('01000', '12084', '38950', 'УЛ.ФЕЛИЦИЯ'),
	('01001', '12084', '00624', 'УЛ.ЧЕРНА БАРА'),
	('01002', '12084', '01184', 'УЛ.КИЛКАЗ'),
	('01003', '14831', '00014', 'УЛ.ПАТРИАРХ ГЕРМАН'),
	('01004', '14831', '00028', 'УЛ.БОНЕ ХАДЖИБОНЕВ'),
	('01005', '14831', '00084', 'УЛ.ВАСИЛ СТОИЛОВ'),
	('01006', '14831', '00240', 'УЛ.ЗАНАЯТЧИЙСКА'),
	('01007', '14831', '00285', 'УЛ.БОЖУР'),
	('01008', '14831', '00309', 'УЛ.ЦАР СИМЕОН ВЕЛИКИ'),
	('01009', '14831', '00343', 'УЛ.СТАРАТА ЧЕШМА'),
	('01010', '14831', '00374', 'УЛ.ХРИСТО БОТЕВ'),
	('01011', '14831', '00391', 'УЛ.ПЛОВДИВСКО ШОСЕ'),
	('01012', '14831', '00571', 'УЛ.ОКОЛОВРЪСТЕН ПЪТ'),
	('01013', '14831', '60112', 'БУЛ.ЦАРИГРАДСКО ШОСЕ'),
	('01014', '14831', '01626', 'УЛ.БОГАТИР (В.З.ВРАНА-ГЕРМАН)'),
	('01015', '14831', '00271', 'УЛ.ВЕЛА ПЕЕВА (27-МА)'),
	('01016', '14831', '01612', 'УЛ.ВОДЕНИЦАТА(В.З.ВРАНА-ГЕРМАН'),
	('01017', '14831', '00117', 'УЛ.Г.П.ДАСКАЛА (ТЕМЕНУЖКА)'),
	('01018', '14831', '00215', 'УЛ.ГРАДИНА (21-ВА)'),
	('01019', '14831', '01599', 'УЛ.ГРАМАДЕТО(В.З.ВРАНА-ГЕРМАН)'),
	('01020', '14831', '00237', 'УЛ.ДРУЖБА (23-ТА)'),
	('01021', '14831', '00182', 'УЛ.ЕМИЛИЯН СТАНЕВ (18-ТА)'),
	('01022', '14831', '00206', 'УЛ.ЗДРАВЕЦ (20-ТА)'),
	('01023', '14831', '00076', 'УЛ.ИГЛИКА (7-МА)'),
	('01024', '14831', '00326', 'УЛ.ИСКЪР (32-РА)'),
	('01025', '14831', '01609', 'УЛ.КЛОКОТНИЦА(В.З.ВРАНА-ГЕРМАН'),
	('01026', '14831', '00045', 'УЛ.КОКИЧЕ (4-ТА)'),
	('01027', '14831', '01638', 'УЛ.ЛИВАДЕТО (В.З.ВРАНЯ-ГЕРМАН)'),
	('01028', '14831', '00103', 'УЛ.ЛИПА (10-ТА)'),
	('01029', '14831', '00148', 'УЛ.МИЛУШ СТАНОЕВ (ПЕЮ ЯВОРОВ)'),
	('01030', '14831', '00062', 'УЛ.МИНЗУХАР (6-ТА)'),
	('01031', '14831', '00120', 'УЛ.МЛАДЕЖКА (12-ТА)'),
	('01032', '14831', '00223', 'УЛ.НЕЗАБРАВКА (22-РА)'),
	('01033', '14831', '00151', 'УЛ.ОСМИ МАРТ (15-ТА)'),
	('01034', '14831', '00196', 'УЛ.РОСИЦА (19-ТА)'),
	('01035', '14831', '00134', 'УЛ.ТОПОЛА (13-ТА)'),
	('01036', '14831', '00031', 'УЛ.ТРЕТИ МАРТ (3-ТА)'),
	('01037', '14831', '00299', 'УЛ.ХАН АСПАРУХ (29-ТА)'),
	('01038', '14831', '00312', 'УЛ.ХАН КРУМ (31-ВА)'),
	('01039', '14831', '00179', 'УЛ.ХР.СМИРНЕНСКИ (17-ТА)'),
	('01040', '14831', '00268', 'УЛ.ХРИСТО БОТЕВ (Л.ДИМИТРОВА)'),
	('01041', '14831', '00165', 'УЛ.ЧУЧУРА (16-ТА)'),
	('01042', '14831', '00254', 'УЛ.ШИПКА (25-ТА)'),
	('01043', '14831', '00093', 'УЛ.ЯВОР (9-ТА)'),
	('01044', '14831', '10166', 'УЛ.ЛОЗЕТО (В.З. ЛОЗЕТО)'),
	('01045', '14831', '10176', 'УЛ.ЗВЪНИЦА (В.З. ЛОЗЕТО)'),
	('01046', '14831', '10183', 'УЛ.КРАЙГОРСКА (В.З. ЛОЗЕТО)'),
	('01047', '14831', '10197', 'УЛ.БУЧЕТО (В.З. ЛОЗЕТО)'),
	('01048', '14831', '10207', 'УЛ.НЕРАЗДЕЛНА (В.З. ЛОЗЕТО)'),
	('01049', '14831', '10210', 'УЛ.МЕДУНИЦА (В.З. ЛОЗЕТО)'),
	('01050', '14831', '10224', 'УЛ.СТАРИЯТ ПЪТ (В.З. ЛОЗЕТО)'),
	('01051', '14831', '10238', 'УЛ.БРАЙНОВО (В.З. ЛОЗЕТО)'),
	('01052', '14831', '10241', 'УЛ.СУХОТО ДЕРЕ (В.З. ЛОЗЕТО)'),
	('01053', '14831', '10553', 'УЛ.СМРЕКАТА'),
	('01054', '14831', '13528', 'УЛ.МАНАСТИРСКА ВОДЕНИЦА'),
	('01055', '14831', '00607', 'УЛ.ЧАРДАКЛИЙСКА КОРИЯ'),
	('01056', '14831', '00610', 'УЛ.БАЧОВИЦА'),
	('01057', '14831', '00624', 'УЛ.ЮРМЕН'),
	('01058', '14831', '35777', 'УЛ.ВРАНА'),
	('01059', '14831', '10519', 'УЛ.СТАРИЯ МОСТ'),
	('01060', '16448', '00014', 'УЛ.СТЕФАН КАРАДЖА'),
	('01061', '16448', '00028', 'УЛ.ЧАВДАР'),
	('01062', '16448', '00031', 'УЛ.ЧЕРКОВНА'),
	('01063', '16448', '00045', 'УЛ.ШАБАНИЦА'),
	('01064', '16448', '00059', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01065', '16448', '00062', 'УЛ.ТРЕТИ МАРТ'),
	('01066', '16448', '00076', 'УЛ.ШИПКА'),
	('01067', '16448', '00084', 'УЛ.ХРИСТО БОТЕВ'),
	('01068', '16448', '00093', 'УЛ.КИРИЛ И МЕТОДИЙ'),
	('01069', '16448', '00103', 'УЛ.МОРАВА'),
	('01070', '16448', '00117', 'УЛ.АСЕН ЗЛАТАРОВ'),
	('01071', '16448', '00120', 'УЛ.РЕНДОВА'),
	('01072', '16448', '00134', 'УЛ.КЛАДЕНЦИТЕ'),
	('01073', '16448', '00148', 'УЛ.СТУБЕЛА'),
	('01074', '16448', '00151', 'УЛ.СТАРА ПЛАНИНА'),
	('01075', '16448', '00165', 'УЛ.ХАН БОГРОВ'),
	('01076', '16448', '00179', 'УЛ.ЛЮЛИН'),
	('01077', '16448', '00182', 'УЛ.ТРАЙЧО КОСТОВ'),
	('01078', '16448', '00196', 'УЛ.МУРГАШ'),
	('01079', '16448', '00206', 'УЛ.ПОП ГРУЙО'),
	('01080', '16448', '00215', 'УЛ.РИБАРИЦА'),
	('01081', '16448', '00223', 'УЛ.ДОЛНА МАХАЛА'),
	('01082', '16448', '00237', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01083', '16448', '00240', 'УЛ.КРЪСТА'),
	('01084', '16448', '00254', 'УЛ.ВОДЕНИЦАТА'),
	('01085', '16448', '00268', 'УЛ.НЕЗАБРАВКА'),
	('01086', '16448', '00271', 'УЛ.НИКОЛА ВАПЦАРОВ'),
	('01087', '16448', '00285', 'УЛ.ЗДРАВЕЦ'),
	('01088', '16448', '00299', 'УЛ.ОБРЕЩА'),
	('01089', '16448', '00309', 'УЛ.МУСАЛА'),
	('01090', '16448', '00312', 'УЛ.ХЕМУС'),
	('01091', '16448', '00326', 'УЛ.БОТУНСКИ ПЪТ'),
	('01092', '21662', '00014', 'УЛ.ДОБРОСЛАВСКО ШОСЕ'),
	('01093', '21662', '00028', 'УЛ.ЗДРАВЕЦ'),
	('01094', '21662', '00031', 'УЛ.КРЪСТА'),
	('01095', '21662', '00045', 'УЛ.БРИГАДИРСКА'),
	('01096', '21662', '00059', 'УЛ.БОРОВА ГОРА'),
	('01097', '21662', '00062', 'УЛ.КОСМОНАВТ'),
	('01098', '21662', '00076', 'УЛ.ВОДЕНИЦАТА'),
	('01099', '21662', '00084', 'УЛ.ШИРИНАТА'),
	('01100', '21662', '00093', 'УЛ.ПАРАШУТИСТ'),
	('01101', '21662', '00103', 'УЛ.ЛЕТЕЦ'),
	('01102', '21662', '00117', 'УЛ.СЪЛЗИЦА'),
	('01103', '21662', '00120', 'УЛ.КРАЙНА'),
	('01104', '21662', '00134', 'УЛ.ШУМКА'),
	('01105', '21662', '00148', 'УЛ.УРШАК'),
	('01106', '21662', '00151', 'УЛ.ВАЛОГА'),
	('01107', '21662', '00165', 'УЛ.БЪРДО'),
	('01108', '21662', '00179', 'УЛ.ТИПЧЕНИЦА'),
	('01109', '21662', '00182', 'УЛ.ГРАДИЩЕ'),
	('01110', '21662', '00196', 'УЛ.БЯЛА ЗЕМЯ'),
	('01111', '21662', '00206', 'УЛ.МОНОВА МОГИЛА'),
	('01112', '21662', '00215', 'УЛ.ГЕЛКОВА ПАДИНА'),
	('01113', '21662', '00223', 'УЛ.СТАНИСЛАВ ДЕНКОВ'),
	('01114', '21662', '00237', 'УЛ.СТАДИОН'),
	('01115', '21662', '00240', 'УЛ.БРАНИЩЕ'),
	('01116', '21662', '00254', 'УЛ.ПАНЧОВИЦА'),
	('01117', '21662', '00268', 'УЛ.ПЕШОВИЦА'),
	('01118', '21662', '00271', 'УЛ.ПЪРВАНОВА ЧЕШМА'),
	('01119', '21662', '00285', 'УЛ.ГРАМАДИТЕ'),
	('01120', '21662', '00299', 'УЛ.СТАРОТО УЧИЛИЩЕ'),
	('01121', '21662', '00309', 'УЛ.ДЕТСКА ПЕСЕН'),
	('01122', '21662', '00312', 'УЛ.ГАБРОВНИЦА'),
	('01123', '21662', '00326', 'УЛ.ГЕОРГИ ВЕЛЕВ'),
	('01124', '21662', '00330', 'УЛ.РАКИТА'),
	('01125', '21662', '00343', 'УЛ.ОВОЩНА ГРАДИНА'),
	('01126', '21662', '00357', 'УЛ.БЯЛ КАМЪК'),
	('01127', '21662', '00360', 'УЛ.СРЕДОРЕК'),
	('01128', '21662', '00374', 'УЛ.ЖИТЕНСКИ ПЪТ'),
	('01129', '21662', '00388', 'УЛ.ГРАДИНАРСКА'),
	('01130', '21662', '00391', 'УЛ.ОТАВА'),
	('01131', '21662', '00401', 'УЛ.МОГИЛКА'),
	('01132', '21662', '00415', 'УЛ.ЛОЖЕВ ДОЛ'),
	('01133', '21662', '00429', 'УЛ.БУНТОВНИК'),
	('01134', '21662', '00432', 'УЛ.ЛИПА'),
	('01135', '21662', '00446', 'УЛ.МАСЛАРСКА'),
	('01136', '21662', '70007', 'УЛ.ПАМЕТНИКА'),
	('01137', '21662', '70010', 'ПЛ.МЕГДАНА'),
	('01138', '21662', '11795', 'УЛ.НАДЕЖДА'),
	('01139', '21662', '00456', 'УЛ.ЛУКА ГЪЛЪБОВ'),
	('01140', '21662', '39791', 'УЛ.ГАРДЕНИЯ'),
	('01141', '22304', '00014', 'УЛ.1'),
	('01142', '22304', '00028', 'УЛ.2'),
	('01143', '22304', '00031', 'УЛ.3'),
	('01144', '22304', '00045', 'УЛ.4'),
	('01145', '22304', '00059', 'УЛ.5'),
	('01146', '22304', '00076', 'УЛ.7'),
	('01147', '22304', '00084', 'УЛ.8'),
	('01148', '22304', '00093', 'УЛ.9'),
	('01149', '22304', '00103', 'УЛ.10'),
	('01150', '22304', '00117', 'УЛ.11'),
	('01151', '22304', '00120', 'УЛ.12'),
	('01152', '22304', '00134', 'УЛ.13'),
	('01153', '22304', '00148', 'УЛ.14'),
	('01154', '22304', '00151', 'УЛ.15'),
	('01155', '22304', '00165', 'УЛ.16'),
	('01156', '22304', '00206', 'УЛ.20'),
	('01157', '22304', '00215', 'УЛ.21'),
	('01158', '22304', '00240', 'УЛ.24'),
	('01159', '22304', '00254', 'УЛ.25'),
	('01160', '22304', '00268', 'УЛ.26'),
	('01161', '22304', '00271', 'УЛ.27'),
	('01162', '22304', '00285', 'УЛ.28'),
	('01163', '22304', '00299', 'УЛ.29'),
	('01164', '22304', '00312', 'УЛ.31'),
	('01165', '22304', '00357', 'УЛ.35'),
	('01166', '22304', '00360', 'УЛ.36'),
	('01167', '22304', '00374', 'УЛ.37'),
	('01168', '22304', '00388', 'УЛ.38'),
	('01169', '22304', '00391', 'УЛ.39'),
	('01170', '22304', '00456', 'УЛ.40'),
	('01171', '22304', '00463', 'УЛ.41'),
	('01172', '22472', '00014', 'УЛ.МОМИН КАМЪК'),
	('01173', '22472', '00028', 'УЛ.КАП.ДИМ.СПИСАРЕВСКИ'),
	('01174', '22472', '00031', 'УЛ.БРЕЗА'),
	('01175', '22472', '00059', 'УЛ.ЛЮЛЯК'),
	('01176', '22472', '00062', 'УЛ.АЛЕН МАК'),
	('01177', '22472', '00076', 'УЛ.ИСКЪР'),
	('01178', '22472', '00084', 'УЛ.РУСАМА (6-ТА)'),
	('01179', '22472', '00093', 'УЛ.ТРЕПЕТЛИКА'),
	('01180', '22472', '00103', 'УЛ.ХВОЙНА'),
	('01181', '22472', '00120', 'УЛ.ДИМИТЪР ВУЧКОВ'),
	('01182', '22472', '00134', 'УЛ.ЧАЙКА'),
	('01183', '22472', '00148', 'УЛ.РОЗА'),
	('01184', '22472', '00151', 'УЛ.ВЪРБА'),
	('01185', '22472', '00165', 'УЛ.ИГЛИКА'),
	('01186', '22472', '00179', 'УЛ.ИЗВОР'),
	('01187', '22472', '00182', 'УЛ.ГРАДИНА'),
	('01188', '22472', '00196', 'УЛ.БЕЛИЯ КАМЪК'),
	('01189', '22472', '00206', 'УЛ.ХРИЗАНТЕМА (8-МА)'),
	('01190', '22472', '00215', 'УЛ.УРВИЧ'),
	('01191', '22472', '00223', 'УЛ.ЗДРАВЕЦ'),
	('01192', '22472', '00237', 'УЛ.ДЪБОВА КОРИЯ'),
	('01193', '22472', '00240', 'УЛ.БОЖУР'),
	('01194', '22472', '00254', 'УЛ.МИНЗУХАР'),
	('01195', '22472', '00268', 'УЛ.АКАЦИЯ'),
	('01196', '22472', '00271', 'УЛ.РАКИТА'),
	('01197', '22472', '00285', 'УЛ.СУХА РЕКА'),
	('01198', '22472', '00299', 'УЛ.ДИЛЯНА'),
	('01199', '22472', '00309', 'УЛ.ЩЪРКЕЛОВИ ГНЕЗДА'),
	('01200', '22472', '00312', 'УЛ.ЕДЕЛВАЙС'),
	('01201', '22472', '00326', 'УЛ.ТЕМЕНУГА'),
	('01202', '22472', '00330', 'УЛ.ЧЕРЕША'),
	('01203', '22472', '00343', 'УЛ.ДЕТЕЛИНА'),
	('01204', '22472', '00357', 'УЛ.СИНЧЕЦ'),
	('01205', '22472', '00374', 'УЛ.ДЪЛГА ПОЛЯНА'),
	('01206', '22472', '00388', 'УЛ.ПРОСВЕТА'),
	('01207', '22472', '00391', 'УЛ.МОМИНА СКАЛА'),
	('01208', '22472', '00401', 'УЛ.БОРОВА ГОРА'),
	('01209', '22472', '00432', 'УЛ.АЛБЕНА (41-ВА)'),
	('01210', '22472', '00456', 'УЛ.ГЕРГАНА (36-ТА)'),
	('01211', '22472', '00463', 'УЛ.ЯВОР'),
	('01212', '22472', '00477', 'УЛ.ЯСЕН'),
	('01213', '22472', '00480', 'УЛ.САМОКОВСКО ШОСЕ'),
	('01214', '22472', '00117', 'УЛ.КАП.ПЕТКО ВОЙВОДА'),
	('01215', '29150', '00014', 'УЛ.САМОКОВСКО ШОСЕ (1-ВА)'),
	('01216', '29150', '00028', 'УЛ.ИСКЪРСКА'),
	('01217', '29150', '00031', 'УЛ.ПЛАНА ПЛАНИНА (4-ТА)'),
	('01218', '29150', '00045', 'УЛ.УРВИЧ'),
	('01219', '29150', '00062', 'УЛ.ВЕДЕНА (8-МА)'),
	('01220', '29150', '00084', 'УЛ.ЗДРАВЕЦ (10-ТА)'),
	('01221', '29150', '00093', 'УЛ.ДЪБОВА ГОРА (11-ТА)'),
	('01222', '29150', '00103', 'УЛ.ВИТЕЛСКИ ДОЛ'),
	('01223', '29150', '00117', 'УЛ.КИМОВ ДОЛ (13-ТА)'),
	('01224', '29150', '00120', 'УЛ.ЛЕНИЩЕ (24-ТА)'),
	('01225', '29150', '00134', 'УЛ.МАЛА ЖЕЛЕЗНИЦА (25-ТА)'),
	('01226', '29150', '00151', 'УЛ.ЛОЗЕНСКА ПЛАНИНА (3-ТА)'),
	('01227', '29150', '00165', 'УЛ.ЛЕВА РЕКА (7-МА)'),
	('01228', '29150', '00223', 'УЛ.ИЗГРЕВ'),
	('01229', '29150', '00237', 'УЛ.ЯРЕМА (20-ТА)'),
	('01230', '29150', '00240', 'УЛ.ВИТОША (21-ВА)'),
	('01231', '29150', '00268', 'УЛ.МАНАСТИРИЩЕ (23-ТА)'),
	('01232', '29150', '00271', 'УЛ.СТАМБОЛОВА РЕКА'),
	('01233', '29150', '00285', 'УЛ.ШИПКА'),
	('01234', '29150', '00309', 'УЛ.ЧЕРНИ ВРЪХ'),
	('01235', '29150', '00312', 'УЛ.БОРОВЕЦ'),
	('01236', '29150', '00326', 'УЛ.ЛЮЛЯК'),
	('01237', '29150', '00330', 'УЛ.АЛЕН МАК'),
	('01238', '29150', '00343', 'УЛ.МОМИН ПРОХОД'),
	('01239', '29150', '00357', 'УЛ.ИГЛИКА'),
	('01240', '29150', '00360', 'УЛ.ПРОБУДА'),
	('01241', '29150', '00429', 'УЛ.ДРЕН'),
	('01242', '29150', '00504', 'УЛ.ЕДЕЛВАЙС'),
	('01243', '29150', '00607', 'УЛ.СВЕТИ ИЛИЯ'),
	('01244', '29150', '00610', 'УЛ.ЧОВКАРНИКО'),
	('01245', '29150', '00552', 'УЛ.ПЕНОВ РИД'),
	('01246', '29150', '00566', 'УЛ.ВИТЛЕНИКО'),
	('01247', '29204', '00014', 'УЛ.БЕНЕ ЦЕНДИН'),
	('01248', '29204', '00028', 'УЛ.СТОЯН МЕЧКАТА'),
	('01249', '29204', '00031', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01250', '29204', '00045', 'УЛ.НИКОЛА ПЕТКОВ'),
	('01251', '29204', '00059', 'УЛ.БЛАГОЙ ТОДОРОВ'),
	('01252', '29204', '00062', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01253', '29204', '00084', 'УЛ.КИРИЛ И МЕТОДИЙ'),
	('01254', '29204', '00093', 'УЛ.24-ТИ МАЙ'),
	('01255', '29204', '00103', 'УЛ.СТОЯН МИСИРСКИ'),
	('01256', '29204', '00117', 'УЛ.ГЕРЕНА'),
	('01257', '29204', '00120', 'УЛ.ТОНЕ КРАЙЧЕВ'),
	('01258', '29204', '00134', 'УЛ.СТЕФАН КАРАДЖА'),
	('01259', '29204', '00148', 'УЛ.ГЕН.НИКОЛАЙ ЖЕЛЯВСКИ'),
	('01260', '29204', '00151', 'УЛ.БРЕСТО'),
	('01261', '29204', '00165', 'УЛ.ЦОНЬО ВОЙВОДА'),
	('01262', '29204', '00179', 'УЛ.ТОДОРАКИ ПЕШЕВ'),
	('01263', '29204', '00182', 'УЛ.СТАРА ПЛАНИНА'),
	('01264', '29204', '00196', 'УЛ.АНГЕЛ ТОДОРОВ'),
	('01265', '29204', '00215', 'УЛ.ПОП СТОЯН ПЕНКОВ'),
	('01266', '29204', '00254', 'УЛ.СИНЕВА'),
	('01267', '29204', '00268', 'УЛ.СТАРОПЛАНИНСКА ПЕСЕН'),
	('01268', '29430', '00014', 'УЛ.ЖИТНИЦА'),
	('01269', '29430', '00028', 'УЛ.КАЛОЯН (2-РА)'),
	('01270', '29430', '00031', 'УЛ.НАДЕЖДА'),
	('01271', '29430', '00045', 'УЛ.БРЕЗА (4-ТА)'),
	('01272', '29430', '00059', 'УЛ.ТЕМЕНУГА (5-ТА)'),
	('01273', '29430', '00062', 'УЛ.ТЪРГОВСКА'),
	('01274', '29430', '00076', 'УЛ.ОТЕЦ ПАИСИЙ (7-МА)'),
	('01275', '29430', '00084', 'УЛ.ХАН АСПАРУХ (8-МА)'),
	('01276', '29430', '00103', 'УЛ.ДОБРОСЛАВСКИ ПЪТ (9-ТА)'),
	('01277', '29430', '00117', 'УЛ.АКАЦИЯ (10-ТА)'),
	('01278', '29430', '00120', 'УЛ.ЛИПА (11-ТА)'),
	('01279', '29430', '00134', 'УЛ.КОКИЧЕ (12-ТА)'),
	('01280', '29430', '00148', 'УЛ.ЛАЛЕ (13-ТА)'),
	('01281', '29430', '00151', 'УЛ.РАВНИЩЕ (14-ТА)'),
	('01282', '29430', '00165', 'УЛ.МИНЗУХАР (15-ТА)'),
	('01283', '29430', '00179', 'УЛ.КРИВА РЕКА (16-ТА)'),
	('01284', '29430', '00182', 'УЛ.СТУБЕЛ (17-ТА)'),
	('01285', '29430', '00196', 'УЛ.БОЖУР (18-ТА)'),
	('01286', '29430', '00206', 'УЛ.ЗДРАВЕЦ (19-ТА)'),
	('01287', '29430', '00223', 'УЛ.КОСТИНБРОДСКИ ПЪТ (21-ВА)'),
	('01288', '29430', '00237', 'УЛ.МАК (22-РА)'),
	('01289', '29430', '00254', 'УЛ.ЛЮЛЯК'),
	('01290', '29430', '00240', 'УЛ.БОР (23ТА)'),
	('01291', '29430', '00268', 'УЛ.ЗЛАТЕН КЛАС (25-ТА)'),
	('01292', '29430', '21324', 'УЛ.ВЪЗРОЖДЕНСКА'),
	('01293', '29430', '13192', 'УЛ.МОГИЛА'),
	('01294', '29430', '09799', 'УЛ.ЧЕРКОВНА'),
	('01295', '32216', '96966', 'УЛ.КОКИЧЕ'),
	('01296', '32216', '96976', 'УЛ.ХЕМУС'),
	('01297', '32216', '96983', 'УЛ.ТЪРНОВО'),
	('01298', '32216', '96997', 'УЛ.ХЪРСОВО'),
	('01299', '32216', '97001', 'УЛ.ПЛАНА'),
	('01300', '32216', '97015', 'УЛ.ЕДЕЛВАЙС'),
	('01301', '32216', '97029', 'УЛ.РОДОПИ'),
	('01302', '32216', '97032', 'УЛ.ДУНАВ'),
	('01303', '32216', '97046', 'УЛ.ТИМОК'),
	('01304', '32216', '97058', 'УЛ.ЩАСТИЕ'),
	('01305', '32216', '97063', 'УЛ.БОГДАНОВ ДОЛ'),
	('01306', '32216', '97077', 'УЛ.СИЛИСТРА'),
	('01307', '32216', '97080', 'УЛ.КАКАЧ'),
	('01308', '32216', '97094', 'УЛ.ВИТ'),
	('01309', '32216', '97104', 'УЛ.СТРУМА'),
	('01310', '32216', '97118', 'УЛ.ПИРИН'),
	('01311', '32216', '97121', 'УЛ.ЧАЙКА'),
	('01312', '32216', '97135', 'УЛ.ОСОГОВО'),
	('01313', '32216', '97149', 'УЛ.ИЛЬО ВОЙВОДА'),
	('01314', '32216', '97152', 'УЛ.ЕЛТЕПЕ'),
	('01315', '32216', '97166', 'УЛ.ВАРДАР'),
	('01316', '32216', '97173', 'УЛ.КИТЕН'),
	('01317', '32216', '97183', 'УЛ.ТУТРАКАН'),
	('01318', '32216', '97197', 'УЛ.ОРЛОВО ГНЕЗДО'),
	('01319', '32216', '97207', 'УЛ.ЛЮТИ БРОД'),
	('01320', '32216', '97304', 'УЛ.ЧЕРНИ ВРЪХ'),
	('01321', '32216', '96952', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('01322', '32216', '38844', 'УЛ.ИНЖ.ЛЮБОМИР КАЙРАКОВ'),
	('01323', '32216', '38858', 'УЛ.РОДОПЧАНКА'),
	('01324', '32216', '97313', 'УЛ.МЕЧИТ'),
	('01325', '32216', '95501', 'УЛ.ПЕТЪР ГЕНЧЕВ'),
	('01326', '32216', '97625', 'УЛ.ЛЕДЕНИК'),
	('01327', '32216', '97639', 'УЛ.ПАНОРАМНА ГЛЕДКА'),
	('01328', '32216', '97882', 'УЛ.СТРЕЛИЦИЯ'),
	('01329', '35239', '00014', 'УЛ.ОКОЛОВРЪСТНА'),
	('01330', '35239', '00028', 'УЛ.АЛИЧО'),
	('01331', '35239', '00031', 'УЛ.МЛАДОСТ'),
	('01332', '35239', '00045', 'УЛ.ХРИСТО БОТЕВ'),
	('01333', '35239', '00059', 'УЛ.ДИМИТЪР АШОВ'),
	('01334', '35239', '00062', 'УЛ.ДЪБРАВА'),
	('01335', '35239', '00076', 'УЛ.ДЮЛА'),
	('01336', '35239', '00084', 'УЛ.ИЗГРЕВ'),
	('01337', '35239', '00093', 'УЛ.НИКОЛА ПЕТКОВ'),
	('01338', '35239', '00103', 'УЛ.БАЛЕВИЦА'),
	('01339', '35239', '00117', 'УЛ.ХАН КРУМ'),
	('01340', '35239', '00120', 'УЛ.ЛЮБЕН КАРАВЕЛОВ'),
	('01341', '35239', '00134', 'УЛ.СПАС АНДРЕЕВ'),
	('01342', '35239', '00148', 'УЛ.МОМИН КЛАДЕНЕЦ'),
	('01343', '35239', '00151', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01344', '35239', '00165', 'УЛ.ПРОГРЕС'),
	('01345', '35239', '00179', 'УЛ.ТРОЯНОВ ПЪТ'),
	('01346', '35239', '00182', 'УЛ.БЕЛИЦА'),
	('01347', '35239', '00196', 'УЛ.ОТЕЦ ПАИСИЙ'),
	('01348', '35239', '00206', 'УЛ.ГЕОРГИ БЕНКОВСКИ'),
	('01349', '35239', '00215', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01350', '35239', '00223', 'УЛ.ЦАР СИМЕОН'),
	('01351', '35239', '00237', 'УЛ.ЛИПИТЕ'),
	('01352', '35239', '00240', 'УЛ.КРЪСТЮ ПАСТУХОВ'),
	('01353', '35239', '00254', 'УЛ.ЦАР БОРИС III'),
	('01354', '35239', '00268', 'УЛ.ПЕЙО ЯВОРОВ'),
	('01355', '35239', '00271', 'УЛ.ХАН АСПАРУХ'),
	('01356', '35239', '00285', 'УЛ.ВИТОША'),
	('01357', '35239', '00299', 'УЛ.КИРИЛ И МЕТОДИ'),
	('01358', '35239', '00309', 'УЛ.МИТО ВОЙНИШКИ'),
	('01359', '35239', '00312', 'УЛ.АПОСТОЛ ЛАМБОВ'),
	('01360', '35239', '00326', 'УЛ.ИЛИЯ ВЕЛИНОВ'),
	('01361', '35239', '00330', 'УЛ.ХАДЖИ ДИМИТЪР'),
	('01362', '35239', '00343', 'УЛ.ХРИСТО ПОПБОЖИЛОВ'),
	('01363', '35239', '00357', 'УЛ.ОСВОБОЖДЕНИЕ'),
	('01364', '35239', '00374', 'УЛ.КОКИЧЕ'),
	('01365', '35239', '00388', 'УЛ.МУРГАШ'),
	('01366', '35239', '00504', 'УЛ.СТАРАТА ГАРА'),
	('01367', '35239', '00571', 'УЛ.ОКОЛОВРЪСТЕН ПЪТ'),
	('01368', '35239', '00641', 'УЛ.СТАРИЯ ИСКЪР'),
	('01369', '35239', '00672', 'УЛ.ИЗТОК'),
	('01370', '35239', '00686', 'УЛ.ЦИКЛАМА'),
	('01371', '35239', '01804', 'УЛ.ФАРМАПАРК'),
	('01372', '35239', '03486', 'УЛ.3-ТИ МАРТ'),
	('01373', '35239', '02110', 'УЛ.24-ТИ МАЙ (ПРОМ.ЗОНА)'),
	('01374', '35239', '02107', 'УЛ.ВЛАДИМИР ВИСОЦКИ (ПРОМ.ЗОНА'),
	('01375', '35239', '02124', 'УЛ.ГЕОРГИ ПАРЦАЛЕВ (ПРОМ.ЗОНА)'),
	('01376', '35239', '02097', 'УЛ.ЕМИЛ ДИМИТРОВ (ПРОМ.ЗОНА)'),
	('01377', '35239', '02083', 'УЛ.СЕРАФИМ СТОЕВ (ПРОМ.ЗОНА)'),
	('01378', '35239', '13202', 'УЛ.ВИДРИЦА'),
	('01379', '35239', '15240', 'УЛ.ЯНКО АНГЕЛОВ (ВИДНИТЕ)'),
	('01380', '35239', '15148', 'УЛ.ГОРНА КОРИЯ (ВИДНИТЕ)'),
	('01381', '35239', '15134', 'УЛ.ДЯКОН СТОИЛ (ВИДНИТЕ)'),
	('01382', '35239', '15151', 'УЛ.ТОЖЕВА ВАДА (ВИДНИТЕ)'),
	('01383', '35239', '15165', 'УЛ.21 ДЕКЕМВРИ (ВИДНИТЕ)'),
	('01384', '35239', '15179', 'УЛ.КРАЙЕЗЕРНА (ВИДНИТЕ)'),
	('01385', '35239', '15182', 'УЛ.ЛЮБА БЕЛЕВА (ВИДНИТЕ)'),
	('01386', '35239', '15196', 'УЛ.РУСКИ ЛАГЕР (ВИДНИТЕ)'),
	('01387', '35239', '15206', 'УЛ.АЛИКОВ БОСТАН (ВИДНИТЕ)'),
	('01388', '35239', '15216', 'УЛ.ГОРНИ ТОПИЛА (ВИДНИТЕ)'),
	('01389', '35239', '15223', 'УЛ.ВИДНЯ (ВИДНИТЕ)'),
	('01390', '35239', '15237', 'УЛ.МАЙСКИ ЦВЯТ (ВИДНИТЕ)'),
	('01391', '35239', '15254', 'УЛ.СТОЕВА ЛЕХА (ВИДНИТЕ)'),
	('01392', '35239', '00936', 'УЛ.ВЕГА'),
	('01393', '37280', '01122', 'УЛ.ПОПОВ ДОЛ (М.ЩЕТЕНИЦА)'),
	('01394', '37280', '01136', 'УЛ.ЩЕТЕНИЦА (М.ЩЕТЕНИЦА)'),
	('01395', '37280', '01140', 'УЛ.ИЗГРЕВ (М.ЩЕТЕНИЦА)'),
	('01396', '37280', '01153', 'УЛ.ЗОРА (М.ЩЕТЕНИЦА)'),
	('01397', '37280', '01167', 'УЛ.ВИТКОВИЦА (М.ВИТКОВИЦА)'),
	('01398', '37280', '01170', 'УЛ.БОР (М.ВИТКОВИЦА)'),
	('01399', '37280', '01184', 'УЛ.ДЖЕРГОВ ВРЪХ (М.ВИТКОВИЦА)'),
	('01400', '37280', '01198', 'УЛ.ПАНОРАМА (М.ПЛОЧА)'),
	('01401', '37280', '00062', 'УЛ.ЧЕРВЕНОАРМЕЙСКА'),
	('01402', '37280', '01208', 'УЛ.АВРАМИЦА (М.ВИТКОВИЦА)'),
	('01403', '37280', '01211', 'УЛ.ДАСКАЛ МИТО'),
	('01404', '37280', '01225', 'УЛ.ПОП ИВАН'),
	('01405', '37280', '01239', 'УЛ.МАНАСТИРСКИ ПЪТ'),
	('01406', '37280', '01242', 'УЛ.БЛАГОДЕНСТВИЕ'),
	('01407', '37280', '01256', 'УЛ.ПЛОЧА'),
	('01408', '37280', '01266', 'УЛ.БАЛКАНСКА'),
	('01409', '37914', '00014', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01410', '37914', '00028', 'УЛ.ЛЮЛЯЦИТЕ'),
	('01411', '37914', '00031', 'УЛ.ВЕДЕНА'),
	('01412', '37914', '00045', 'УЛ.ГЕН.КИРИЛ БОТЕВ'),
	('01413', '37914', '00059', 'УЛ.ДИМИТЪР БЛАГОЕВ'),
	('01414', '37914', '00062', 'УЛ.ПЕТЪР БЕРОН'),
	('01415', '37914', '00076', 'УЛ.ЛИПОВА ПАДИНА'),
	('01416', '37914', '00084', 'УЛ.ВАЛОЗИТЕ'),
	('01417', '37914', '00093', 'УЛ.СОЛИЩАТА'),
	('01418', '37914', '00103', 'УЛ.ДЪРЖОВ ДОЛ'),
	('01419', '37914', '00148', 'УЛ.ИСКЪР'),
	('01420', '37914', '00151', 'УЛ.МАЛЧИКА'),
	('01421', '37914', '00165', 'УЛ.КРЪСТАН МЛАДЕНОВ'),
	('01422', '37914', '00179', 'УЛ.СТЕФАН КАРАДЖА'),
	('01423', '37914', '00182', 'УЛ.АЛЕКСАНДЪР ГЕНКОВ'),
	('01424', '37914', '00196', 'УЛ.ЦАР КАЛОЯН'),
	('01425', '37914', '00206', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('01426', '37914', '00215', 'УЛ.ЗДРАВЕЦ'),
	('01427', '37914', '00223', 'УЛ.СТАРАТА ЧЕШМА'),
	('01428', '37914', '00240', 'УЛ.ТОПОЛИТЕ'),
	('01429', '37914', '00254', 'УЛ.ГРАМАДА'),
	('01430', '37914', '00268', 'УЛ.ЦАР ИВАН АСЕН II'),
	('01431', '37914', '00271', 'УЛ.ЛАТИНКА'),
	('01432', '37914', '00309', 'УЛ.ИВАН ШИШМАН'),
	('01433', '37914', '00312', 'УЛ.ОРНИЧЕ'),
	('01434', '37914', '00326', 'УЛ.СЛАТИН ДОЛ'),
	('01435', '37914', '00388', 'УЛ.ПРОФ.СИМЕОН ХАЛАЧЕВ'),
	('01436', '37914', '00391', 'УЛ.ПОРТИН ДОЛ 2'),
	('01437', '37914', '00401', 'УЛ.МИХОВО БЛАТО'),
	('01438', '37914', '00446', 'УЛ.МОГИЛАТА'),
	('01439', '37914', '00456', 'УЛ.ТОДОРИНИ КУКЛИ'),
	('01440', '37914', '00463', 'УЛ.РАЛИЦА'),
	('01441', '37914', '00477', 'УЛ.ИЗГРЕВ'),
	('01442', '37914', '00494', 'УЛ.САМОКОВСКО ШОСЕ'),
	('01443', '37914', '00504', 'УЛ.ОКОЛОВРЪСТНА'),
	('01444', '37914', '00518', 'УЛ.ТРУДОЛЮБИЕ'),
	('01445', '37914', '00549', 'УЛ.УРВИЧ'),
	('01446', '37914', '00583', 'УЛ.БОР'),
	('01447', '37914', '00607', 'УЛ.ПУКНАТ КАМЪК (34-ТА)'),
	('01448', '37914', '00610', 'УЛ.ПРОЛЕТ'),
	('01449', '37914', '00624', 'УЛ.БУКАТА'),
	('01450', '37914', '00638', 'УЛ.ЛЪКАТА'),
	('01451', '37914', '00641', 'УЛ.ПЕТРОВ КЛАДЕНЕЦ'),
	('01452', '37914', '00669', 'УЛ.ЕЛА'),
	('01453', '37914', '00686', 'УЛ.РОДОЛЮБИЕ'),
	('01454', '37914', '00697', 'УЛ.РОЗА'),
	('01455', '37914', '00713', 'УЛ.ЯВОР'),
	('01456', '37914', '00727', 'УЛ.РОСА'),
	('01457', '37914', '00758', 'УЛ.ТЕМЕНУГА'),
	('01458', '37914', '00761', 'УЛ.КИТКАТА'),
	('01459', '37914', '00789', 'УЛ.ЗОРА'),
	('01460', '37914', '00792', 'УЛ.ПОРТИН ДОЛ'),
	('01461', '37914', '00802', 'УЛ.38'),
	('01462', '37914', '00816', 'УЛ.ВИТАНОВ ДОЛ (В.З.КИТКАТА)'),
	('01463', '37914', '00828', 'УЛ.ВАСИЛИЦА'),
	('01464', '37914', '00833', 'УЛ.СТРАНДЖА ПЛАНИНА'),
	('01465', '37914', '00847', 'УЛ.ДОЛНА БАТИЙНИЦА'),
	('01466', '37914', '00850', 'УЛ.МАЛИ СПАС'),
	('01467', '37914', '00864', 'УЛ.БЯЛА НИВА'),
	('01468', '37914', '00878', 'УЛ.ГОРНА БАТИЙНИЦА'),
	('01469', '37914', '00881', 'УЛ.БЕЛИТЕ ЧЕРЕШИ'),
	('01470', '37914', '00895', 'УЛ.ТЪРНОВА ПАДИНА'),
	('01471', '37914', '00967', 'УЛ.СВЕЖ ПЪТ'),
	('01472', '39791', '00014', 'УЛ.ПРОСВЕТА'),
	('01473', '39791', '00028', 'УЛ.ВИТОША'),
	('01474', '39791', '00031', 'УЛ.ГРАДИНА (3-ТА)'),
	('01475', '39791', '00045', 'УЛ.ТИХАТА (4-ТА)'),
	('01476', '39791', '00059', 'УЛ.БАЛАБАНА'),
	('01477', '39791', '00062', 'УЛ.ЛЮЛЯК'),
	('01478', '39791', '00076', 'УЛ.РУЖА (7-МА)'),
	('01479', '39791', '00084', 'УЛ.МИНЗУХАР'),
	('01480', '39791', '00093', 'УЛ.СТАРА ПЛАНИНА'),
	('01481', '39791', '00103', 'УЛ.РИЛА'),
	('01482', '39791', '00120', 'УЛ.ДЕМОКРАЦИЯ'),
	('01483', '39791', '00134', 'УЛ.ЛАТИНКА'),
	('01484', '39791', '00148', 'УЛ.БОЖУР'),
	('01485', '39791', '00151', 'УЛ.РАВНОПОЛСКИ ПЪТ'),
	('01486', '39791', '00165', 'УЛ.ЙОСИФ ОБЕРБАУЕР'),
	('01487', '39791', '00179', 'УЛ.ДЪГА'),
	('01488', '39791', '00182', 'УЛ.РОЗОВА ГРАДИНА'),
	('01489', '39791', '00206', 'УЛ.СТАРАТА РЕКА'),
	('01490', '39791', '00215', 'УЛ.РИБАРНИКА'),
	('01491', '39791', '00223', 'УЛ.СТРАНДЖА'),
	('01492', '39791', '00237', 'УЛ.БАЛКАН'),
	('01493', '39791', '00240', 'УЛ.ЗАД СЕЛО (24-ТА)'),
	('01494', '39791', '00254', 'УЛ.РИМСКА РАКЛА'),
	('01495', '39791', '00285', 'УЛ.ИСКЪР'),
	('01496', '39791', '00326', 'УЛ.СВЕТИ СПАС (26-ТА)'),
	('01497', '39791', '00456', 'УЛ.ЦАР БОРИС III'),
	('01498', '39791', '15120', 'УЛ.ТОДОР РАДУНЧЕВ'),
	('01499', '40436', '00014', 'ПЛ.КУМАНИЦА'),
	('01500', '40436', '00028', 'БУЛ.СОФИЯ'),
	('01501', '40436', '00031', 'УЛ.ШИПКА'),
	('01502', '40436', '00045', 'УЛ.ХРИСТО БОТЕВ'),
	('01503', '40436', '00059', 'УЛ.КИРИЛ ХРИСТОВ'),
	('01504', '40436', '00062', 'УЛ.СТЕФАН СТАМБОЛОВ'),
	('01505', '40436', '00076', 'УЛ.ЧЕРКОВНА'),
	('01506', '40436', '00084', 'УЛ.НИКОЛА ПЕТКОВ'),
	('01507', '40436', '00093', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01508', '40436', '00117', 'УЛ.ЖЕЛЕЗОПЪТНА (1-ВА)'),
	('01509', '40436', '00120', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01510', '40436', '00134', 'УЛ.ТРАКИЙСКА МОГИЛА (4-ТА)'),
	('01511', '40436', '00148', 'УЛ.ПЕТКО Д.ПЕТКОВ'),
	('01512', '40436', '00165', 'УЛ.ИВАН ВАЗОВ (3-ТА)'),
	('01513', '40436', '00179', 'УЛ.СТАРА ПЛАНИНА (5-ТА)'),
	('01514', '40436', '00182', 'УЛ.ЗДРАВЕЦ (2-РА)'),
	('01515', '40436', '00285', 'УЛ.ИСКЪР (6-ТА)'),
	('01516', '40436', '00299', 'УЛ.МАЛКА БОНЕВИЦА'),
	('01517', '41010', '00014', 'УЛ.СИНИЯ ВИР'),
	('01518', '41010', '00028', 'УЛ.КОКИЧЕ'),
	('01519', '41010', '00031', 'УЛ.ЛЕТЕЦ'),
	('01520', '41010', '00045', 'БУЛ.СЛИВНИЦА'),
	('01521', '41010', '00059', 'УЛ.ЛОКОМОТИВ'),
	('01522', '41010', '00062', 'УЛ.ХРИСТО БОТЕВ'),
	('01523', '41010', '00076', 'УЛ.АКАЦИЯ'),
	('01524', '41010', '00084', 'УЛ.ЕЗЕРО'),
	('01525', '41010', '00093', 'УЛ.МЛАДЕЖКА'),
	('01526', '41010', '00103', 'УЛ.ИГЛИКА'),
	('01527', '41010', '00117', 'УЛ.НИКОЛА ХРИСТОВ'),
	('01528', '41010', '00120', 'УЛ.ДЪБИЦИТЕ'),
	('01529', '41010', '00134', 'УЛ.ЕДЕЛВАЙС'),
	('01530', '41010', '00148', 'УЛ.ПИРАМИДИТЕ'),
	('01531', '41010', '00151', 'УЛ.ПРОФЕСОРСКА'),
	('01532', '41010', '00165', 'УЛ.БУНТОВНИК'),
	('01533', '41010', '00179', 'УЛ.БАЛКАН'),
	('01534', '41010', '00182', 'УЛ.КАТИНА'),
	('01535', '41010', '00196', 'ПЛ.ПЛОЩАДА'),
	('01536', '41010', '00206', 'УЛ.ЗДРАВЧИ КАМЪК'),
	('01537', '41010', '00215', 'УЛ.БОР'),
	('01538', '41010', '00223', 'УЛ.ХАЙДУТИ'),
	('01539', '41010', '00237', 'УЛ.ЗДРАВЕЦ'),
	('01540', '41010', '00268', 'УЛ.СКАЛИТЕ'),
	('01541', '41010', '00271', 'УЛ.ЛАТИНКА'),
	('01542', '41010', '00285', 'УЛ.КЛИМЕНТ ОХРИДСКИ'),
	('01543', '41010', '00299', 'УЛ.МИНЬОР'),
	('01544', '41010', '00309', 'УЛ.АЛЕН МАК'),
	('01545', '41010', '00312', 'УЛ.ДЕТСКА ПЕСЕН'),
	('01546', '41010', '00518', 'УЛ.ЛАЛЕ'),
	('01547', '41010', '00549', 'УЛ.МИНЬОР'),
	('01548', '41010', '00401', 'УЛ.РАЙ'),
	('01549', '41010', '00655', 'УЛ.КОМАЯ'),
	('01550', '41010', '00669', 'УЛ.ЯВОРОВ ВРЪХ'),
	('01551', '41010', '00672', 'УЛ.НЕРЕЗЕНЕ'),
	('01552', '44063', '60112', 'БУЛ.ЦАРИГРАДСКО ШОСЕ'),
	('01553', '44063', '11555', 'УЛ.ПРОФ.НИКОЛА МАРИНОВ'),
	('01554', '44063', '00014', 'УЛ.СЪЕДИНЕНИЕ'),
	('01555', '44063', '00028', 'УЛ.ЗОРА'),
	('01556', '44063', '00031', 'УЛ.КРУШИТЕ (3-ТА)'),
	('01557', '44063', '00045', 'УЛ.МАРКОВА ЛИВАДА (4-ТА)'),
	('01558', '44063', '00059', 'УЛ.ДИВАНО (5-ТА)'),
	('01559', '44063', '00062', 'УЛ.СТАРАТА ЧЕШМА (6-ТА)'),
	('01560', '44063', '00076', 'УЛ.ВАРОВИТА (7-МА)'),
	('01561', '44063', '00084', 'УЛ.ХРИСТО БОТЕВ'),
	('01562', '44063', '00093', 'УЛ.МЕТОДИ БЕГОВ (9-ТА)'),
	('01563', '44063', '00103', 'УЛ.РУДИНАТА (10-ТА)'),
	('01564', '44063', '00117', 'УЛ.СЕРГИН СЕРДАРСКИ (11-ТА)'),
	('01565', '44063', '00134', 'УЛ.МАСЛАРИЦА (13-ТА)'),
	('01566', '44063', '00148', 'УЛ.НЕВЕН'),
	('01567', '44063', '00151', 'УЛ.МАЛИНА (15-ТА)'),
	('01568', '44063', '00165', 'УЛ.МОГИЛА (16-ТА)'),
	('01569', '44063', '00182', 'УЛ.НЕНКО ГЕРМАНСКИ (18-ТА)'),
	('01570', '44063', '00196', 'УЛ.РАКИТА (19-ТА)'),
	('01571', '44063', '00206', 'УЛ.ЛОЗЕНСКА ПЛАНИНА (20-ТА)'),
	('01572', '44063', '00215', 'УЛ.САДИНА (21-ВА)'),
	('01573', '44063', '00237', 'УЛ.КИПАРИС (22-РА)'),
	('01574', '44063', '00240', 'УЛ.ПОЛУВРАК (24-ТА)'),
	('01575', '44063', '00254', 'УЛ.ХАДЖИ ДИМИТЪР'),
	('01576', '44063', '00268', 'УЛ.ОБРЕТЕНИЦА (26-ТА)'),
	('01577', '44063', '00271', 'УЛ.СУХОДОЛ (27-МА)'),
	('01578', '44063', '00285', 'УЛ.ПРОГОНО (28-МА)'),
	('01579', '44063', '00299', 'УЛ.БЛАЗНА (29-ТА)'),
	('01580', '44063', '00309', 'УЛ.БРЕЗА (30-ТА)'),
	('01581', '44063', '00312', 'УЛ.КАРАДЖИН (31-ВА)'),
	('01582', '44063', '00326', 'УЛ.ВРЪХ ОСТРОКАП (32-РА)'),
	('01583', '44063', '00330', 'УЛ.ПРОЛЕТНА'),
	('01584', '44063', '00343', 'УЛ.АЛЬОВИЦА (34-ТА)'),
	('01585', '44063', '00357', 'УЛ.ГАБЕР'),
	('01586', '44063', '00360', 'УЛ.ЗАГРАДЕНА ПОЛЯНА (36-ТА)'),
	('01587', '44063', '00374', 'УЛ.МИНЗУХАР (37-МА)'),
	('01588', '44063', '00388', 'УЛ.БОРОВА ГОРА'),
	('01589', '44063', '00391', 'УЛ.СТЕФАН СТАМБОЛОВ'),
	('01590', '44063', '00432', 'УЛ.АКАЦИЯ (43-ТА)'),
	('01591', '44063', '00446', 'УЛ.ЯВОР (44-ТА)'),
	('01592', '44063', '00456', 'УЛ.ЯСЕН (45-ТА)'),
	('01593', '44063', '00463', 'УЛ.ДЪБ (46-ТА)'),
	('01594', '44063', '00477', 'УЛ.БОР (47-МА)'),
	('01595', '44063', '00480', 'УЛ.ЛИПА (48-МА)'),
	('01596', '44063', '00494', 'УЛ.КОРИЯ (49-ТА)'),
	('01597', '44063', '00504', 'УЛ.КАСИ ДОЛ (50-ТА)'),
	('01598', '44063', '00521', 'УЛ.АЛЕН МАК (52-РА)'),
	('01599', '44063', '00535', 'УЛ.РАЙКЯ (53-ТА)'),
	('01600', '44063', '00549', 'УЛ.РАДИЛИЦА (54-ТА)'),
	('01601', '44063', '00552', 'УЛ.МУРГАШ (55-ТА)'),
	('01602', '44063', '00566', 'УЛ.МУСАЛА (56-ТА)'),
	('01603', '44063', '00571', 'УЛ.ТРЪНСКИ ПЪТ (57-МА)'),
	('01604', '44063', '00583', 'УЛ.СИНЧЕЦ'),
	('01605', '44063', '00597', 'УЛ.ШИПКА (59-ТА)'),
	('01606', '44063', '00607', 'УЛ.ЗОРНИЦА (60-ТА)'),
	('01607', '44063', '00610', 'УЛ.ЛАТИНКА (61-ВА)'),
	('01608', '44063', '00624', 'УЛ.ИЗВОР (62-РА)'),
	('01609', '44063', '00638', 'УЛ.ЛАЛЕ (63-ТА)'),
	('01610', '44063', '00641', 'УЛ.РИДО (64-ТА)'),
	('01611', '44063', '00655', 'УЛ.ЯНКО ВЕЛИНОВ (65-ТА)'),
	('01612', '44063', '00669', 'УЛ.СТОЯН ЙОНКОВ (66-ТА)'),
	('01613', '44063', '00672', 'УЛ.КОКИЧЕ (67-МА)'),
	('01614', '44063', '00697', 'УЛ.БУЗЛУДЖА (69-ТА)'),
	('01615', '44063', '00702', 'УЛ.БРЪШЛЯН (70-ТА)'),
	('01616', '44063', '00713', 'УЛ.ЧЕМШИР (71-ВА)'),
	('01617', '44063', '00727', 'УЛ.ЕДЕЛВАЙС (72-РА)'),
	('01618', '44063', '00730', 'УЛ.ЦВЕТНА ГРАДИНА (73-ТА)'),
	('01619', '44063', '00744', 'УЛ.ЯНКО ПАНАЙОТОВ (74-ТА)'),
	('01620', '44063', '00758', 'УЛ.ХРИЗАНТЕМА (75-ТА)'),
	('01621', '44063', '00761', 'УЛ.НАРЦИС (76-ТА)'),
	('01622', '44063', '00775', 'УЛ.ЛЮЛЯК (77-МА)'),
	('01623', '44063', '00789', 'УЛ.САМОКОВСКИ ПЪТ (78-МА)'),
	('01624', '44063', '00792', 'УЛ.ГОРНИК (79-ТА)'),
	('01625', '44063', '00802', 'УЛ.РАЛИЦА (80-ТА)'),
	('01626', '44063', '00816', 'УЛ.ИСКРА (81-ВА)'),
	('01627', '44063', '00828', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('01628', '44063', '00833', 'УЛ.ШИШИВАР (83-ТА)'),
	('01629', '44063', '00847', 'УЛ.ГОРОЦВЕТ (84-ТА)'),
	('01630', '44063', '00850', 'УЛ.ГОРИЦА (85-ТА)'),
	('01631', '44063', '00864', 'УЛ.ПРОСТОР (86-ТА)'),
	('01632', '44063', '00878', 'УЛ.МОМИНА СЪЛЗА (87-МА)'),
	('01633', '44063', '00881', 'УЛ.ЗДРАВЕЦ'),
	('01634', '44063', '00895', 'УЛ.КАЙГАНА'),
	('01635', '44063', '00905', 'УЛ.БРОЖДАН (90-ТА)'),
	('01636', '44063', '00919', 'УЛ.ДЕТЕЛИНА (91-ВА)'),
	('01637', '44063', '00922', 'УЛ.НЕЗАБРАВКА (92-РА)'),
	('01638', '44063', '00936', 'УЛ.ВЕЛКОВА ВОДЕНИЦА (93-ТА)'),
	('01639', '44063', '00943', 'УЛ.РОЗА'),
	('01640', '44063', '00953', 'УЛ.ИЗГРЕВ'),
	('01641', '44063', '00967', 'УЛ.ИВАН ПЕШЕВ'),
	('01642', '44063', '00984', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01643', '44063', '01002', 'УЛ.СВЕТИ СПАС'),
	('01644', '44063', '01016', 'УЛ.ГЕОРГИ БЕНКОВСКИ'),
	('01645', '44063', '01050', 'УЛ.РАШОВЕЦ'),
	('01646', '44063', '01064', 'УЛ.СТУДЕН КЛАДЕНЕЦ'),
	('01647', '44063', '01078', 'УЛ.ИБРОВИЦА'),
	('01648', '44063', '01081', 'УЛ.ГЕРГАНА'),
	('01649', '44063', '01095', 'УЛ.ИГЛИКА'),
	('01650', '44063', '01105', 'УЛ.ТЕМЕНУГА'),
	('01651', '44063', '01119', 'УЛ.ГРАДИЩЕ'),
	('01652', '44063', '01122', 'УЛ.ПРЕСЛАВ'),
	('01653', '44063', '01140', 'УЛ.ЕДИНСТВО'),
	('01654', '44063', '01153', 'УЛ.ЛИЛИЯ'),
	('01655', '44063', '01167', 'УЛ.СОПОХ'),
	('01656', '44063', '01170', 'УЛ.СТАДИОНА'),
	('01657', '44063', '01198', 'УЛ.СУКАРИЦА'),
	('01658', '44063', '01225', 'УЛ.КИТКА'),
	('01659', '44063', '01239', 'УЛ.ЧЕРКОВНА'),
	('01660', '44063', '01242', 'УЛ.КАЛИНА'),
	('01661', '44063', '01256', 'УЛ.ДИМИТРОВЧЕ'),
	('01662', '44063', '01266', 'УЛ.СВЕТЛИНА'),
	('01663', '44063', '01300', 'УЛ.ТРАКИЯ (В.З.ВРАНА-ЛОЗЕН)'),
	('01664', '44063', '01314', 'УЛ.ИСКЪР (В.З.ВРАНА-ЛОЗЕН)'),
	('01665', '44063', '01331', 'УЛ.ВИТОША (В.З.ВРАНА-ЛОЗЕН)'),
	('01666', '44063', '01345', 'УЛ.ПИРИН (В.З.ВРАНА-ЛОЗЕН)'),
	('01667', '44063', '01362', 'УЛ.МАРИЦА (В.З.ВРАНА-ЛОЗЕН)'),
	('01668', '44063', '01376', 'УЛ.РИЛА (В.З.ВРАНА-ЛОЗЕН)'),
	('01669', '44063', '01381', 'УЛ.ТИНТЯВА (В.З.ВРАНА-ЛОЗЕН)'),
	('01670', '44063', '01393', 'УЛ.РОДОПИ (В.З.ВРАНА-ЛОЗЕН)'),
	('01671', '44063', '01403', 'УЛ.СТРУМА (В.З.ВРАНА-ЛОЗЕН)'),
	('01672', '44063', '01417', 'УЛ.КАМЧИЯ (В.З.ВРАНА-ЛОЗЕН)'),
	('01673', '44063', '01420', 'УЛ.РОПОТАМО (В.З.ВРАНА-ЛОЗЕН)'),
	('01674', '44063', '01434', 'УЛ.АРДА (В.З.ВРАНА-ЛОЗЕН)'),
	('01675', '44063', '01448', 'УЛ.ЕРМА (В.З.ВРАНА-ЛОЗЕН)'),
	('01676', '44063', '01451', 'УЛ.ТИМОК (В.З.ВРАНА-ЛОЗЕН)'),
	('01677', '44063', '01465', 'УЛ.ВЕЛЕКА (В.З.ВРАНА-ЛОЗЕН)'),
	('01678', '44063', '01479', 'УЛ.ВИТ (В.З.ВРАНА-ЛОЗЕН)'),
	('01679', '44063', '01482', 'УЛ.БЯЛО МОРЕ(В.З.ВРАНА-ЛОЗЕН)'),
	('01680', '44063', '01506', 'УЛ.ВЕРИЛА (В.З.ВРАНА-ЛОЗЕН)'),
	('01681', '44063', '01512', 'УЛ.ДУНАВ (В.З.ВРАНА-ЛОЗЕН)'),
	('01682', '44063', '01599', 'УЛ.СТАР ЛОЗЕНСКИ ПЪТ'),
	('01683', '44063', '01609', 'УЛ.ВЕСЛЕЦ (В.З.ВРАНА-ЛОЗЕН)'),
	('01684', '44063', '01612', 'УЛ.ВИСО (В.З.ВРАНА-ЛОЗЕН)'),
	('01685', '44063', '10001', 'УЛ.НАШ ДОМ'),
	('01686', '44063', '11209', 'УЛ.ВИЛНА'),
	('01687', '44063', '11380', 'УЛ.БОЖУР'),
	('01688', '44063', '01359', 'УЛ.ЛЮЛИН ПЛАНИНА(В.З.ВРАНА-ЛОЗ'),
	('01689', '44063', '01328', 'УЛ.СТАРА ПЛАНИНА(В.З.ВРАНА-ЛОЗ'),
	('01690', '44063', '01496', 'УЛ.ЧЕРНО МОРЕ(В.З.ВРАНА-ЛОЗЕН)'),
	('01691', '44063', '10422', 'УЛ.ЛОЗЕН'),
	('01692', '44063', '15331', 'УЛ.НИКОЛА ШИПКОВЕНСКИ'),
	('01693', '44063', '01626', 'УЛ.АЗМАЦИТЕ'),
	('01694', '44063', '16715', 'УЛ.ГОРНО ГРАДИЩЕ'),
	('01695', '44063', '18784', 'УЛ.РАЙОВЕЦ'),
	('01696', '44063', '12005', 'УЛ.СОПОХСКА БАРА'),
	('01697', '44063', '12019', 'УЛ.БЕЛИ РИД'),
	('01698', '44063', '04995', 'УЛ.ЧАУШИЦА'),
	('01699', '44063', '02066', 'УЛ.ОРЛОВА КРУША'),
	('01700', '44063', '10402', 'УЛ.ЧЕТИРИЛИСТНА ДЕТЕЛИНА'),
	('01701', '44063', '12245', 'УЛ.МАНАСТИРСКА ГОРА'),
	('01702', '44224', '00014', 'УЛ.ВЕСКО ВЕСЕЛИНОВ'),
	('01703', '44224', '00028', 'УЛ.НЕНКО КОЛЕВ'),
	('01704', '44224', '00031', 'УЛ.ДАНАИЛ ЛАСКОВ'),
	('01705', '44224', '00045', 'УЛ.ГЕОРГИ ЗОЗОВ'),
	('01706', '44224', '00059', 'УЛ.ПЕТКО СИМЕОНОВ'),
	('01707', '44224', '00062', 'УЛ.СЛАВЕ ТУРЧЕВ'),
	('01708', '44224', '00076', 'УЛ.КОСТАДИН ТРАЙКОВ'),
	('01709', '44224', '00084', 'УЛ.ГЕОРГИ ПАЛЕВ'),
	('01710', '44224', '00093', 'УЛ.БЛАГОЙ ГЕРДИН'),
	('01711', '44224', '00103', 'УЛ.ХРИСТО МАНОВ'),
	('01712', '44224', '00117', 'УЛ.БРАТЯ ЛИМБРОВИ'),
	('01713', '44224', '00120', 'УЛ.КИРИЛ БАНОВ'),
	('01714', '44224', '00134', 'УЛ.ТУПИК'),
	('01715', '44224', '00148', 'УЛ.ПОРУЧИК БОЖ.БОЖИЛОВ'),
	('01716', '44224', '00151', 'УЛ.ПЕТЪР БЕЛЕВ'),
	('01717', '44224', '00165', 'УЛ.ИЛИЯ ДЖАГАРОВ'),
	('01718', '44224', '00179', 'УЛ.ПОП СТОИЛ ПЕТКОВ'),
	('01719', '44224', '00196', 'УЛ.ДРАГОНАТА'),
	('01720', '44224', '00206', 'УЛ.БОГДАН МАНОЛОВ'),
	('01721', '44224', '00215', 'УЛ.ДОНЧО КОСТОВ'),
	('01722', '44224', '00223', 'УЛ.ЦВЕТАН ПЕШЕВ'),
	('01723', '44224', '00237', 'УЛ.ТОДОР ГАДЖОВ'),
	('01724', '44224', '00254', 'УЛ.ТОДОР ВЕЛИЧКОВ'),
	('01725', '44224', '00268', 'УЛ.ГАВРИЛ ДИМИТРОВ'),
	('01726', '44224', '00271', 'УЛ.ЧЕРКОВНА'),
	('01727', '44224', '00285', 'УЛ.КОСТАДИН ПЕТРОВ'),
	('01728', '44224', '00299', 'УЛ.ХРИСТО ВИТКОВ'),
	('01729', '44224', '60006', 'БУЛ.ДИМИТЪР ТОШКОВ'),
	('01730', '44224', '60012', 'БУЛ.ИЛИЯ МАНОВ'),
	('01731', '44224', '60023', 'УЛ.ЕВЛОГИ ТОДОРОВ'),
	('01732', '44224', '70007', 'ПЛ.ЧАВДАРЦИ'),
	('01733', '44224', '00309', 'УЛ.СЛЪНЧЕВА ПЛАНИНА'),
	('01734', '44224', '60602', 'БУЛ.БОЖИН ЛАСКОВ'),
	('01735', '46721', '35362', 'УЛ.ГЕОРГИ БЕНКОВСКИ'),
	('01736', '46721', '00014', 'УЛ.ФИЛИП Б.КОСТОВ (1-ВА)'),
	('01737', '46721', '00028', 'УЛ.ЛЮЛИН (2-РА)'),
	('01738', '46721', '00031', 'УЛ.ДЕМОКРАЦИЯ (3-ТА)'),
	('01739', '46721', '00045', 'УЛ.БОЯН Б.КОСТОВ (4-ТА)'),
	('01740', '46721', '00059', 'УЛ.СТАРА ПЛАНИНА (5-ТА)'),
	('01741', '46721', '00062', 'УЛ.ЕДЕЛВАЙС (6-ТА)'),
	('01742', '46721', '00076', 'УЛ.ВИТОША (7-МА)'),
	('01743', '46721', '00084', 'УЛ.НИКОЛА ПЕТКОВ (8-МА)'),
	('01744', '46721', '00093', 'УЛ.БОР (9-ТА)'),
	('01745', '46721', '00103', 'УЛ.КОМ (10-ТА)'),
	('01746', '46721', '00117', 'УЛ.БОРИС НАЙДЕНОВ (11-ТА)'),
	('01747', '46721', '00120', 'УЛ.ЛИПА (12-ТА)'),
	('01748', '46721', '00134', 'УЛ.ОСЪМ'),
	('01749', '46721', '00148', 'УЛ.СТРАНДЖА'),
	('01750', '46721', '00165', 'УЛ.РИЛА'),
	('01751', '46721', '00182', 'УЛ.ДЪБ (13-ТА)'),
	('01752', '46721', '00196', 'УЛ.ОВЧА МОГИЛА'),
	('01753', '46721', '00206', 'УЛ.КОЛЬО ФИЧЕТО'),
	('01754', '46721', '00215', 'УЛ.ОРЛИЦА'),
	('01755', '46721', '00223', 'УЛ.КОКИЧЕ'),
	('01756', '46721', '00237', 'УЛ.ДИМОТИКА'),
	('01757', '46721', '00240', 'УЛ.БАНСКИ ПЪТ'),
	('01758', '46721', '00268', 'УЛ.ХАДЖИ ДИМИТЪР(В.З.СИМОНИЦА)'),
	('01759', '46721', '00271', 'УЛ.ВАСИЛ ЛЕВСКИ(В.З.СИМОНИЦА)'),
	('01760', '46721', '00285', 'УЛ.ХРИСТО БОТЕВ(В.З.СИМОНИЦА)'),
	('01761', '46721', '00299', 'УЛ.ГЕОРГИ РАКОВСКИ (ВЗ.СИМОН.)'),
	('01762', '46721', '00309', 'УЛ.БЕНКОВСКА (В.З.СИМОНИЦА)'),
	('01763', '46721', '00312', 'УЛ.ВИД (В.З.ПЛАДНИЩЕ)'),
	('01764', '46721', '00326', 'УЛ.ИСКЪР (В.З.ПЛАДНИЩЕ)'),
	('01765', '46721', '00330', 'УЛ.МУРГАШ (В.З.ПЛАДНИЩЕ)'),
	('01766', '46721', '00343', 'УЛ.ПИРИН (В.З.ПЛАДНИЩЕ)'),
	('01767', '46721', '00357', 'УЛ.РОДОПИ (В.З.ПЛАДНИЩЕ)'),
	('01768', '46721', '00360', 'УЛ.ЯНТРА (В.З.ПЛАДНИЩЕ)'),
	('01769', '46721', '00374', 'УЛ.МАЛОБУЧИНСКИ ПЪТ'),
	('01770', '46721', '00388', 'УЛ.РАЗСАДНИКА (В.З.МАН.ДОЛ)'),
	('01771', '46721', '00391', 'УЛ.ЛИПА (В.З.МАН.ДОЛ)'),
	('01772', '46721', '00415', 'УЛ.БОР (В.З.МАНИЛОВ ДОЛ)'),
	('01773', '46721', '00429', 'УЛ.БОЖУР (В.З.МАНИЛОВ ДОЛ)'),
	('01774', '46721', '00432', 'УЛ.МАЛИНА (В.З.МАНИЛОВ ДОЛ)'),
	('01775', '46721', '00446', 'УЛ.МАРГАРИТА (В.З.МАН.ДОЛ)'),
	('01776', '46721', '00456', 'УЛ.ЯЗОВИРНА (В.З.МАН.ДОЛ)'),
	('01777', '46721', '00477', 'УЛ.СВЕЖЕСТ'),
	('01778', '46721', '00480', 'УЛ.ТИХ КЪТ'),
	('01779', '46721', '00494', 'УЛ.ПЛАДНИЩЕ'),
	('01780', '46721', '00463', 'УЛ.СТЕФАН КАРАДЖА(В.З.СИМОНИЦА'),
	('01781', '46721', '01609', 'УЛ.СЛАВ ХР.КАРАСЛАВОВ'),
	('01782', '48393', '00028', 'УЛ.ПАРАШУТИСТ'),
	('01783', '48393', '00031', 'УЛ.ПЛАНИНЕЦ'),
	('01784', '48393', '00045', 'УЛ.МАРИЦА'),
	('01785', '48393', '00059', 'УЛ.АЛЕКО КОНСТАНТИНОВ'),
	('01786', '48393', '00062', 'УЛ.МИРОВСКО ШОСЕ'),
	('01787', '48393', '00084', 'УЛ.ПЕТКО КАРАВЕЛОВ'),
	('01788', '48393', '00093', 'УЛ.МИНЗУХАР'),
	('01789', '48393', '00103', 'УЛ.ОРЛИН'),
	('01790', '48393', '00117', 'УЛ.МАЛУША'),
	('01791', '48393', '00120', 'УЛ.МЕСЕМБРИЯ'),
	('01792', '48393', '00134', 'УЛ.ХРИСТО БОТЕВ'),
	('01793', '48393', '00148', 'УЛ.СПОРТИСТ'),
	('01794', '48393', '00151', 'УЛ.КАЗАНДЖИЙСКА'),
	('01795', '48393', '00165', 'УЛ.ПЕРУНИКА'),
	('01796', '48393', '00179', 'УЛ.ЧАВДАР ВОЙВОДА'),
	('01797', '48393', '00182', 'УЛ.ЛЕЯРНА'),
	('01798', '48393', '00196', 'УЛ.ИВАЙЛО'),
	('01799', '48393', '00206', 'УЛ.ТОПОЛА'),
	('01800', '48393', '00215', 'УЛ.ЛЮБИМЕЦ'),
	('01801', '48393', '00223', 'УЛ.ВЕТРЕН'),
	('01802', '48393', '00237', 'УЛ.ЕДЕЛВАЙС'),
	('01803', '48393', '00240', 'УЛ.АЛЕН МАК'),
	('01804', '48393', '00254', 'УЛ.СИНИ ВИР'),
	('01805', '48393', '00268', 'ПЛ.ВАСИЛ ЛЕВСКИ'),
	('01806', '48393', '00271', 'УЛ.ЛЕДЕНИКА'),
	('01807', '48393', '00285', 'УЛ.РАДЕЦКИ'),
	('01808', '48393', '00299', 'УЛ.КОЗЛОДУЙСКИ БРЯГ'),
	('01809', '48393', '00309', 'УЛ.БЛАТО'),
	('01810', '48393', '00312', 'УЛ.ИГЛИКА'),
	('01811', '48393', '00326', 'УЛ.ХВОЙНА'),
	('01812', '48393', '00330', 'УЛ.МОМИНА СЪЛЗА'),
	('01813', '48393', '00357', 'УЛ.ЯСТРЕБ'),
	('01814', '48393', '00388', 'УЛ.ВИШНОВСКА'),
	('01815', '48393', '00391', 'УЛ.ИВАН ВАЗОВ'),
	('01816', '48393', '00401', 'УЛ.КАПТАЖА'),
	('01817', '48393', '00504', 'УЛ.КАНАЛА'),
	('01818', '48393', '00360', 'УЛ.ИНДУСТРИАЛЕН ПЪТ'),
	('01819', '48393', '00686', 'УЛ.АГЛИКИНА ПОЛЯНА'),
	('01820', '48393', '00076', 'УЛ.ПЪРВЕНЕЦ'),
	('01821', '49206', '00014', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01822', '49206', '00028', 'УЛ.ЕДЕЛВАЙС (2-РА)'),
	('01823', '49206', '00084', 'УЛ.ОРХИДЕЯ (8-МА)'),
	('01824', '49206', '00093', 'УЛ.ВЪРБА (9-ТА)'),
	('01825', '49206', '00117', 'УЛ.ХАЙДУТИН (11-ТА)'),
	('01826', '49206', '00120', 'УЛ.ЯВОР (12-ТА)'),
	('01827', '49206', '00134', 'УЛ.МОМИНА СЪЛЗА (13-ТА)'),
	('01828', '49206', '00148', 'УЛ.ИВАЙЛО'),
	('01829', '49206', '00151', 'УЛ.АЛЕКО КОНСТАНТИНОВ'),
	('01830', '49206', '00196', 'УЛ.НАРЦИС (19-ТА)'),
	('01831', '49206', '00206', 'УЛ.РЕПУБЛИКА (20-ТА)'),
	('01832', '49206', '00215', 'УЛ.БЛАТО (21-ВА)'),
	('01833', '49206', '00223', 'УЛ.ЕМИЛИЯН СТАНЕВ (22-РА)'),
	('01834', '49206', '00237', 'УЛ.РОСИЦА'),
	('01835', '49206', '00240', 'УЛ.ЙОРДАН ЙОВКОВ (24-ТА)'),
	('01836', '49206', '00254', 'УЛ.ПЛАМЪК (25-ТА)'),
	('01837', '49206', '00268', 'УЛ.ЧИЧОВЦИ (26-ТА)'),
	('01838', '49206', '00271', 'УЛ.МАЙСКИ ДЕН (27-МА)'),
	('01839', '49206', '00285', 'УЛ.3-ТИ МАРТ'),
	('01840', '49206', '00309', 'УЛ.ХРИСТО БОТЕВ'),
	('01841', '49206', '00312', 'УЛ.РОСНА КИТКА (31-ВА)'),
	('01842', '49206', '00518', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('01843', '49206', '00521', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01844', '49206', '00535', 'УЛ.ЗАХАРИ ЗОГРАФ'),
	('01845', '49206', '00549', 'УЛ.КОСТА СПАСОВ'),
	('01846', '49206', '00552', 'УЛ.ДЕТСКИ СВЯТ'),
	('01847', '49206', '00566', 'УЛ.КЛАДЕНЧЕТО'),
	('01848', '49206', '00571', 'УЛ.ПЕНЧО СЛАВЕЙКОВ'),
	('01849', '49206', '00583', 'УЛ.ИВАН ВАЗОВ'),
	('01850', '49206', '00597', 'УЛ.ЛЮБЕН КАРАВЕЛОВ'),
	('01851', '49206', '00607', 'УЛ.ЗАХАРИ СТОЯНОВ'),
	('01852', '49206', '00610', 'УЛ.ПАПРАТ'),
	('01853', '49206', '00624', 'УЛ.МИЧУР'),
	('01854', '49206', '00059', 'УЛ.5 (ЗАХАРИ СТОЯНОВ)'),
	('01855', '49206', '00062', 'УЛ.6 (ПАПРАТ)'),
	('01856', '49206', '66041', 'БУЛ.ЛОМСКО ШОСЕ'),
	('01857', '49206', '00165', 'УЛ.МРАМОРЕН РИД'),
	('01858', '49206', '00179', 'УЛ.ЦЪРНА БАРА'),
	('01859', '49206', '00182', 'УЛ.БОРО'),
	('01860', '49206', '05061', 'УЛ.БИЛКА'),
	('01861', '49206', '05075', 'УЛ.РУЙНИ ВОДИ'),
	('01862', '49206', '05102', 'УЛ.МАГАРАНИЦА'),
	('01863', '49206', '04892', 'УЛ.ТЕМЕНУЖКА'),
	('01864', '49597', '06063', 'УЛ.ЧЕРНИТЕ СКАЛИ'),
	('01865', '49597', '00014', 'УЛ.ЦАР СИМЕОН I'),
	('01866', '49597', '00028', 'УЛ.ТРЕНДИФИЛ'),
	('01867', '49597', '00031', 'УЛ.ПРИМОРСКО'),
	('01868', '49597', '00045', 'УЛ.БИСТРА РЕКА'),
	('01869', '49597', '00059', 'УЛ.ЦЕРОВА ПОЛЯНА'),
	('01870', '49597', '00062', 'УЛ.ЧЕРЕШОВА ГРАДИНА'),
	('01871', '49597', '00076', 'УЛ.МАНИШ'),
	('01872', '49597', '00084', 'УЛ.УСОЙКА'),
	('01873', '49597', '00093', 'УЛ.21-ВА'),
	('01874', '49597', '00103', 'УЛ.22-РА'),
	('01875', '49597', '00134', 'УЛ.КАСИС'),
	('01876', '49597', '00148', 'УЛ.КАСИОПЕЯ'),
	('01877', '49597', '00151', 'УЛ.ЗЮМБЮЛ'),
	('01878', '49597', '00165', 'УЛ.КАЛО'),
	('01879', '49597', '00179', 'УЛ.СИНИТЕ ВЪЛНИ'),
	('01880', '49597', '00182', 'УЛ.24-ТА'),
	('01881', '49597', '00196', 'УЛ.7-МА'),
	('01882', '49597', '00206', 'УЛ.10-ТА'),
	('01883', '49597', '00215', 'УЛ.11-ТА'),
	('01884', '49597', '00223', 'УЛ.19-ТА'),
	('01885', '49597', '00237', 'УЛ.20-ТА'),
	('01886', '49597', '00240', 'УЛ.23-ТА'),
	('01887', '49597', '00254', 'УЛ.РУДАРСКИ ПЪТ'),
	('01888', '49597', '00271', 'УЛ.ПЕЧИЩЕ'),
	('01889', '51250', '00014', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('01890', '51250', '00031', 'УЛ.БОРИС НАЙДЕНОВ'),
	('01891', '51250', '00045', 'УЛ.ВРАЧАНСКА'),
	('01892', '51250', '00059', 'УЛ.ЕМАНУИЛ АЛЕКСАНДРОВ'),
	('01893', '51250', '00062', 'УЛ.ДОНКОВА'),
	('01894', '51250', '00076', 'УЛ.ИВАН ГРОЗДАНОВ'),
	('01895', '51250', '00084', 'УЛ.ИЗВОРА'),
	('01896', '51250', '00093', 'УЛ.ИСКЪРСКА'),
	('01897', '51250', '00103', 'УЛ.КАЛЕВ БРЯГ'),
	('01898', '51250', '00117', 'УЛ.ЦАР СИМЕОН'),
	('01899', '51250', '00120', 'УЛ.КОЦИНА МАХАЛА'),
	('01900', '51250', '00134', 'УЛ.КРАЙНА'),
	('01901', '51250', '00148', 'УЛ.ЛЕСОПАРК'),
	('01902', '51250', '00151', 'УЛ.ЛЪКАТА'),
	('01903', '51250', '00165', 'УЛ.МОГИЛАТА'),
	('01904', '51250', '00179', 'УЛ.НАГОРНА'),
	('01905', '51250', '00196', 'УЛ.НОВ ЖИВОТ'),
	('01906', '51250', '00206', 'УЛ.РАЗДЕЛНА'),
	('01907', '51250', '00215', 'УЛ.РИДО'),
	('01908', '51250', '00223', 'УЛ.СТЕФАН ПАВЛОВ'),
	('01909', '51250', '00237', 'УЛ.СТОПАНСКИ ДВОР'),
	('01910', '51250', '00240', 'УЛ.СТОЯН ТОДОРОВ'),
	('01911', '51250', '00254', 'УЛ.ТРУД'),
	('01912', '51250', '00268', 'УЛ.УЧИЛИЩНА'),
	('01913', '51250', '00271', 'УЛ.БЕЛИТЕ БРЕЗИ'),
	('01914', '51250', '00285', 'УЛ.ЧЕРВЕНА РОЗА'),
	('01915', '51250', '00299', 'УЛ.НЕЗАБРАВКА'),
	('01916', '51250', '00312', 'УЛ.ЕЗЕРАТА'),
	('01917', '51250', '00415', 'УЛ.ХРИСТО БОТЕВ'),
	('01918', '51250', '00429', 'УЛ.ТИНТЯВА'),
	('01919', '51250', '00432', 'УЛ.МАК'),
	('01920', '51250', '00446', 'УЛ.СИНЧЕЦ'),
	('01921', '51250', '00456', 'УЛ.ИНДУСТРИАЛНА'),
	('01922', '51250', '00463', 'УЛ.МАНАСТИРСКА'),
	('01923', '51250', '00477', 'УЛ.ВОДЕНИЦАТА'),
	('01924', '55419', '00014', 'УЛ.ПЕТЪР МЕНДЖИЙСКИ'),
	('01925', '55419', '00031', 'УЛ.ВУКОВА КОРИЯ'),
	('01926', '55419', '00045', 'УЛ.КУРИЯТА'),
	('01927', '55419', '00059', 'УЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('01928', '55419', '00062', 'УЛ.ДИМИТЪР ПЕНЕВ'),
	('01929', '55419', '00084', 'УЛ.ШУМАНЕЦ'),
	('01930', '55419', '00093', 'УЛ.БОР'),
	('01931', '55419', '00103', 'УЛ.ЛЕНИЩЕТО'),
	('01932', '55419', '00117', 'БУЛ.ЕЛИН ПЕЛИН'),
	('01933', '55419', '00120', 'УЛ.ЙОВАНЕЦ'),
	('01934', '55419', '00134', 'УЛ.ЮРИ ГАГАРИН'),
	('01935', '55419', '00151', 'УЛ.САМОКОВСКО ШОСЕ'),
	('01936', '55419', '00179', 'УЛ.ИВАН ШИШМАН'),
	('01937', '55419', '00182', 'УЛ.РИЛЯНИК'),
	('01938', '55419', '00196', 'УЛ.ЛОВДЖИЙСКА ЧЕШМА'),
	('01939', '55419', '00206', 'УЛ.ПЕТКО ВОЙВОДА'),
	('01940', '55419', '00215', 'УЛ.ДЕБЕЛО ГУНО'),
	('01941', '55419', '00223', 'УЛ.ДЪРВОДЕЛИЦА'),
	('01942', '55419', '00237', 'УЛ.ДИМИТЪР ПЕНЕВ'),
	('01943', '55419', '00240', 'УЛ.СТЕФАН ПЕТРОВ'),
	('01944', '55419', '00268', 'УЛ.УРВИЧ'),
	('01945', '55419', '00271', 'УЛ.СИНИ ВИР'),
	('01946', '55419', '00285', 'УЛ.ПАДИНЕТО'),
	('01947', '55419', '00299', 'УЛ.ЛЪКАТА'),
	('01948', '55419', '00309', 'УЛ.БИСТРИШКА РЕКА'),
	('01949', '55419', '00326', 'УЛ.ЯВОРОВ'),
	('01950', '55419', '00330', 'УЛ.ЛЕШНИК'),
	('01951', '55419', '00343', 'УЛ.КАСАНИН ДОЛ'),
	('01952', '55419', '00374', 'УЛ.3-ТА (В.З.МАЛИНОВА ДОЛИНА)'),
	('01953', '55419', '00391', 'УЛ.ДРУЖБА'),
	('01954', '55419', '00401', 'УЛ.БЕЛИКАТА'),
	('01955', '55419', '00429', 'УЛ.ДЕТЕЛИНА (31-ВА)'),
	('01956', '55419', '00456', 'УЛ.ДЪРЖОВ ДОЛ'),
	('01957', '55419', '00583', 'УЛ.ЧЕРЕШОВА ГРАДИНА'),
	('01958', '55419', '00922', 'УЛ.38-МА В.З.БЕЛИКАТА'),
	('01959', '55419', '04801', 'УЛ.4-ТА (В.З.МАЛИНОВА ДОЛИНА)'),
	('01960', '55419', '02191', 'УЛ.АВЛИГА (В.З.БЕЛИКАТА)'),
	('01961', '55419', '02004', 'УЛ.АКАЦИЯ (В.З.БЕЛИКАТА)'),
	('01962', '55419', '00669', 'УЛ.БАТИЙНИЦА (24-ТА)'),
	('01963', '55419', '02244', 'УЛ.БОЖУР (В.З.БЕЛИКАТА)'),
	('01964', '55419', '00655', 'УЛ.БОРОВА ГОРА (10-ТА)'),
	('01965', '55419', '02052', 'УЛ.БРЕЗА (В.З.БЕЛИКАТА)'),
	('01966', '55419', '02275', 'УЛ.БЪЛГАРКА (М.ГРАДИЩЕ)'),
	('01967', '55419', '00028', 'УЛ.ВАСИЛ ЛЕВСКИ (9 СЕПТЕМВРИ)'),
	('01968', '55419', '01638', 'УЛ.ДЕНИЦА (В.З.ГРАДИЩЕ)'),
	('01969', '55419', '02097', 'УЛ.ДЪБРАВА (В.З.БЕЛИКАТА)'),
	('01970', '55419', '00607', 'УЛ.ЕДЕЛВАЙС (5-ТА)'),
	('01971', '55419', '02021', 'УЛ.ЕЛА (В.З.БЕЛИКАТА)'),
	('01972', '55419', '00641', 'УЛ.ЗДРАВЕЦ (9-ТА)'),
	('01973', '55419', '01657', 'УЛ.ЗОРНИЦА (В.З.ГРАДИЩЕ)'),
	('01974', '55419', '00638', 'УЛ.ИГЛИКА (8-МА)'),
	('01975', '55419', '00566', 'УЛ.КАЛИНА (3-ТА)'),
	('01976', '55419', '02083', 'УЛ.КИПАРИС (В.З.БЕЛИКАТА)'),
	('01977', '55419', '02213', 'УЛ.КОКИЧЕ (В.З.БЕЛИКАТА)'),
	('01978', '55419', '00597', 'УЛ.ЛАТИНКА (4-ТА)'),
	('01979', '55419', '02049', 'УЛ.ЛИПА (В.З.БЕЛИКАТА)'),
	('01980', '55419', '01994', 'УЛ.ЛОЗНИЦА (В.З.БЕЛИКАТА)'),
	('01981', '55419', '00388', 'УЛ.ЛЮЛЯК (30-ТА)'),
	('01982', '55419', '02110', 'УЛ.МАК (В.З.БЕЛИКАТА)'),
	('01983', '55419', '02141', 'УЛ.МАЛИНА (В.З.БЕЛИКАТА)'),
	('01984', '55419', '02261', 'УЛ.МАРГАРИТА (В.З.БЕЛИКАТА)'),
	('01985', '55419', '02207', 'УЛ.МИНЗУХАР (В.З.БЕЛИКАТА)'),
	('01986', '55419', '01674', 'УЛ.МЛАДЕЖКА (В.З.ГРАДИЩЕ)'),
	('01987', '55419', '00624', 'УЛ.МОМИНА СЪЛЗА (7-МА)'),
	('01988', '55419', '02107', 'УЛ.МОРАВА (В.З.БЕЛИКАТА)'),
	('01989', '55419', '02230', 'УЛ.НАРЦИС (В.З.БЕЛИКАТА)'),
	('01990', '55419', '02124', 'УЛ.НЕВЕН (В.З.БЕЛИКАТА)'),
	('01991', '55419', '01612', 'УЛ.НЕЗАБРАВКА (В.З.ГРАДИЩЕ)'),
	('01992', '55419', '02258', 'УЛ.ОМАЙНИЧЕ (В.З.БЕЛИКАТА)'),
	('01993', '55419', '01643', 'УЛ.РАЛИЦА (В.З.ГРАДИЩЕ)'),
	('01994', '55419', '02138', 'УЛ.РОЗА (В.З.БЕЛИКАТА)'),
	('01995', '55419', '01626', 'УЛ.РОСА (В.З.ГРАДИЩЕ)'),
	('01996', '55419', '00165', 'УЛ.РУДЖЕРИ (В.КОЛАРОВ)'),
	('01997', '55419', '01660', 'УЛ.РУЖА (В.З.ГРАДИЩЕ)'),
	('01998', '55419', '02169', 'УЛ.СИНИГЕР (В.З.БЕЛИКАТА)'),
	('01999', '55419', '02227', 'УЛ.СИНЧЕЦ (В.З.БЕЛИКАТА)'),
	('02000', '55419', '02155', 'УЛ.СЛАВЕЙ (В.З.БЕЛИКАТА)'),
	('02001', '55419', '01599', 'УЛ.СЪЛЗИЦА (В.З.ГРАДИЩЕ)'),
	('02002', '55419', '00552', 'УЛ.ТЕМЕНУГА (2-РА)'),
	('02003', '55419', '01609', 'УЛ.ТИНТЯВА (В.З.ГРАДИЩЕ)'),
	('02004', '55419', '02018', 'УЛ.ТОПОЛА (В.З.БЕЛИКАТА)'),
	('02005', '55419', '02066', 'УЛ.ХВОЙНА (В.З.БЕЛИКАТА)'),
	('02006', '55419', '02172', 'УЛ.ЧУЧУЛИГА (В.З.БЕЛИКАТА)'),
	('02007', '55419', '02076', 'УЛ.ШИПКА (В.З.БЕЛИКАТА)'),
	('02008', '55419', '00610', 'УЛ.ЯВОР (6-ТА)'),
	('02009', '55419', '02186', 'УЛ.ЯГОДА (В.З.БЕЛИКАТА)'),
	('02010', '55419', '02035', 'УЛ.ЯСЕН (В.З.БЕЛИКАТА)'),
	('02011', '55419', '02717', 'УЛ.ПРОФ.АСЕН КИСЕЛИНЧЕВ'),
	('02012', '55419', '35756', 'УЛ.ГАУДИ (КОСАНИН ДОЛ)'),
	('02013', '55419', '10001', 'УЛ.ШЕГОБИЦА (ДЕТСКИ ГРАД)'),
	('02014', '55419', '10015', 'УЛ.СИНЯ СВЕТЛИНА (ДЕТСКИ ГРАД)'),
	('02015', '55419', '10029', 'УЛ.ПОНОР (ДЕТСКИ ГРАД)'),
	('02016', '55419', '10032', 'УЛ.МЕДЕНА ПИТКА (ДЕТСКИ ГРАД)'),
	('02017', '55419', '10046', 'УЛ.ХИТЪР ПЕТЪР (ДЕТСКИ ГРАД)'),
	('02018', '55419', '10050', 'УЛ.ЧАРДАЦИТЕ (ДЕТСКИ ГРАД)'),
	('02019', '55419', '10063', 'УЛ.ЗЛАТНА ЯБЪЛКА (ДЕТСКИ ГРАД)'),
	('02020', '55419', '10077', 'УЛ.ВЕСЕЛИНОВ РИД (ДЕТСКИ ГРАД)'),
	('02021', '55419', '10080', 'УЛ.ТАБАЦИТЕ (ДЕТСКИ ГРАД)'),
	('02022', '55419', '10094', 'УЛ.СИЯНИЕ (ДЕТСКИ ГРАД)'),
	('02023', '55419', '10104', 'УЛ.СИНАНИЦА (ДЕТСКИ ГРАД)'),
	('02024', '55419', '10118', 'УЛ.СТРАНЕТО (ДЕТСКИ ГРАД)'),
	('02025', '55419', '10121', 'УЛ.ЗЛАТНОТО МОМИЧЕ (Д. ГРАД)'),
	('02026', '55419', '10135', 'УЛ.ДРАГОЙЦА (ДЕТСКИ ГРАД)'),
	('02027', '55419', '10149', 'УЛ.МАНОЛ ВОЙВОДА (ДЕТСКИ ГРАД)'),
	('02028', '55419', '10152', 'УЛ.ПЕДЯ ЧОВЕК (ДЕТСКИ ГРАД)'),
	('02029', '55419', '10166', 'УЛ.БЕЛОСНЕЖКА (ДЕТСКИ ГРАД)'),
	('02030', '55419', '10176', 'УЛ.БАБА МАРТА (ДЕТСКИ ГРАД)'),
	('02031', '55419', '10183', 'УЛ.ПАНЧАРЕВСКИ ПРОЛОМ (Д.ГРАД)'),
	('02032', '55419', '10197', 'УЛ.САМОКОВИЩЕ (ДЕТСКИ ГРАД)'),
	('02033', '55419', '10207', 'УЛ.ЦЪРНОКОС (ДЕТСКИ ГРАД)'),
	('02034', '55419', '13367', 'УЛ.ПЕПЕЛЯШКА (ДЕТСКИ ГРАД)'),
	('02035', '55419', '35763', 'УЛ.ГАБРЕШОВИЦА'),
	('02036', '55419', '35777', 'УЛ.ВРАНА'),
	('02037', '55419', '37160', 'УЛ.КАРАЧАИР (КОСАНИН ДОЛ)'),
	('02038', '55419', '16540', 'УЛ.ЧЕТИРИ СЕЗОНА'),
	('02039', '55419', '15299', 'УЛ.ЯКОБИЦА (М.ЛЪКАТА)'),
	('02040', '55419', '37530', 'УЛ.ЗАБЕЛ'),
	('02041', '55419', '01701', 'УЛ.ТРЕПЕТЛИКА(В.З.ГРАДИЩЕ)'),
	('02042', '55419', '00953', 'УЛ.ЛЪКАТУШНА'),
	('02043', '55419', '18664', 'УЛ.ПОЛСКИ ХВОЩ'),
	('02044', '55419', '10327', 'УЛ.ЗЛАТИНОВИ ПОРТИ'),
	('02045', '55419', '10330', 'УЛ.ПРИКАЗНА'),
	('02046', '55419', '12245', 'УЛ.ЕЛХОВА ГОРА'),
	('02047', '55419', '23431', 'УЛ.САЛСКИ ДОЛ(В.З.КОСАНИН ДОЛ)'),
	('02048', '55419', '03191', 'УЛ.ПЛАНИНСКИ ИЗВОРИ'),
	('02049', '55419', '39373', 'УЛ.СТОЯНОВИ ЛИВАДИ'),
	('02050', '57011', '00014', 'ПЛ.ВАСИЛ ЛЕВСКИ'),
	('02051', '57011', '00028', 'УЛ.КОТЕВА'),
	('02052', '57011', '00031', 'УЛ.ИЗГРЕВ'),
	('02053', '57011', '00045', 'УЛ.КРУШОВА'),
	('02054', '57011', '00059', 'УЛ.ТАТАР МАХАЛА'),
	('02055', '57011', '00062', 'УЛ.ЛЮБОМИР ПАНЧЕВ'),
	('02056', '57011', '00076', 'УЛ.НИКОЛА МИЛАНОВ'),
	('02057', '57011', '00084', 'УЛ.ТОПОЛИТЕ'),
	('02058', '57011', '00093', 'УЛ.ГЕРЕНА'),
	('02059', '57011', '00103', 'УЛ.БРЕСТА'),
	('02060', '57011', '00117', 'УЛ.ЛЮЛЯК'),
	('02061', '57011', '00120', 'УЛ.ВЪРБИТЕ'),
	('02062', '57011', '00134', 'УЛ.СВЕТИ ДИМИТЪР'),
	('02063', '57011', '00148', 'УЛ.ЧЕМШИР'),
	('02064', '57011', '00151', 'УЛ.БРЕЗИТЕ'),
	('02065', '57011', '00165', 'УЛ.АКАЦИЯ'),
	('02066', '57011', '00179', 'УЛ.ВРАНЯК'),
	('02067', '57011', '00182', 'УЛ.КЪСИ ДОЛ'),
	('02068', '57011', '00196', 'УЛ.РУСИЯ'),
	('02069', '57011', '00206', 'УЛ.СПОРТИСТ'),
	('02070', '57011', '00215', 'ПЛ.МУРГАШ'),
	('02071', '57011', '00223', 'УЛ.МЛАДОСТ'),
	('02072', '57011', '00237', 'УЛ.ЗОРА'),
	('02073', '57011', '00254', 'УЛ.КИТКА'),
	('02074', '57011', '00271', 'УЛ.ЛИЛЯЧЕТО'),
	('02075', '57011', '00299', 'УЛ.СТУБЕЛА'),
	('02076', '57011', '00309', 'УЛ.СТАРА ПЛАНИНА (Л.ПАНЧЕВ)'),
	('02077', '57011', '17381', 'УЛ.ТИНТЯВА'),
	('02078', '65601', '00014', 'УЛ.ЧЕРКОВНА'),
	('02079', '65601', '00028', 'УЛ.ВЪЗРАЖДАНЕ'),
	('02080', '65601', '00031', 'УЛ.МАКЕДОНСКА'),
	('02081', '65601', '00045', 'УЛ.ДЕТЕЛИНА'),
	('02082', '65601', '00059', 'УЛ.СОФИЙСКА'),
	('02083', '65601', '00062', 'УЛ.МИЛАДИН ЦВЕТКОВ'),
	('02084', '65601', '00076', 'УЛ.ЧАВДАР ВОЙВОДА'),
	('02085', '65601', '00084', 'УЛ.СТУДЕН КЛАДЕНЕЦ'),
	('02086', '65601', '00093', 'УЛ.ИСКЪР'),
	('02087', '65601', '00103', 'УЛ.ЗДРАВЕЦ'),
	('02088', '65601', '00117', 'УЛ.3-ТИ МАРТ'),
	('02089', '65601', '00120', 'УЛ.ТРАКИЙСКА МОГИЛА'),
	('02090', '65601', '00148', 'УЛ.БАЛКАН'),
	('02091', '65601', '00151', 'УЛ.СИНЧЕЦ'),
	('02092', '65601', '00165', 'УЛ.ПИРИН'),
	('02093', '65601', '00179', 'УЛ.ДРУЖБА'),
	('02094', '65601', '00182', 'УЛ.ПУНГА'),
	('02095', '65601', '00196', 'УЛ.ЖЕЛЕЗОПЪТНА'),
	('02096', '65601', '00206', 'УЛ.ЗОРА'),
	('02097', '65601', '00223', 'УЛ.ВОЙНИШКИ ПЪТ'),
	('02098', '65601', '00237', 'УЛ.ПОЛЯНАТА'),
	('02099', '65601', '00240', 'УЛ.ЛЕСНОВСКА РЕКА'),
	('02100', '65601', '00254', 'УЛ.ЛИПА'),
	('02101', '65601', '00268', 'УЛ.ГРАНИЧАР'),
	('02102', '65601', '00271', 'УЛ.ЛЮЛЯК'),
	('02103', '65601', '00285', 'УЛ.ПРОЛЕТ'),
	('02104', '65601', '00299', 'УЛ.21-ВИ АПРИЛ'),
	('02105', '65601', '00309', 'УЛ.ЦВЕТНА ГРАДИНА'),
	('02106', '65601', '00312', 'УЛ.ПРОБУДА'),
	('02107', '65601', '00326', 'УЛ.СТАРА ПЛАНИНА'),
	('02108', '65601', '00357', 'УЛ.МЛАДОСТ'),
	('02109', '65601', '00360', 'УЛ.КОКИЧЕ'),
	('02110', '65601', '00374', 'УЛ.ИЗГРЕВ'),
	('02111', '65601', '00388', 'УЛ.БРЪМЧОВА'),
	('02112', '65601', '00391', 'УЛ.МОГИЛАТА'),
	('02113', '68134', '35643', 'УЛ.ДЖОН ЛЕНЪН'),
	('02114', '68134', '85576', 'УЛ.КАМБАНКА'),
	('02115', '68134', '10080', 'УЛ.Д-Р ЛЮБА ГРИГОРОВА'),
	('02116', '68134', '12574', 'УЛ.НИКОЛА НЕДЕВ'),
	('02117', '68134', '33369', 'УЛ.ЛОВЕН ПАРК'),
	('02118', '68134', '34446', 'УЛ.ПРОФ.САЗДО ИВАНОВ'),
	('02119', '68134', '35657', 'УЛ.ПРОФ.СТАНЧО ВАКЛИНОВ'),
	('02120', '68134', '89957', 'УЛ.АЛЕКСАНДЪР ВЕЙНЕР'),
	('02121', '68134', '35660', 'УЛ.ПЕРПЕРИКОН'),
	('02122', '68134', '35674', 'УЛ.ПАВЛИНА УНУФРИЕВА'),
	('02123', '68134', '46045', 'УЛ.ГЕОРГИ ЖИВКОВ'),
	('02124', '68134', '96565', 'УЛ.БЪДНИНА'),
	('02125', '68134', '65111', 'БУЛ.КРЪСТЮ ПАСТУХОВ'),
	('02126', '68134', '35078', 'УЛ.406-ТА (МЛАДОСТ 4)'),
	('02127', '68134', '35002', 'УЛ.АКАД.ИЛЧО ДИМИТРОВ'),
	('02128', '68134', '12485', 'УЛ.НИКОЛА БЕЛОВЕЖДОВ'),
	('02129', '68134', '34672', 'УЛ.Д-Р МИНЬО СТОЯНОВ'),
	('02130', '68134', '59731', 'УЛ.ПРОФ.ГЕОРГИ ЙОЛОВ'),
	('02131', '68134', '65053', 'БУЛ.НИКОЛА МУШАНОВ'),
	('02132', '68134', '39894', 'УЛ.ГЕОРГИ ЯНАКИЕВ'),
	('02133', '68134', '39904', 'УЛ.115-ТА (ОБЕЛЯ)'),
	('02134', '68134', '35016', 'УЛ.СЛАВ КАРАСЛАВОВ'),
	('02135', '68134', '35028', 'УЛ.ХАГА'),
	('02136', '68134', '35033', 'УЛ.ХАН ТЕРВЕЛ'),
	('02137', '68134', '35047', 'УЛ.ПАША ХРИСТОВА'),
	('02138', '68134', '35050', 'УЛ.БОГОМИЛ РАЙНОВ'),
	('02139', '68134', '35064', 'УЛ.МАРИЯ НЕЙКОВА'),
	('02140', '68134', '35081', 'УЛ.АСЕН БОСЕВ'),
	('02141', '68134', '35095', 'УЛ.ПРОФ.ИЛИЯ ЙОСИФОВ'),
	('02142', '68134', '35122', 'УЛ.ЕЛИТЕ'),
	('02143', '68134', '35136', 'УЛ.АТАНАС МАНЧЕВ'),
	('02144', '68134', '35143', 'УЛ.ЛЪЧЕЗАР СТАНЧЕВ'),
	('02145', '68134', '37352', 'УЛ.309-ТА ( ЛЮЛИН )'),
	('02146', '68134', '35167', 'УЛ.ОПЪЛЧЕНЕЦ (ГОРНА БАНЯ)'),
	('02147', '68134', '33036', 'УЛ.ПРОФ.ХРИСТО ДАНОВ'),
	('02148', '68134', '35688', 'УЛ.АКАДЕМИК ЖАК НАТАН'),
	('02149', '68134', '37040', 'УЛ.Д-Р ВАСИЛ КАРАКОНОВСКИ'),
	('02150', '68134', '34415', 'УЛ.АКАД.КОНСТАНТИН ПАШЕВ'),
	('02151', '68134', '33392', 'УЛ.ХРИСТО ИВАНОВ-ГОЛЕМИЯ'),
	('02152', '68134', '36943', 'УЛ.ДИМИТЪР СТЕФАНОВ'),
	('02153', '68134', '35153', 'УЛ.АМСТЕРДАМ'),
	('02154', '68134', '99749', 'УЛ.БРЮКСЕЛ'),
	('02155', '68134', '35170', 'УЛ.ДЕЛИЙСКА ВОДЕНИЦА'),
	('02156', '68134', '35184', 'УЛ.САДИНА'),
	('02157', '68134', '35198', 'УЛ.ИЗЛАК'),
	('02158', '68134', '35208', 'УЛ.ТУШЕ ДЕЛИИВАНОВ'),
	('02159', '68134', '35211', 'УЛ.КАПИТАН ЛЮБЕН КОНДАКОВ'),
	('02160', '68134', '35225', 'УЛ.ОБИКОЛНА'),
	('02161', '68134', '35239', 'УЛ.ГЕНЕРАЛ СТОЯН СТОЯНОВ'),
	('02162', '68134', '35256', 'УЛ.КАП.ДИМИТЪР СПИСАРЕВСКИ'),
	('02163', '68134', '35269', 'УЛ.ХАНС КРИСТИАН АНДРЕСЕН'),
	('02164', '68134', '35273', 'УЛ.ХАЙДЕЛБЕРГ'),
	('02165', '68134', '35287', 'УЛ.ПРОФ.НИКОЛА ЧИЛЕВ'),
	('02166', '68134', '35300', 'УЛ.ФЬОДОР УСПЕНСКИ'),
	('02167', '68134', '35314', 'УЛ.НАЙЧО ЦАНОВ'),
	('02168', '68134', '35328', 'УЛ.ПРОФ.МИЛКО БОРИСОВ'),
	('02169', '68134', '35331', 'УЛ.117-ТА (ЛЮЛИН)'),
	('02170', '68134', '35345', 'УЛ.ПРОФ.ЛЮБОМИР КРЪСТАНОВ'),
	('02171', '68134', '35359', 'УЛ.ПРОФ.ГЕОРГИ МАНЕВ'),
	('02172', '68134', '35362', 'УЛ.ЪРНЕСТ РЪДЪРФОРД'),
	('02173', '68134', '35376', 'УЛ.НИЛС БОР'),
	('02174', '68134', '35384', 'УЛ.АЛБЕРТ АЙНЩАЙН'),
	('02175', '68134', '35393', 'УЛ.ПРОФ.ЕЛИСАВЕТА КАРАМИХАЙЛОВ'),
	('02176', '68134', '35403', 'УЛ.МАЙКЪЛ ФАРАДЕЙ'),
	('02177', '68134', '35417', 'УЛ.ПРОФ.ЕМИЛ ДЖАКОВ'),
	('02178', '68134', '35420', 'УЛ.ИСАК НЮТОН'),
	('02179', '68134', '35434', 'УЛ.ПРОФ.МАРИН БЪЧВАРОВ'),
	('02180', '68134', '35448', 'УЛ.ПРОФ.ПОРФИРИЙ БАХМЕТИЕВ'),
	('02181', '68134', '35451', 'УЛ.ДИКО ИЛИЕВ'),
	('02182', '68134', '35465', 'УЛ.ДИМИТЪР СЪСЪЛОВ'),
	('02183', '68134', '35479', 'УЛ.ДОБРИ БОЖИЛОВ'),
	('02184', '68134', '35482', 'УЛ.АБАГАР'),
	('02185', '68134', '35496', 'УЛ.МЕТОДИ АНДОНОВ'),
	('02186', '68134', '35506', 'УЛ.САЛИ ЯШАР'),
	('02187', '68134', '35515', 'УЛ.СРЕБРОСТРУЙ'),
	('02188', '68134', '35523', 'УЛ.БОРИС АРСОВ'),
	('02189', '68134', '35540', 'УЛ.ПРОФ.ВЕЛИЗАР ВЕЛКОВ'),
	('02190', '68134', '35554', 'УЛ.БЯЛА ЛИЛИЯ'),
	('02191', '68134', '35568', 'УЛ.БЯЛА АКАЦИЯ'),
	('02192', '68134', '35571', 'УЛ.ЛЕА ИВАНОВА'),
	('02193', '68134', '00014', 'УЛ.АБОБА'),
	('02194', '68134', '00028', 'УЛ.АВИЦЕНА'),
	('02195', '68134', '00031', 'УЛ.АВРАМ СТОЯНОВ'),
	('02196', '68134', '00045', 'УЛ.РАЙСКА ГРАДИНА'),
	('02197', '68134', '00062', 'УЛ.ТРИ УШИ'),
	('02198', '68134', '00076', 'УЛ.АДРИАНА БУДЕВСКА'),
	('02199', '68134', '00093', 'УЛ.АКАД.ГЕОРГИ БОНЧЕВ'),
	('02200', '68134', '00117', 'УЛ.АКАД.ИЛИЯ ПЕТРОВ (130-ТА)'),
	('02201', '68134', '00120', 'УЛ.АКАД.МЕТОДИ ПОПОВ'),
	('02202', '68134', '00134', 'УЛ.АКАЦИЯ'),
	('02203', '68134', '00148', 'УЛ.АНА АХМАТОВА'),
	('02204', '68134', '00151', 'УЛ.АКСАКОВ'),
	('02205', '68134', '00165', 'УЛ.КИРИЛ ГРИГОРОВ'),
	('02206', '68134', '00196', 'УЛ.АЛЕКО КОНСТАНТИНОВ'),
	('02207', '68134', '00206', 'УЛ.СЕВАСТОКРАТОР КАЛОЯН'),
	('02208', '68134', '00223', 'УЛ.ЛЕДА'),
	('02209', '68134', '00237', 'УЛ.АЛЕКСАНДЪР ЕКЗАРХ'),
	('02210', '68134', '00240', 'УЛ.АЛЕКСАНДЪР ЖЕНДОВ'),
	('02211', '68134', '00268', 'УЛ.АЛЕКСАНДЪР МАКЕДОНСКИ'),
	('02212', '68134', '00271', 'УЛ.ХРИСТО БАТАНДЖИЕВ'),
	('02213', '68134', '00285', 'УЛ.АЛЕКСАНДЪР МИХОВ'),
	('02214', '68134', '00299', 'УЛ.ФЕРДИНАНД УРБИХ'),
	('02215', '68134', '00309', 'УЛ.АЛЕКСАНДЪР НЕВСКИ'),
	('02216', '68134', '00312', 'УЛ.СВЕТИ ПИМЕН ЗОГРАФСКИ'),
	('02217', '68134', '00326', 'УЛ.АКАЦИЯ (БОЯНА)'),
	('02218', '68134', '00343', 'УЛ.ПРОФ.НИКОЛА МИХАЙЛОВ'),
	('02219', '68134', '00360', 'УЛ.АТАНАС ДУКОВ'),
	('02220', '68134', '00374', 'УЛ.АМИ БУЕ'),
	('02221', '68134', '00401', 'УЛ.АНГЕЛ ВОЙВОДА'),
	('02222', '68134', '00415', 'УЛ.АПОСТОЛ КАРАМИТЕВ'),
	('02223', '68134', '00429', 'УЛ.ЛЮБОТРЪН'),
	('02224', '68134', '00432', 'УЛ.АНГЕЛ КЪНЧЕВ'),
	('02225', '68134', '00446', 'УЛ.АНГЕЛОВ ВРЪХ'),
	('02226', '68134', '00456', 'УЛ.АНГИСТА'),
	('02227', '68134', '00463', 'УЛ.ПИРОТСКА'),
	('02228', '68134', '00477', 'УЛ.АЛЕКСАНДЪР ФОН ХУМБОЛТ'),
	('02229', '68134', '00480', 'УЛ.АНТИМ I'),
	('02230', '68134', '00494', 'УЛ.АНТОН БЕЗЕНШЕК'),
	('02231', '68134', '00504', 'УЛ.АНТОН КЕЦКАРОВ'),
	('02232', '68134', '00518', 'УЛ.МОМИН КЛАДЕНЕЦ'),
	('02233', '68134', '00521', 'УЛ.АНТОН П.ЧЕХОВ'),
	('02234', '68134', '00535', 'УЛ.АРХ.ЛАЗАР ПАРАШКЕВАНОВ'),
	('02235', '68134', '00549', 'УЛ.КРУША ПЛАНИНА'),
	('02236', '68134', '00552', 'УЛ.АПОСТОЛ ВОЙВОДА'),
	('02237', '68134', '00566', 'УЛ.АНДРЕЙ САХАРОВ'),
	('02238', '68134', '00571', 'УЛ.АПРИЛСКО ВЪСТАНИЕ'),
	('02239', '68134', '00583', 'УЛ.АРДА'),
	('02240', '68134', '00597', 'УЛ.АРДИНО'),
	('02241', '68134', '00607', 'УЛ.ГАЛИЧНИК'),
	('02242', '68134', '00610', 'УЛ.АРХ.ЙОРДАН МИЛАНОВ'),
	('02243', '68134', '00624', 'УЛ.ПРОФ.ХАРАЛАМБИ ТАЧЕВ'),
	('02244', '68134', '00638', 'УЛ.АРЧАРИЦА'),
	('02245', '68134', '00641', 'УЛ.КОСТА ЛУЛЧЕВ'),
	('02246', '68134', '00655', 'УЛ.АСЕН ТРАЙКОВ'),
	('02247', '68134', '00672', 'УЛ.АСЕНОВА КРЕПОСТ'),
	('02248', '68134', '00686', 'УЛ.ДИМИТЪР ГУЩАНОВ'),
	('02249', '68134', '00697', 'УЛ.ВОРИНО'),
	('02250', '68134', '00702', 'УЛ.АТАНАС КИРЧЕВ'),
	('02251', '68134', '00713', 'УЛ.ЗАГРЕБСКА'),
	('02252', '68134', '00727', 'УЛ.КЮСТЕНДИЛ'),
	('02253', '68134', '00744', 'УЛ.ДОБРУДЖАНСКИ КРАЙ'),
	('02254', '68134', '00758', 'УЛ.АТАНАС УЗУНОВ'),
	('02255', '68134', '00761', 'УЛ.АТАНАС ЦВЕТАНОВ'),
	('02256', '68134', '00789', 'УЛ.АТОН'),
	('02257', '68134', '00792', 'УЛ.АХЕЛОЙ'),
	('02258', '68134', '00802', 'УЛ.БАБА'),
	('02259', '68134', '00816', 'УЛ.БАБА ВИДА'),
	('02260', '68134', '00828', 'УЛ.БАБА ИЛИЙЦА'),
	('02261', '68134', '00833', 'УЛ.БАБА ТОНКА'),
	('02262', '68134', '00847', 'УЛ.БАБУНА ПЛАНИНА'),
	('02263', '68134', '00850', 'УЛ.БАГРА'),
	('02264', '68134', '00864', 'УЛ.БАДЕМОВА ГОРА'),
	('02265', '68134', '00878', 'УЛ.БАЙКАЛ'),
	('02266', '68134', '00881', 'УЛ.БАЙЛОВО'),
	('02267', '68134', '00895', 'УЛ.БАЙ МИХАЛ'),
	('02268', '68134', '00905', 'УЛ.БАЛАТОН'),
	('02269', '68134', '00922', 'УЛ.БАЛКАН'),
	('02270', '68134', '00936', 'УЛ.БАЛКАНДЖИ ЙОВО'),
	('02271', '68134', '00943', 'УЛ.БАЛЧИК'),
	('02272', '68134', '00967', 'УЛ.БАНИЦА'),
	('02273', '68134', '00970', 'УЛ.БАНСКО'),
	('02274', '68134', '00998', 'УЛ.ВЕДРИНА (Р-Н ВРЪБНИЦА)'),
	('02275', '68134', '01002', 'УЛ.БАРИТЕ'),
	('02276', '68134', '01016', 'УЛ.БОРУЙ'),
	('02277', '68134', '01025', 'УЛ.БАТАК'),
	('02278', '68134', '01047', 'УЛ.БАТКУН'),
	('02279', '68134', '01064', 'УЛ.ТАШКОВИ ЛИВАДИ'),
	('02280', '68134', '01078', 'УЛ.БОГДАНИЦА (КР.ПОЛЯНА)'),
	('02281', '68134', '01081', 'УЛ.БАТУНЯ'),
	('02282', '68134', '01095', 'УЛ.КИЕВСКА'),
	('02283', '68134', '01105', 'УЛ.БАЧЕВО'),
	('02284', '68134', '01119', 'УЛ.БАЧО КИРО'),
	('02285', '68134', '01122', 'УЛ.БДИН'),
	('02286', '68134', '01136', 'УЛ.БЕГОНИЯ'),
	('02287', '68134', '01140', 'УЛ.БЕДЕК'),
	('02288', '68134', '01153', 'УЛ.АРАМ ХАЧАТУРЯН'),
	('02289', '68134', '01167', 'УЛ.БЕЗИМЕННА'),
	('02290', '68134', '01198', 'УЛ.БЕЛАСИЦА'),
	('02291', '68134', '01208', 'УЛ.БЕЛИТЕ БОРОВЕ'),
	('02292', '68134', '01225', 'УЛ.БЕЛИ ДУНАВ'),
	('02293', '68134', '01239', 'УЛ.БЕЛИ ИСКЪР'),
	('02294', '68134', '01242', 'УЛ.БЕЛИ МЕЛ'),
	('02295', '68134', '01256', 'УЛ.БЕЛИНСКА РАВНИНА'),
	('02296', '68134', '01266', 'УЛ.БЕЛИТЕ БРЕЗИ'),
	('02297', '68134', '01287', 'УЛ.БЕЛИЯ КЛАДЕНЕЦ'),
	('02298', '68134', '01290', 'УЛ.БЕЛМЕКЕН'),
	('02299', '68134', '01314', 'УЛ.БЕЛОМОРЕЦ'),
	('02300', '68134', '01328', 'УЛ.БЕЛОМОРСКИ ПРОХОД'),
	('02301', '68134', '01331', 'УЛ.БЕЛОСЛАВ'),
	('02302', '68134', '01345', 'УЛ.БЕЛОТОК'),
	('02303', '68134', '01376', 'УЛ.БЕРАВИЦА'),
	('02304', '68134', '01381', 'УЛ.БЕРЕЗИНА'),
	('02305', '68134', '01403', 'УЛ.БЕСАРАБИЯ'),
	('02306', '68134', '01448', 'УЛ.БИСЕР'),
	('02307', '68134', '01451', 'УЛ.БИСТРИЦА'),
	('02308', '68134', '01465', 'УЛ.БИТОЛЯ'),
	('02309', '68134', '01479', 'УЛ.БЛАГАТИЦА'),
	('02310', '68134', '01482', 'УЛ.БЛАГОРОДНА'),
	('02311', '68134', '01506', 'УЛ.БОГДАН'),
	('02312', '68134', '01512', 'УЛ.АРАБАКОНАК'),
	('02313', '68134', '01523', 'УЛ.БОГДАН МОЦЕВ'),
	('02314', '68134', '01537', 'УЛ.БОГДАНОВЕЦ'),
	('02315', '68134', '01540', 'УЛ.БОГДАНЦИ'),
	('02316', '68134', '01554', 'УЛ.БОГОВА СТЪПКА'),
	('02317', '68134', '01568', 'УЛ.БЛАГОВЕЦ'),
	('02318', '68134', '01585', 'УЛ.БОЖИДАРИЦА'),
	('02319', '68134', '01599', 'УЛ.СТРЕШЕР'),
	('02320', '68134', '01609', 'УЛ.БОЖУР'),
	('02321', '68134', '01626', 'УЛ.ДЕЧКО УЗУНОВ'),
	('02322', '68134', '01638', 'УЛ.БОЙЧО ВОЙВОДА'),
	('02323', '68134', '01643', 'УЛ.БОЙЧО ОГНЯНОВ'),
	('02324', '68134', '01657', 'УЛ.БОЛГРАД'),
	('02325', '68134', '01674', 'УЛ.БОЛЯРИН ИЛИЦА'),
	('02326', '68134', '01688', 'УЛ.БОЙНИЦА'),
	('02327', '68134', '01691', 'УЛ.ЯВОР (ВИТОША)'),
	('02328', '68134', '01701', 'УЛ.ЕПИСКОП ЕВГЕНИ БОСИЛКОВ'),
	('02329', '68134', '01732', 'УЛ.МАРИЦА'),
	('02330', '68134', '01763', 'УЛ.ОРЕХОВА ГОРА'),
	('02331', '68134', '01777', 'УЛ.БОРИСЛАВ'),
	('02332', '68134', '01780', 'УЛ.БОРИСЛАВ КРЪСТАНОВ'),
	('02333', '68134', '01794', 'УЛ.БОРОВА ГОРА'),
	('02334', '68134', '01804', 'УЛ.БОРОВАН'),
	('02335', '68134', '01818', 'УЛ.БОРОВЕЦ'),
	('02336', '68134', '01835', 'УЛ.БОРОВО'),
	('02337', '68134', '01849', 'УЛ.ХРИСТО СИЛЯНОВ'),
	('02338', '68134', '01852', 'УЛ.БОРУЩИЦА'),
	('02339', '68134', '01866', 'УЛ.БОРЯНА'),
	('02340', '68134', '01879', 'УЛ.БОСИЛЕГРАДСКА'),
	('02341', '68134', '01883', 'УЛ.БОТЕВГРАД'),
	('02342', '68134', '01897', 'УЛ.БОТЮ ПЕТКОВ'),
	('02343', '68134', '01907', 'УЛ.БОЯДЖИК'),
	('02344', '68134', '01910', 'УЛ.БОЯНСКА РЕКА'),
	('02345', '68134', '01924', 'УЛ.БОЯНСКИ ВОДОПАД'),
	('02346', '68134', '01938', 'УЛ.БОЯНСКИ ВЪЗХОД'),
	('02347', '68134', '01941', 'УЛ.БОЯНСКО ЕЗЕРО'),
	('02348', '68134', '01955', 'УЛ.БРАТИН ДОЛ'),
	('02349', '68134', '01972', 'УЛ.БРАТОВАН'),
	('02350', '68134', '01986', 'УЛ.БРАТСКА ДРУЖБА'),
	('02351', '68134', '01994', 'УЛ.БРАТЯ ЖЕКОВИ'),
	('02352', '68134', '02004', 'УЛ.БРАТЯ КАРЛ И ДЖОРДЖ ПАШОВИ'),
	('02353', '68134', '02018', 'УЛ.МАЛКАРА'),
	('02354', '68134', '02021', 'УЛ.БРАТЯ МИЛАДИНОВИ'),
	('02355', '68134', '02035', 'УЛ.БРАТЯ ПЕШЕВИ'),
	('02356', '68134', '02049', 'УЛ.БРАТЯ СТАНИСЛАВОВИ'),
	('02357', '68134', '02052', 'УЛ.БРАЦИГОВО'),
	('02358', '68134', '02076', 'УЛ.БРЕЗА'),
	('02359', '68134', '02083', 'УЛ.БРЕЗИТЕ'),
	('02360', '68134', '02097', 'УЛ.БРЕЗНИК'),
	('02361', '68134', '02107', 'УЛ.БРЕЗОВИЦА'),
	('02362', '68134', '02110', 'УЛ.БРЕЗОВ РИД'),
	('02363', '68134', '02138', 'УЛ.МИЛЕ ПОПЙОРДАНОВ'),
	('02364', '68134', '02141', 'УЛ.БРИЧЕБОР'),
	('02365', '68134', '02155', 'УЛ.БРОД'),
	('02366', '68134', '02169', 'УЛ.БРУСЕНСКА'),
	('02367', '68134', '02172', 'УЛ.ИВАН ГАРВАНОВ'),
	('02368', '68134', '02186', 'УЛ.БРЪШЛЯНСКА НИЗИНА'),
	('02369', '68134', '02191', 'УЛ.БРЯНСКА ГОРА'),
	('02370', '68134', '02207', 'УЛ.БУДАПЕЩА'),
	('02371', '68134', '02213', 'УЛ.БУДИЛНИК'),
	('02372', '68134', '02227', 'УЛ.БУЕН ПОТОК'),
	('02373', '68134', '02230', 'УЛ.БУЗЕМСКА'),
	('02374', '68134', '02244', 'УЛ.БУЗЛУДЖА'),
	('02375', '68134', '02261', 'УЛ.БУКЕТ'),
	('02376', '68134', '02275', 'УЛ.БУКИТЕ'),
	('02377', '68134', '02289', 'УЛ.БУНТОВНИК'),
	('02378', '68134', '02302', 'УЛ.БУРЯ'),
	('02379', '68134', '02322', 'УЛ.БЪДЕЩЕ'),
	('02380', '68134', '02333', 'УЛ.БОРИС ПОЖАРОВ'),
	('02381', '68134', '02347', 'УЛ.БЪЛГАРКА'),
	('02382', '68134', '02350', 'УЛ.БЪЛГАРСКА ЛЕГИЯ'),
	('02383', '68134', '02364', 'УЛ.БЪРЗАРИЦА'),
	('02384', '68134', '02395', 'УЛ.БЯЛА'),
	('02385', '68134', '02419', 'УЛ.БЯЛА ЧЕРКВА'),
	('02386', '68134', '02422', 'УЛ.БЯЛ ЛЮЛЯК'),
	('02387', '68134', '02436', 'УЛ.БЯЛО МОРЕ'),
	('02388', '68134', '02448', 'УЛ.БЯЛО ПОЛЕ'),
	('02389', '68134', '02453', 'УЛ.ВАКАРЕЛ'),
	('02390', '68134', '02470', 'УЛ.КНЯЖЕВСКА'),
	('02391', '68134', '02484', 'УЛ.ВАЛОЗИТЕ'),
	('02392', '68134', '02498', 'УЛ.ВАРДАР'),
	('02393', '68134', '02508', 'УЛ.ВАРНА'),
	('02394', '68134', '02511', 'УЛ.ВАСИЛ АПРИЛОВ'),
	('02395', '68134', '02525', 'УЛ.МАНАСТИРСКА'),
	('02396', '68134', '02539', 'УЛ.РИЛА'),
	('02397', '68134', '02542', 'УЛ.ВАСИЛ ДИМ.СТОЯНОВ'),
	('02398', '68134', '02556', 'УЛ.ВАСИЛ ДРУМЕВ'),
	('02399', '68134', '02563', 'УЛ.ВАСИЛ КАЛЧЕВ'),
	('02400', '68134', '02573', 'УЛ.ВАСИЛ КИРКОВ'),
	('02401', '68134', '02587', 'УЛ.СОЛУНСКА'),
	('02402', '68134', '02590', 'УЛ.ВАСИЛ КЪНЧЕВ'),
	('02403', '68134', '02614', 'УЛ.МЕТЛИЧИНА ПОЛЯНА'),
	('02404', '68134', '02628', 'УЛ.МАЕСТРО КЪНЕВ'),
	('02405', '68134', '02631', 'УЛ.СВЕТЛОСТРУЙ'),
	('02406', '68134', '02645', 'УЛ.ВАСИЛ ЧЕКАЛАРОВ'),
	('02407', '68134', '02659', 'УЛ.ВАСИЛ ПЕТЛЕШКОВ'),
	('02408', '68134', '02662', 'УЛ.РАЛЕВИЦА'),
	('02409', '68134', '02676', 'УЛ.ТИМОК'),
	('02410', '68134', '02693', 'УЛ.ВЕДРИНА'),
	('02411', '68134', '02703', 'УЛ.ВЕЖЕН'),
	('02412', '68134', '02717', 'УЛ.ВЕЙНИЦИТЕ'),
	('02413', '68134', '02720', 'УЛ.ВЕЛА БЛАГОЕВА'),
	('02414', '68134', '02734', 'УЛ.ПАНАЙОТ ХИТОВ'),
	('02415', '68134', '02748', 'УЛ.НЕДКО ВОЙВОДА'),
	('02416', '68134', '02751', 'УЛ.ВЕЛА ЧОРБОВА'),
	('02417', '68134', '02765', 'УЛ.ВЕЛБЪЖД'),
	('02418', '68134', '02782', 'УЛ.ВЕЛИКАН'),
	('02419', '68134', '02796', 'УЛ.ВЕЛИК ЗАВЕТ'),
	('02420', '68134', '02806', 'УЛ.ДИМИТЪР ВЕЛИКСИН'),
	('02421', '68134', '02810', 'УЛ.ВЕЛИКИ ПРЕЛОМ'),
	('02422', '68134', '02823', 'УЛ.ВЕЛИНГРАД'),
	('02423', '68134', '02840', 'УЛ.ВЕЛЧО АТАНАСОВ'),
	('02424', '68134', '02854', 'УЛ.ЮРИ ВЕНЕЛИН'),
	('02425', '68134', '02868', 'УЛ.ВЕНЕРА'),
	('02426', '68134', '02871', 'УЛ.ВЕНЕЦ'),
	('02427', '68134', '02899', 'УЛ.СВИЩОВ'),
	('02428', '68134', '02909', 'УЛ.ВЕРИЛА'),
	('02429', '68134', '02912', 'УЛ.ВЕСЛЕЦ'),
	('02430', '68134', '02926', 'УЛ.ВЕТРЕН'),
	('02431', '68134', '02935', 'УЛ.ВЕТРУШКА'),
	('02432', '68134', '02943', 'УЛ.ВЕЧЕРНИЦА'),
	('02433', '68134', '02957', 'УЛ.ВИДБОЛ'),
	('02434', '68134', '02960', 'УЛ.ВИДЕЛИНА'),
	('02435', '68134', '02974', 'УЛ.ВИДИМА'),
	('02436', '68134', '02988', 'УЛ.ВИДИН'),
	('02437', '68134', '02991', 'УЛ.ВИДИНИ КУЛИ'),
	('02438', '68134', '03006', 'УЛ.ВИДЛИЧ'),
	('02439', '68134', '03017', 'УЛ.ВИДУЛ ВОЙВОДА'),
	('02440', '68134', '03023', 'УЛ.ВИКТОР ГРИГОРОВИЧ'),
	('02441', '68134', '03040', 'УЛ.ВИКТОР ЮГО'),
	('02442', '68134', '03054', 'УЛ.КОРИТНИК'),
	('02443', '68134', '03068', 'УЛ.ВИНИЦА'),
	('02444', '68134', '03085', 'УЛ.ВИОЛЕТКА'),
	('02445', '68134', '03099', 'УЛ.ВИСКЯР ПЛАНИНА'),
	('02446', '68134', '03112', 'УЛ.ВИТИНЯ'),
	('02447', '68134', '03126', 'УЛ.ВИТКОВА ЛИВАДА'),
	('02448', '68134', '03132', 'УЛ.ВИТОШКА ПОЛЯНА'),
	('02449', '68134', '03157', 'УЛ.ВИТОШКИ ИЗВОРИ'),
	('02450', '68134', '03188', 'УЛ.ВИШНЕВА'),
	('02451', '68134', '03191', 'УЛ.ВИШОВГРАД'),
	('02452', '68134', '03201', 'УЛ.ВЛАДАЙСКА РЕКА'),
	('02453', '68134', '03215', 'УЛ.ВОЙНИШКО ВЪСТАНИЕ'),
	('02454', '68134', '03232', 'УЛ.ВЛАДИВОСТОК'),
	('02455', '68134', '03246', 'УЛ.ВЛАДИМИР БАШЕВ'),
	('02456', '68134', '03258', 'БУЛ.АРСЕНАЛСКИ'),
	('02457', '68134', '03263', 'УЛ.ВЛАДИМИР ЗОГРАФ'),
	('02458', '68134', '03280', 'УЛ.ЦВЕТАН ВУЧКОВ'),
	('02459', '68134', '03294', 'УЛ.ВЛАДИМИР МИНКОВ-ЛОТКОВ'),
	('02460', '68134', '03304', 'УЛ.УЙЛЯМ ГЛАДСТОН'),
	('02461', '68134', '03321', 'УЛ.ВЛАДОВО'),
	('02462', '68134', '03349', 'УЛ.ВЛАХ КАМЪК'),
	('02463', '68134', '03352', 'УЛ.ВОЕННА РАМПА'),
	('02464', '68134', '03366', 'УЛ.ВОДНЯНКА'),
	('02465', '68134', '03373', 'УЛ.ВОЙВОДИНА МОГИЛА'),
	('02466', '68134', '03383', 'УЛ.ВОЙВОДОВО'),
	('02467', '68134', '03407', 'УЛ.ВОЙНИШКА ПЕСЕН'),
	('02468', '68134', '03424', 'УЛ.ВОЙНЯГОВО'),
	('02469', '68134', '03441', 'БУЛ.СИМЕОНОВСКО ШОСЕ'),
	('02470', '68134', '03455', 'УЛ.ТЪРНОВСКА КОНСТИТУЦИЯ'),
	('02471', '68134', '03469', 'УЛ.ВОРОНЕЖ'),
	('02472', '68134', '03472', 'УЛ.ВРАИЛ'),
	('02473', '68134', '03486', 'УЛ.ВРАНЯ'),
	('02474', '68134', '03499', 'УЛ.ВРАЦА'),
	('02475', '68134', '03513', 'УЛ.ВРЪХ ВОЛА'),
	('02476', '68134', '03527', 'УЛ.ВРЪХ МАНЧО'),
	('02477', '68134', '03530', 'УЛ.ВРЪХ ТУМБА'),
	('02478', '68134', '03544', 'УЛ.ВРЪШКА ЧУКА'),
	('02479', '68134', '03558', 'УЛ.ВСЕВОЛОД ГАРШИН'),
	('02480', '68134', '03575', 'УЛ.ВЪЛКО РАДИНСКИ'),
	('02481', '68134', '03589', 'УЛ.ВЪЛЧО ГЕОРГИЕВ'),
	('02482', '68134', '03592', 'УЛ.ВЪРБИЦА'),
	('02483', '68134', '03602', 'УЛ.ВЪРШЕЦ'),
	('02484', '68134', '03616', 'УЛ.ВЪСТАНИК'),
	('02485', '68134', '03620', 'УЛ.ВЪЧА'),
	('02486', '68134', '03633', 'УЛ.ГАБРОВО'),
	('02487', '68134', '03647', 'УЛ.ГАБЪР'),
	('02488', '68134', '03650', 'УЛ.ХРИСТО БЕЛЧЕВ'),
	('02489', '68134', '03664', 'УЛ.ГАВРИЛ ГЕОРГИЕВ'),
	('02490', '68134', '03681', 'УЛ.ГАЙДАРЧЕ'),
	('02491', '68134', '03695', 'УЛ.ГАЙТАНЦИ'),
	('02492', '68134', '03705', 'УЛ.ГАЛИЧИЦА'),
	('02493', '68134', '03719', 'УЛ.ГЕБЕДЖЕ'),
	('02494', '68134', '03722', 'УЛ.ГЕЛЕ КИТОВ'),
	('02495', '68134', '03736', 'УЛ.ГЕНА КУНЧЕВА'),
	('02496', '68134', '03767', 'УЛ.ГЕН.ГУРКО'),
	('02497', '68134', '03770', 'УЛ.РУСОКАСТРО'),
	('02498', '68134', '03784', 'УЛ.ГЕН.ИВАН ЧЕРНАЕВ'),
	('02499', '68134', '03798', 'УЛ.ГЕН.ИНЗОВ'),
	('02500', '68134', '03808', 'УЛ.ГЕН.КУТУЗОВ'),
	('02501', '68134', '03811', 'УЛ.ГЕН.ЛИПРАНДИ'),
	('02502', '68134', '03825', 'УЛ.ГЕН.НИКОЛА ГЕНЕВ'),
	('02503', '68134', '03839', 'УЛ.ГЕН.ПАРЕНСОВ'),
	('02504', '68134', '03856', 'БУЛ.ГЕН.СТОЛЕТОВ'),
	('02505', '68134', '03860', 'УЛ.ГЕН.СУВОРОВ'),
	('02506', '68134', '03873', 'УЛ.ГЕН.САН МАРТИН'),
	('02507', '68134', '03887', 'БУЛ.ГЕН.ТОТЛЕБЕН'),
	('02508', '68134', '03890', 'УЛ.ДАМЯН ГРУЕВ'),
	('02509', '68134', '03900', 'УЛ.ПРОФ.ПЕТЪР НИКОВ'),
	('02510', '68134', '03914', 'УЛ.ГЕН.ЦОНЧЕВ'),
	('02511', '68134', '03928', 'УЛ.ГЕН.ЩЕРЮ АТАНАСОВ'),
	('02512', '68134', '03931', 'УЛ.ГЕО МИЛЕВ'),
	('02513', '68134', '03945', 'УЛ.ГЕОРГ ВАШИНГТОН'),
	('02514', '68134', '03959', 'УЛ.ВЕЛИКО ТЪРНОВО'),
	('02515', '68134', '03962', 'УЛ.НИШАВА'),
	('02516', '68134', '03986', 'УЛ.ГЕОРГИ БАКАЛОВ'),
	('02517', '68134', '03993', 'УЛ.ГЕОРГИ БЕНКОВСКИ'),
	('02518', '68134', '04008', 'УЛ.ОСОГОВСКИ ПРОХОД'),
	('02519', '68134', '04011', 'УЛ.ГЕОРГИ ГАЧЕВ'),
	('02520', '68134', '04025', 'УЛ.ГЕОРГИ ДАНЧОВ ЗОГРАФИНА'),
	('02521', '68134', '04039', 'УЛ.КАДЕМЛИЯ'),
	('02522', '68134', '04087', 'УЛ.СТЕФАН КЪНЕВ'),
	('02523', '68134', '04090', 'УЛ.ЕКЗАРХ СТЕФАН'),
	('02524', '68134', '04100', 'УЛ.ЗВЕЗДИЦА'),
	('02525', '68134', '04131', 'УЛ.ГЕОРГИ ОБРЕТЕНОВ'),
	('02526', '68134', '04145', 'УЛ.ГЕОРГИ ПЕЯЧЕВИЧ'),
	('02527', '68134', '04159', 'УЛ.ГЕОРГИ РИЛСКИ'),
	('02528', '68134', '04162', 'УЛ.ГЕОРГИ С.РАКОВСКИ'),
	('02529', '68134', '04176', 'УЛ.СВ.ГЕОРГИ СОФИЙСКИ'),
	('02530', '68134', '04183', 'УЛ.ИНЖ.ГЕОРГИ БЕЛОВ'),
	('02531', '68134', '04193', 'УЛ.ЗЛАТОСТРУЙ'),
	('02532', '68134', '04203', 'УЛ.ТИЧА'),
	('02533', '68134', '04220', 'УЛ.ГЕРГАНИЦА'),
	('02534', '68134', '04248', 'УЛ.ГЕРЛОВО'),
	('02535', '68134', '04251', 'УЛ.ГЕЧКЕНЛИ'),
	('02536', '68134', '04265', 'УЛ.ГЕОРГИ ДРАЖЕВ'),
	('02537', '68134', '04279', 'УЛ.ГИНЦИ'),
	('02538', '68134', '04282', 'УЛ.ГЛАДИОЛА'),
	('02539', '68134', '04306', 'УЛ.ГРАДИНА'),
	('02540', '68134', '04314', 'УЛ.ГЕН.РАДКО ДИМИТРИЕВ'),
	('02541', '68134', '04337', 'УЛ.ГОЛАШ'),
	('02542', '68134', '04340', 'УЛ.ГОЛО БЪРДО'),
	('02543', '68134', '04354', 'УЛ.ГОЛЯМ БРАТАН'),
	('02544', '68134', '04368', 'УЛ.ГОРАЗД'),
	('02545', '68134', '04371', 'БУЛ.ГОРНОБАНСКИ'),
	('02546', '68134', '04385', 'УЛ.ГОРИЦА'),
	('02547', '68134', '04409', 'УЛ.БРАИЛА (ГОРНИК)'),
	('02548', '68134', '04412', 'УЛ.ГОРОЦВЕТ'),
	('02549', '68134', '04426', 'УЛ.ГОРСКА ПЪТЕКА'),
	('02550', '68134', '04430', 'УЛ.ГОРСКИ ПЪТНИК'),
	('02551', '68134', '04443', 'УЛ.ГОЦЕ ДЕЛЧЕВ'),
	('02552', '68134', '04457', 'УЛ.КЪРНИГРАДСКА'),
	('02553', '68134', '04474', 'УЛ.ГРАДИНАРСКА'),
	('02554', '68134', '04488', 'УЛ.ГРАДИНИТЕ'),
	('02555', '68134', '04491', 'УЛ.ГРАДИЩЕ'),
	('02556', '68134', '04501', 'УЛ.ГРАМАДА'),
	('02557', '68134', '04515', 'УЛ.ГРАМОС'),
	('02558', '68134', '04532', 'УЛ.ГРАНИЧАР'),
	('02559', '68134', '04546', 'УЛ.ГРАФ ИГНАТИЕВ'),
	('02560', '68134', '04555', 'УЛ.ГРЕБЕНЕЦ'),
	('02561', '68134', '04563', 'УЛ.ГРЕБЕН ПЛАНИНА'),
	('02562', '68134', '04577', 'УЛ.ГАЛИЛЕО ГАЛИЛЕЙ'),
	('02563', '68134', '04580', 'УЛ.ГРИВИЦА'),
	('02564', '68134', '04594', 'УЛ.ГРИГОРИЙ ЦАМБЛАК'),
	('02565', '68134', '04604', 'УЛ.ГРИГОР НАЧЕВИЧ'),
	('02566', '68134', '04618', 'УЛ.ГРИГОР ПЪРЛИЧЕВ'),
	('02567', '68134', '04666', 'УЛ.ГРЪНЧАРСКА'),
	('02568', '68134', '04670', 'УЛ.ГРЪСТНИЧЕ'),
	('02569', '68134', '04683', 'УЛ.ГОДЕЧ (ГУРГУЛЯТ)'),
	('02570', '68134', '04707', 'УЛ.ГЬОЛОВЕТЕ'),
	('02571', '68134', '04710', 'УЛ.ГЪДУЛАРЧЕ'),
	('02572', '68134', '04724', 'УЛ.ГЪЛЪБЕЦ'),
	('02573', '68134', '04738', 'УЛ.ГЪЛЪБОВА'),
	('02574', '68134', '04755', 'УЛ.ДАМЯНИЦА'),
	('02575', '68134', '04769', 'УЛ.ДАН КОЛОВ'),
	('02576', '68134', '04772', 'УЛ.ДАНТЕ'),
	('02577', '68134', '04786', 'УЛ.ДАСКАЛ КОЛЕ'),
	('02578', '68134', '04796', 'УЛ.ДАСКАЛ МАНОЛ'),
	('02579', '68134', '04801', 'УЛ.ДАСКАЛ НИКИТА'),
	('02580', '68134', '04813', 'УЛ.ДАСКАЛ СТОЯН ПОПАНДРЕЕВ'),
	('02581', '68134', '04830', 'УЛ.20-ТИ АПРИЛ'),
	('02582', '68134', '04844', 'УЛ.22-РИ СЕПТЕМВРИ'),
	('02583', '68134', '04861', 'УЛ.23-ТИ ДЕКЕМВРИ'),
	('02584', '68134', '04875', 'УЛ.ВЯРА'),
	('02585', '68134', '04889', 'УЛ.ЖЕЛЕЗОПЪТНА'),
	('02586', '68134', '04892', 'УЛ.ДЕВНЯ'),
	('02587', '68134', '04902', 'УЛ.ДЕДЕ АГАЧ'),
	('02588', '68134', '04916', 'УЛ.ДЕМИР КАПИЯ'),
	('02589', '68134', '04927', 'УЛ.ДЕНИЦА'),
	('02590', '68134', '04933', 'УЛ.РЕЗНЬОВЕТЕ (ДЕНЧО МИНКОВ)'),
	('02591', '68134', '04947', 'УЛ.ДЕСЕТИ КИЛОМЕТЪР'),
	('02592', '68134', '04950', 'УЛ.ДЕСИСЛАВА'),
	('02593', '68134', '04964', 'УЛ.ДЕТЕЛИН ВОЙВОДА'),
	('02594', '68134', '04978', 'УЛ.ДЕЧКО ЙОРДАНОВ'),
	('02595', '68134', '04995', 'УЛ.ДЕЯН БЕЛИШКИ'),
	('02596', '68134', '05027', 'УЛ.ДИВНА'),
	('02597', '68134', '05030', 'УЛ.ДИЛЯНКА'),
	('02598', '68134', '05044', 'УЛ.ПЛОВДИВСКО ШОСЕ'),
	('02599', '68134', '05058', 'УЛ.ГЕН.ВЛАДИМИР ДИНЧЕВ'),
	('02600', '68134', '05075', 'УЛ.ДИМИТЪР ДОСПЕВСКИ'),
	('02601', '68134', '05089', 'УЛ.ИВА'),
	('02602', '68134', '05102', 'УЛ.ЦВЕТНИЦА'),
	('02603', '68134', '05116', 'УЛ.ДИМИТЪР Л.ГИЧЕВ'),
	('02604', '68134', '05133', 'УЛ.БУКАРА'),
	('02605', '68134', '05147', 'УЛ.ДИМИТЪР ДИМОВ'),
	('02606', '68134', '05150', 'УЛ.ДОБРИЧ'),
	('02607', '68134', '05164', 'УЛ.САМОДИВЕЦ'),
	('02608', '68134', '05178', 'УЛ.ГЕН.СТЕФАН ТОШЕВ'),
	('02609', '68134', '05205', 'УЛ.ДИМИТЪР МАНОВ'),
	('02610', '68134', '05222', 'УЛ.КНЯГИНЯ КЛЕМЕНТИНА'),
	('02611', '68134', '05236', 'УЛ.ПРЕКИ ПЪТ'),
	('02612', '68134', '05240', 'БУЛ.АКАД.ИВАН ЕВСТРАТИЕВ ГЕШОВ'),
	('02613', '68134', '05253', 'УЛ.ДИМИТЪР ПЕТКОВ'),
	('02614', '68134', '05267', 'УЛ.КРАКРА'),
	('02615', '68134', '05270', 'УЛ.ДИМИТЪР СОФИЯНЕЦ'),
	('02616', '68134', '05284', 'УЛ.ЕЛИН ВРЪХ'),
	('02617', '68134', '05298', 'УЛ.ДЕСПОТ СЛАВ'),
	('02618', '68134', '05308', 'УЛ.ДИМИТЪР ТАЛЕВ'),
	('02619', '68134', '05311', 'УЛ.КЕСТЕН'),
	('02620', '68134', '05325', 'УЛ.ДИМИТЪР ТРАЙКОВИЧ'),
	('02621', '68134', '05339', 'УЛ.ДИМИТЪР ХАДЖИКОЦЕВ'),
	('02622', '68134', '05342', 'УЛ.ДИМИТЪР ЧИНТУЛОВ (554-ТА)'),
	('02623', '68134', '05365', 'УЛ.ДАНАИЛ ДЕЧЕВ'),
	('02624', '68134', '05373', 'УЛ.ВЛАДАЙСКА'),
	('02625', '68134', '05387', 'УЛ.ДИМЧО ДЕБЕЛЯНОВ'),
	('02626', '68134', '05390', 'УЛ.ДИНАМО'),
	('02627', '68134', '05400', 'УЛ.ДНЕПЪР'),
	('02628', '68134', '05414', 'УЛ.ДОБРИ ВОЙНИКОВ'),
	('02629', '68134', '05428', 'УЛ.ДОБРИ ЖЕЛЯЗКОВ'),
	('02630', '68134', '05445', 'УЛ.ДОБРИЛА'),
	('02631', '68134', '05459', 'УЛ.ДОБРОВОЛЕЦ'),
	('02632', '68134', '05462', 'УЛ.ДОБРОМИРКА'),
	('02633', '68134', '05476', 'УЛ.ДОБРОМИР СТРЕЗ'),
	('02634', '68134', '05480', 'УЛ.ДОБРОМИР ХРИЗ'),
	('02635', '68134', '05493', 'УЛ.ДОБРОТИЧ'),
	('02636', '68134', '05503', 'УЛ.ДОБРУДЖА'),
	('02637', '68134', '05517', 'УЛ.ДОБЪР ЮНАК'),
	('02638', '68134', '05520', 'УЛ.ДОГАНИЦА'),
	('02639', '68134', '05534', 'УЛ.ДОЙРАН'),
	('02640', '68134', '05548', 'УЛ.ПАВЕЛ ШАТЕВ'),
	('02641', '68134', '05551', 'УЛ.Д-Р АЛБЕРТ ЛОНГ'),
	('02642', '68134', '05565', 'УЛ.Д-Р Г.ВЪЛКОВИЧ'),
	('02643', '68134', '05579', 'УЛ.Д-Р Д.СЪСЕЛОВ'),
	('02644', '68134', '05582', 'УЛ.Д-Р ИВАН СЕЛИМИНСКИ'),
	('02645', '68134', '05596', 'УЛ.КРЪСТЮ САРАФОВ'),
	('02646', '68134', '05606', 'УЛ.Д-Р ЛЮДВИГ ЗАМЕНХОВ'),
	('02647', '68134', '05611', 'УЛ.Д-Р МАРИН РУСЕВ'),
	('02648', '68134', '05623', 'УЛ.БАЛША'),
	('02649', '68134', '05637', 'УЛ.Д-Р ПЕТЪР БЕРОН'),
	('02650', '68134', '05640', 'УЛ.ПЛИСКА'),
	('02651', '68134', '05654', 'УЛ.Д-Р СТЕФАН САРАФОВ'),
	('02652', '68134', '05668', 'УЛ.Д-Р СТОЯН ЧОМАКОВ'),
	('02653', '68134', '05709', 'УЛ.ДИМИТЪР БОЧУКОВ'),
	('02654', '68134', '05712', 'УЛ.ДОН'),
	('02655', '68134', '05737', 'УЛ.ДОРОСТОЛ'),
	('02656', '68134', '05743', 'УЛ.ДОСПАТ'),
	('02657', '68134', '05757', 'УЛ.ДОСПЕЙСКИ ПРОХОД'),
	('02658', '68134', '05774', 'УЛ.ХРИСТО МАТОВ'),
	('02659', '68134', '05788', 'УЛ.ДРАВСКИ БОЙ'),
	('02660', '68134', '05791', 'УЛ.ДРАГАЛЕВСКА'),
	('02661', '68134', '05801', 'УЛ.ДРАГОВИЦА'),
	('02662', '68134', '05815', 'УЛ.ДРАГОМАН'),
	('02663', '68134', '05829', 'УЛ.ДРАГШАН'),
	('02664', '68134', '05832', 'УЛ.ДРЕНЕТО'),
	('02665', '68134', '05846', 'УЛ.ДРУГАН'),
	('02666', '68134', '05852', 'УЛ.ДРУЖБА'),
	('02667', '68134', '05863', 'УЛ.ДРЪСТЪР'),
	('02668', '68134', '05880', 'УЛ.ДРЯНОВСКИ МАНАСТИР'),
	('02669', '68134', '05894', 'УЛ.ДУКАТСКА ПЛАНИНА'),
	('02670', '68134', '05904', 'УЛ.ДУНАВ'),
	('02671', '68134', '05918', 'УЛ.ДУНАВСКИ ЛЕБЕД'),
	('02672', '68134', '05921', 'УЛ.ДУПНИЦА'),
	('02673', '68134', '05949', 'УЛ.ДЪБНИЦА'),
	('02674', '68134', '05952', 'УЛ.ДЪБОВА ГОРА'),
	('02675', '68134', '05978', 'УЛ.ДЪГА'),
	('02676', '68134', '05983', 'УЛ.ДЪРВЕНИШКА РЕКА'),
	('02677', '68134', '05997', 'УЛ.ДЮЛЕНСКИ ПРОХОД'),
	('02678', '68134', '06001', 'УЛ.НИКОЛА ПЕТРОВ'),
	('02679', '68134', '06015', 'УЛ.ДЯДО ЦОНЕ'),
	('02680', '68134', '06032', 'УЛ.ПИЪРС О\'МАХОНИ'),
	('02681', '68134', '06046', 'УЛ.ЕВГЕНИЙ ЧЕРВЕНКОВ'),
	('02682', '68134', '06050', 'УЛ.ЕВСТАТИ ПЕЛАГОНИЙСКИ'),
	('02683', '68134', '06063', 'УЛ.ЕДЕЛВАЙС (НАДЕЖДА)'),
	('02684', '68134', '06077', 'УЛ.ЕДЕЛВАЙС (ОВЧА КУПЕЛ)'),
	('02685', '68134', '06080', 'УЛ.11-ТИ АВГУСТ'),
	('02686', '68134', '06104', 'УЛ.ЕДИСОН'),
	('02687', '68134', '06118', 'УЛ.ЕКАТЕРИНА СИМИДЧИЙСКА'),
	('02688', '68134', '06121', 'УЛ.ЕКЗАРХ ЙОСИФ'),
	('02689', '68134', '06152', 'УЛ.ЕЛЕМАГ'),
	('02690', '68134', '06197', 'УЛ.ЕЛИН ПЕЛИН'),
	('02691', '68134', '06207', 'УЛ.ЕЛИСЕЙНА'),
	('02692', '68134', '06224', 'УЛ.ЕЛТИМИР'),
	('02693', '68134', '06241', 'УЛ.ЕЛША'),
	('02694', '68134', '06255', 'УЛ.ЕМАНУИЛ ВАСКИДОВИЧ'),
	('02695', '68134', '06272', 'УЛ.ЕМИЛ БЕРЗИНСКИ'),
	('02696', '68134', '06290', 'УЛ.ДИМИТЪР ГРЕКОВ'),
	('02697', '68134', '06306', 'УЛ.ОВЧЕ ПОЛЕ'),
	('02698', '68134', '06327', 'УЛ.ЕМИНЕ'),
	('02699', '68134', '06330', 'УЛ.ЕНИСЕЙ'),
	('02700', '68134', '06344', 'УЛ.ЕНОС'),
	('02701', '68134', '06361', 'УЛ.ЕРОВЕТЕ'),
	('02702', '68134', '06375', 'УЛ.ЕСПЕРАНТО'),
	('02703', '68134', '06389', 'УЛ.ЕУЖЕН ПОАТИЕ'),
	('02704', '68134', '06402', 'УЛ.ЕХО'),
	('02705', '68134', '06416', 'УЛ.ЖАБОКРЕК'),
	('02706', '68134', '06421', 'УЛ.ЖАМБИЛИЦА'),
	('02707', '68134', '06447', 'УЛ.БЪЛГАРСКА МОРАВА'),
	('02708', '68134', '06450', 'УЛ.ЖЕЛЕЗЕН МОСТ'),
	('02709', '68134', '06464', 'УЛ.ЖЕЛЕЗНИ ВРАТА'),
	('02710', '68134', '06478', 'УЛ.ЖЕКО ВОЙВОДА'),
	('02711', '68134', '06481', 'УЛ.ЖЕТВАРКА'),
	('02712', '68134', '06495', 'УЛ.ЖИВАТА ВОДА'),
	('02713', '68134', '06505', 'УЛ.ЖИВКО НИКОЛОВ'),
	('02714', '68134', '06519', 'УЛ.ЖИТНИЦА'),
	('02715', '68134', '06522', 'УЛ.ЗАВАЛСКА КИТКА'),
	('02716', '68134', '06536', 'УЛ.ЗАВОДСКА'),
	('02717', '68134', '06553', 'УЛ.ЗАГОРЕ'),
	('02718', '68134', '06567', 'УЛ.ЗАГОРИЧАНЕ'),
	('02719', '68134', '06598', 'УЛ.ЗАЙЧАР'),
	('02720', '68134', '06611', 'УЛ.ЗАХАРИ КРУША'),
	('02721', '68134', '06625', 'УЛ.ХАН СЕВАР (СТЕФАН ЧОМАКОВ)'),
	('02722', '68134', '06639', 'УЛ.ЗАХАРИ СТОЯНОВ'),
	('02723', '68134', '06642', 'УЛ.ЗВЪНЧЕ'),
	('02724', '68134', '06656', 'УЛ.ЗВЕЗДЕЛ'),
	('02725', '68134', '06662', 'УЛ.ЗВЕНОВОД'),
	('02726', '68134', '06673', 'УЛ.ЗВЪНИКА'),
	('02727', '68134', '06687', 'УЛ.ЗДРАВЕ'),
	('02728', '68134', '06690', 'УЛ.ЗДРАВЕЦ'),
	('02729', '68134', '06731', 'УЛ.ЗЕЛЕНА ПОЛЯНА'),
	('02730', '68134', '06745', 'УЛ.ЗЕМЛЯНЕ'),
	('02731', '68134', '06762', 'УЛ.ЗЕЛЕНА ЛИВАДА'),
	('02732', '68134', '06788', 'УЛ.ЗЕМЕН'),
	('02733', '68134', '06793', 'УЛ.БИЗНЕС ПАРК СОФИЯ'),
	('02734', '68134', '06803', 'УЛ.ЗЛАТЕН КЛАС'),
	('02735', '68134', '06817', 'УЛ.ЗЛАТЕН РОГ'),
	('02736', '68134', '06820', 'УЛ.ЗЛАТИЦА'),
	('02737', '68134', '06834', 'УЛ.ЗЛАТИШКИ ПРОХОД'),
	('02738', '68134', '06848', 'УЛ.ЗЛАТНА ДОБРУДЖА'),
	('02739', '68134', '06882', 'УЛ.ЗЛАТНИ ВРАТА'),
	('02740', '68134', '06906', 'УЛ.ЗЛИ ДОЛ'),
	('02741', '68134', '06919', 'УЛ.ЗНАМЕ'),
	('02742', '68134', '06923', 'УЛ.ЗНАМЕ НА МИРА'),
	('02743', '68134', '06937', 'УЛ.ЗНАМЕ НА ТРУДА'),
	('02744', '68134', '06940', 'УЛ.ПРОФ.ИВАН ДУЙЧЕВ'),
	('02745', '68134', '06968', 'УЛ.ЗОГРАФСКИ МАНАСТИР'),
	('02746', '68134', '06971', 'УЛ.ЗОРА'),
	('02747', '68134', '06985', 'УЛ.ЗОРНИЦА'),
	('02748', '68134', '06999', 'УЛ.ДЕБЪР'),
	('02749', '68134', '07003', 'УЛ.ИВАЙЛО'),
	('02750', '68134', '07017', 'УЛ.БОГОВЕЦ'),
	('02751', '68134', '07051', 'УЛ.ИВАН БОЖИЛОВ'),
	('02752', '68134', '07065', 'УЛ.ИВАН БОРИМЕЧКАТА'),
	('02753', '68134', '07082', 'УЛ.ИВАН ВАЗОВ'),
	('02754', '68134', '07116', 'УЛ.ИВАН ДЕНКОГЛУ'),
	('02755', '68134', '07123', 'УЛ.ИВАН ДИМИТРОВ-КУКЛАТА'),
	('02756', '68134', '07137', 'УЛ.ИВАН ДИМ.НЕНОВ'),
	('02757', '68134', '07140', 'УЛ.ИВАН ДОБРОВСКИ'),
	('02758', '68134', '07154', 'УЛ.ИВАНИЦА ДАНЧЕВ'),
	('02759', '68134', '07199', 'УЛ.Д-Р ЛЮБЕН РУСЕВ'),
	('02760', '68134', '07212', 'УЛ.ИВАН ЙОНЧЕВ'),
	('02761', '68134', '07231', 'УЛ.ИВАН МАРИНОВ ЙОНЧЕВ'),
	('02762', '68134', '07243', 'УЛ.ИВАН МИЛАНОВ'),
	('02763', '68134', '07257', 'УЛ.ЧЕРНОМЕН'),
	('02764', '68134', '07260', 'УЛ.ИВАН МЪРКВИЧКА'),
	('02765', '68134', '07288', 'УЛ.ГЕН.ГЕОРГИ ВАЗОВ'),
	('02766', '68134', '07291', 'УЛ.Д-Р КАЛИНКОВ'),
	('02767', '68134', '07301', 'УЛ.ИВАН ПОПОВ'),
	('02768', '68134', '07329', 'УЛ.СВЕТИ ИВАН РИЛСКИ'),
	('02769', '68134', '07357', 'УЛ.ИВАН СУСАНИН'),
	('02770', '68134', '07363', 'УЛ.ИВАН ТУРГЕНЕВ'),
	('02771', '68134', '07380', 'УЛ.ОСТРОВО'),
	('02772', '68134', '07394', 'УЛ.ИВАН ЧУШКОВ'),
	('02773', '68134', '07404', 'УЛ.ИВАН ШОНЕВ'),
	('02774', '68134', '07421', 'УЛ.ИВАН ЩЕРЕВ'),
	('02775', '68134', '07435', 'УЛ.ИВАЦ ВОЙВОДА'),
	('02776', '68134', '07452', 'УЛ.ИЗВОР'),
	('02777', '68134', '07466', 'УЛ.ИЗГРЕВ'),
	('02778', '68134', '07472', 'УЛ.ИЛАРИОН ДРАГОСТИНОВ'),
	('02779', '68134', '07497', 'УЛ.ИЛАРИОН МАКАРИОПОЛСКИ'),
	('02780', '68134', '07507', 'УЛ.ИЛИЙЧО П.ИЛИЕВ'),
	('02781', '68134', '07524', 'УЛ.ИЛИНДЕНСКО ВЪСТАНИЕ'),
	('02782', '68134', '07541', 'УЛ.ГОРНИ ПОРОЙ'),
	('02783', '68134', '07555', 'УЛ.ИЛИЯ ГЕОРГОВ'),
	('02784', '68134', '07569', 'УЛ.КОРАБ ПЛАНИНА'),
	('02785', '68134', '07586', 'УЛ.ИЛЬО ВОЙВОДА'),
	('02786', '68134', '07598', 'УЛ.ИНДЖЕ ВОЙВОДА'),
	('02787', '68134', '07613', 'УЛ.НОВ ВЕК'),
	('02788', '68134', '07627', 'УЛ.ИНСТИТУТСКА'),
	('02789', '68134', '07630', 'УЛ.ИЦКАХ ГРАЦИАНИ'),
	('02790', '68134', '07644', 'УЛ.ИСКРА'),
	('02791', '68134', '07661', 'УЛ.ИСКЪР'),
	('02792', '68134', '07675', 'УЛ.ИСКЪРСКИ ПРОЛОМ'),
	('02793', '68134', '07689', 'УЛ.КНЯЗ ИВАН КУЛИН'),
	('02794', '68134', '07692', 'УЛ.ЙОАКИМ ГРУЕВ'),
	('02795', '68134', '07702', 'УЛ.ЙОАКИМ КЪРЧОВСКИ'),
	('02796', '68134', '07729', 'УЛ.ЙОАН ЕКЗАРХ'),
	('02797', '68134', '07747', 'УЛ.ЛЮБЛЯНА'),
	('02798', '68134', '07764', 'УЛ.ЙОРДАН ЙОВКОВ'),
	('02799', '68134', '07778', 'УЛ.РУСАЛКА (ЙОРДАН КИСКИНОВ)'),
	('02800', '68134', '07781', 'УЛ.САВА ФИЛАРЕТОВ'),
	('02801', '68134', '07795', 'УЛ.СТАРАТА ЦЪРКВА'),
	('02802', '68134', '07805', 'УЛ.БОГАТИЦА'),
	('02803', '68134', '07822', 'УЛ.ЙОСИФ КОВАЧЕВ'),
	('02804', '68134', '07836', 'УЛ.ЙОСИФ СОКОЛСКИ'),
	('02805', '68134', '07853', 'УЛ.КАВАЛА'),
	('02806', '68134', '07867', 'УЛ.КАВАРНА'),
	('02807', '68134', '07870', 'УЛ.КАДИН ВРЪХ'),
	('02808', '68134', '07884', 'УЛ.КАЗАНДЖИЯТА'),
	('02809', '68134', '07908', 'УЛ.КАЗБЕК'),
	('02810', '68134', '07911', 'УЛ.КАЙМАКЧАЛАН'),
	('02811', '68134', '07925', 'УЛ.КАКАЧ'),
	('02812', '68134', '07939', 'УЛ.КАЛАЧ'),
	('02813', '68134', '07956', 'УЛ.КАЛИАКРА'),
	('02814', '68134', '07960', 'УЛ.КАЛИМАНЦИ'),
	('02815', '68134', '07973', 'УЛ.ЕЛИСАВЕТА БАГРЯНА'),
	('02816', '68134', '07987', 'УЛ.КАЛИНКА'),
	('02817', '68134', '07990', 'УЛ.ВЛАДИМИР КУРТЕВ'),
	('02818', '68134', '08005', 'УЛ.КОЛОМАН'),
	('02819', '68134', '08019', 'УЛ.КАЛОФЕР'),
	('02820', '68134', '08022', 'УЛ.КАЛОЯНОВО'),
	('02821', '68134', '08036', 'УЛ.КАМЕН АНДРЕЕВ'),
	('02822', '68134', '08041', 'УЛ.КАМЕН ДЯЛ'),
	('02823', '68134', '08053', 'УЛ.КАМЕНИСТ ПЪТ'),
	('02824', '68134', '08067', 'УЛ.КАМЕНИЦА'),
	('02825', '68134', '08084', 'УЛ.КАМЕННО ЦВЕТЕ'),
	('02826', '68134', '08098', 'УЛ.КАМЕНОДЕЛСКА'),
	('02827', '68134', '08108', 'УЛ.КАМЧАТКА'),
	('02828', '68134', '08111', 'УЛ.КАМЧИЯ'),
	('02829', '68134', '08125', 'УЛ.КАНАРЧЕ'),
	('02830', '68134', '08139', 'УЛ.КАПИНА'),
	('02831', '68134', '08142', 'УЛ.КАПИНОВСКИ МАНАСТИР'),
	('02832', '68134', '08156', 'УЛ.КАП.АНДРЕЕВ'),
	('02833', '68134', '08173', 'УЛ.КАП.ГЕОРГИ МАМАРЧЕВ'),
	('02834', '68134', '08187', 'УЛ.КАП.РАЙЧО НИКОЛОВ'),
	('02835', '68134', '08190', 'УЛ.КАП.ТОДОР НОЧЕВ'),
	('02836', '68134', '08200', 'УЛ.КАПКА'),
	('02837', '68134', '08228', 'УЛ.КАРАМФИЛ'),
	('02838', '68134', '08231', 'УЛ.КАРЛОВО'),
	('02839', '68134', '08245', 'УЛ.КАРНЕГИ'),
	('02840', '68134', '08259', 'УЛ.КАРПАТИ'),
	('02841', '68134', '08262', 'УЛ.ПЕРУН'),
	('02842', '68134', '08276', 'УЛ.СВЕТА ЕКАТЕРИНА'),
	('02843', '68134', '08282', 'УЛ.КАЧАНИК'),
	('02844', '68134', '08303', 'УЛ.КЕНАЛИ'),
	('02845', '68134', '08317', 'УЛ.КЕРЧ'),
	('02846', '68134', '08320', 'УЛ.КЕСТЕНОВА ГОРА'),
	('02847', '68134', '08334', 'УЛ.ЖЕНЕВА'),
	('02848', '68134', '08348', 'УЛ.КИРИЛ БЛАГОЕВ'),
	('02849', '68134', '08351', 'УЛ.КИРИЛ БОЖИКОВ'),
	('02850', '68134', '08379', 'УЛ.МИТРОПОЛИТ КИРИЛ ВИДИНСКИ'),
	('02851', '68134', '08382', 'УЛ.СВ.СВ.КИРИЛ И МЕТОДИЙ'),
	('02852', '68134', '08406', 'УЛ.ПРАЖКА ПРОЛЕТ'),
	('02853', '68134', '08413', 'УЛ.КИРИЛ ПЕЙЧИНОВИЧ'),
	('02854', '68134', '08437', 'УЛ.КИРО ТУЛЕШКОВ'),
	('02855', '68134', '08440', 'УЛ.СИМЕОН РАДЕВ'),
	('02856', '68134', '08454', 'УЛ.ХРИСТО СТЕФЧОВ'),
	('02857', '68134', '08468', 'УЛ.СВ.КРАЛ'),
	('02858', '68134', '08485', 'УЛ.КИТНА'),
	('02859', '68134', '08509', 'УЛ.ИЛИЯ ЦАНОВ (КЛАСОВА БОРБА)'),
	('02860', '68134', '08526', 'УЛ.КЛИСУРА'),
	('02861', '68134', '08539', 'УЛ.КЛОКОТНИЦА'),
	('02862', '68134', '08543', 'УЛ.КНИЖОВНИК'),
	('02863', '68134', '08557', 'УЛ.КНЯГИНЯ КОСАРА'),
	('02864', '68134', '08560', 'УЛ.КНЯГИНЯ ТАМАРА'),
	('02865', '68134', '08574', 'УЛ.КНЯЗ БОРИС I'),
	('02866', '68134', '08588', 'УЛ.ХАН ПЕРСИЯН'),
	('02867', '68134', '08591', 'УЛ.КНЯЗ ЧЕРКАЗКИ'),
	('02868', '68134', '08601', 'УЛ.КОБИЛИНО БРАНИЩЕ'),
	('02869', '68134', '08615', 'УЛ.КОЖАРСКА'),
	('02870', '68134', '08629', 'УЛ.КОЖУХ ПЛАНИНА'),
	('02871', '68134', '08632', 'УЛ.КОЗЛОДУЙ'),
	('02872', '68134', '08646', 'УЛ.КОЗНИЦА'),
	('02873', '68134', '08654', 'УЛ.КОЗЯК'),
	('02874', '68134', '08663', 'УЛ.КОКИЧЕ'),
	('02875', '68134', '08677', 'УЛ.АТАНАС ДАЛЧЕВ'),
	('02876', '68134', '08680', 'УЛ.КОЛЮ ФИЧЕТО'),
	('02877', '68134', '08704', 'УЛ.ЖИТЕН'),
	('02878', '68134', '08735', 'УЛ.КОМИНИТЕ'),
	('02879', '68134', '08749', 'УЛ.КОМ'),
	('02880', '68134', '08766', 'УЛ.ЛЮБОРОДИЕ'),
	('02881', '68134', '08770', 'УЛ.ДАСКАЛ СТЕФЧО'),
	('02882', '68134', '08783', 'УЛ.АЛЕКО ТУРАНДЖА'),
	('02883', '68134', '08797', 'УЛ.КОНСТАНТИН ИГНАТОВ'),
	('02884', '68134', '08807', 'УЛ.КОНСТАНТИН ИРЕЧЕК'),
	('02885', '68134', '08810', 'УЛ.КОНСТАНТИН КИСИМОВ'),
	('02886', '68134', '08838', 'УЛ.КОНСТАНТИН ПРЕСЛАВСКИ'),
	('02887', '68134', '08841', 'УЛ.КОНСТАНТИН ФОТИНОВ'),
	('02888', '68134', '08855', 'УЛ.КОНЬО ВОЙВОДА'),
	('02889', '68134', '08872', 'УЛ.КОПИТОТО'),
	('02890', '68134', '08886', 'УЛ.КОПРЕН'),
	('02891', '68134', '08895', 'УЛ.КОПРИВА'),
	('02892', '68134', '08900', 'УЛ.КОПРИНАРСКА'),
	('02893', '68134', '08927', 'УЛ.КОРТЕН'),
	('02894', '68134', '08930', 'УЛ.КОСОВО ПОЛЕ'),
	('02895', '68134', '08944', 'УЛ.КОСТА ИЛИЕВ'),
	('02896', '68134', '08958', 'УЛ.КОСТА ПЕТРУНОВ'),
	('02897', '68134', '08961', 'УЛ.ЦАРИЦА ЕЛЕОНОРА'),
	('02898', '68134', '08975', 'УЛ.ЧУМЕРНА'),
	('02899', '68134', '08989', 'УЛ.КОСТАДИН РАЧЕВ ХРИСТОВ'),
	('02900', '68134', '09007', 'УЛ.КОСТАДИН Т.ПЕТРОВ'),
	('02901', '68134', '09024', 'УЛ.КОСТЕНЕЦ'),
	('02902', '68134', '09038', 'УЛ.КОСТИНА'),
	('02903', '68134', '09041', 'УЛ.КОСТУР'),
	('02904', '68134', '09055', 'УЛ.КОТА 1050'),
	('02905', '68134', '09069', 'УЛ.КОТЕЛ'),
	('02906', '68134', '09086', 'УЛ.ОДОРОВЦИ'),
	('02907', '68134', '09092', 'УЛ.КОЧАНИ'),
	('02908', '68134', '09108', 'УЛ.КОЧО ЧЕСТИМЕНСКИ'),
	('02909', '68134', '09130', 'УЛ.КРАЙРЕЧНА'),
	('02910', '68134', '09175', 'УЛ.КРАЛИ МАРКО'),
	('02911', '68134', '09189', 'УЛ.КРАСИНО'),
	('02912', '68134', '09192', 'УЛ.КРАСНА КИТКА'),
	('02913', '68134', '09202', 'УЛ.ДЯДО ИВАН ДОБРЕВ'),
	('02914', '68134', '09216', 'УЛ.КРАТОВО'),
	('02915', '68134', '09223', 'УЛ.КРЕПОСТ'),
	('02916', '68134', '09233', 'УЛ.КРЕСНА'),
	('02917', '68134', '09247', 'УЛ.КРИВА РЕКА'),
	('02918', '68134', '09250', 'УЛ.КРИВИНА'),
	('02919', '68134', '09264', 'УЛ.КРИВОЛАК'),
	('02920', '68134', '09278', 'УЛ.КРИВОРЕЧНА ПАЛАНКА'),
	('02921', '68134', '09281', 'УЛ.КРИМ'),
	('02922', '68134', '09295', 'УЛ.КРИСТАЛ'),
	('02923', '68134', '09305', 'УЛ.КРИЧИМ'),
	('02924', '68134', '09319', 'УЛ.КРОНЩАДТ'),
	('02925', '68134', '09322', 'УЛ.КРУМ КЮЛЯВКОВ'),
	('02926', '68134', '09336', 'УЛ.КРУМ ПОПОВ'),
	('02927', '68134', '09349', 'УЛ.КРУМ ХР.СТОЯНОВ'),
	('02928', '68134', '09367', 'УЛ.КРУШОВСКИ ВРЪХ'),
	('02929', '68134', '09370', 'УЛ.СЕЛО КРЪВЕНИК'),
	('02930', '68134', '09384', 'УЛ.КРЪСТЕЦ'),
	('02931', '68134', '09398', 'УЛ.ИНЖ.БОРИСЛАВ ОГОЙСКИ'),
	('02932', '68134', '09411', 'УЛ.КУБАДИН'),
	('02933', '68134', '09425', 'УЛ.АРХ.ПЕТКО МОМЧИЛОВ'),
	('02934', '68134', '09456', 'УЛ.КУМАНОВО'),
	('02935', '68134', '09464', 'УЛ.КУМАНОВСКИ БОЙ'),
	('02936', '68134', '09473', 'УЛ.КУМАТА'),
	('02937', '68134', '09487', 'УЛ.КУПЕНИТЕ'),
	('02938', '68134', '09490', 'УЛ.БАНАТ'),
	('02939', '68134', '09500', 'УЛ.КУТЛОВИЦА'),
	('02940', '68134', '09514', 'УЛ.КЪКРИНСКО ХАНЧЕ'),
	('02941', '68134', '09528', 'УЛ.РАВНИЩЕ'),
	('02942', '68134', '09531', 'УЛ.КЮСТЕНДЖА'),
	('02943', '68134', '09545', 'УЛ.ЛАВАНДУЛА'),
	('02944', '68134', '09559', 'УЛ.ЛАВЕЛЕ'),
	('02945', '68134', '09562', 'УЛ.ЛАДА'),
	('02946', '68134', '09576', 'УЛ.ЛАДОГА'),
	('02947', '68134', '09580', 'УЛ.ЦВЕТАН РАДОСЛАВОВ'),
	('02948', '68134', '09593', 'УЛ.ЛАЗУРНА'),
	('02949', '68134', '09603', 'УЛ.ЛАЗУРНО УТРО'),
	('02950', '68134', '09617', 'УЛ.ЛАЙБНИЦ'),
	('02951', '68134', '09620', 'УЛ.ЛАЙОШ КОШУТ'),
	('02952', '68134', '09634', 'УЛ.ЛАКАТИЦА'),
	('02953', '68134', '09648', 'УЛ.ЛАЛЕ'),
	('02954', '68134', '09651', 'УЛ.ГЮЕШЕВО'),
	('02955', '68134', '09665', 'УЛ.ЛАМБИ КРЪСТЕВ'),
	('02956', '68134', '09682', 'УЛ.ЛАТИНКА'),
	('02957', '68134', '09696', 'УЛ.ЛВОВ'),
	('02958', '68134', '09706', 'УЛ.ЙЕРУСАЛИМ'),
	('02959', '68134', '09710', 'УЛ.БРЕГАЛНИЦА'),
	('02960', '68134', '09723', 'УЛ.ЛЕВ ТОЛСТОЙ'),
	('02961', '68134', '09737', 'УЛ.ЛЕВИ ИСКЪР'),
	('02962', '68134', '09740', 'УЛ.ЛЕГЕ'),
	('02963', '68134', '09771', 'УЛ.ЛЕЛИНСКА ЧУКА'),
	('02964', '68134', '09785', 'УЛ.ЛЕОНАРДО ДА ВИНЧИ'),
	('02965', '68134', '09809', 'УЛ.МЪГЛЕН'),
	('02966', '68134', '09812', 'УЛ.ЛЕПЕНЕЦ'),
	('02967', '68134', '09826', 'УЛ.ЛЕРИН'),
	('02968', '68134', '09860', 'УЛ.ЛЕТОВИЩНА'),
	('02969', '68134', '09874', 'УЛ.ЛЕТОСТРУЙ'),
	('02970', '68134', '09888', 'УЛ.ЛЕЧЕБЕН ИЗВОР'),
	('02971', '68134', '09901', 'УЛ.ЛИВАДА'),
	('02972', '68134', '09915', 'УЛ.ЛИДИЦЕ'),
	('02973', '68134', '09932', 'УЛ.ЛИЛИЯ'),
	('02974', '68134', '09946', 'УЛ.ЛИПОВ РЪТ'),
	('02975', '68134', '09951', 'УЛ.ЛИПОВ ЦВЯТ'),
	('02976', '68134', '09980', 'УЛ.ЛИСТОПАД'),
	('02977', '68134', '10015', 'УЛ.ЛОЗЕНГРАД'),
	('02978', '68134', '10029', 'УЛ.ЛОЗЕНЕЦ'),
	('02979', '68134', '10032', 'УЛ.ЛОЗЕНСКА ПЛАНИНА'),
	('02980', '68134', '10046', 'УЛ.ЛОЗИЩЕ'),
	('02981', '68134', '10050', 'УЛ.Д-Р ЛЮБА ГРИГОРОВА'),
	('02982', '68134', '10063', 'УЛ.ЛОКОРСКА'),
	('02983', '68134', '10077', 'УЛ.ЛОМСКА'),
	('02984', '68134', '10104', 'УЛ.ЛОТОС'),
	('02985', '68134', '10135', 'УЛ.ЛУИ ЛЕЖЕ'),
	('02986', '68134', '10149', 'УЛ.ЗЛАТОВРЪХ'),
	('02987', '68134', '10166', 'УЛ.ЛЪВЧЕТО'),
	('02988', '68134', '10176', 'УЛ.ЛЮБАТА'),
	('02989', '68134', '10197', 'УЛ.РАВНЕЦ'),
	('02990', '68134', '10207', 'УЛ.ЛЮБЕН КАРАВЕЛОВ'),
	('02991', '68134', '10210', 'УЛ.ПАРТЕНИЙ НИШАВСКИ'),
	('02992', '68134', '10238', 'УЛ.БУДИНЦИ'),
	('02993', '68134', '10241', 'УЛ.БРЯСТ'),
	('02994', '68134', '10269', 'УЛ.ЛЮЛЕБУРГАС'),
	('02995', '68134', '10272', 'УЛ.ЛЮЛИН'),
	('02996', '68134', '10286', 'УЛ.ЛЮЛИНСКА КОТЛОВИНА'),
	('02997', '68134', '10291', 'УЛ.ЛЮЛИНСКО ПОТОЧЕ'),
	('02998', '68134', '10307', 'УЛ.ЛЮЛЯКОВА ГРАДИНА'),
	('02999', '68134', '10313', 'УЛ.ЛЮТИ БРОД'),
	('03000', '68134', '10327', 'УЛ.ЛЮТИ ДОЛ'),
	('03001', '68134', '10344', 'УЛ.ЛЯСКОВЕЦ'),
	('03002', '68134', '10361', 'УЛ.МАГНОЛИЯ'),
	('03003', '68134', '10375', 'УЛ.МАДАРА'),
	('03004', '68134', '10389', 'УЛ.МАДАРСКИ КОННИК'),
	('03005', '68134', '10392', 'УЛ.МАДЖАРИЦА'),
	('03006', '68134', '10422', 'УЛ.МАЙОР АГОВ'),
	('03007', '68134', '10447', 'УЛ.МАЙОР ГОРТАЛОВ'),
	('03008', '68134', '10450', 'УЛ.МАЙОР ПЪРВАН ТОШЕВ'),
	('03009', '68134', '10464', 'УЛ.МАЙОР ТОМПСЪН'),
	('03010', '68134', '10481', 'УЛ.МАЙОР ЮРИЙ ГАГАРИН'),
	('03011', '68134', '10495', 'УЛ.МАЙСКА ПЕСЕН'),
	('03012', '68134', '10505', 'УЛ.МАЙСКА РОЗА'),
	('03013', '68134', '10519', 'УЛ.МАЙСКИ ДЕН'),
	('03014', '68134', '10522', 'УЛ.МАЙСТОР МАНОЛ'),
	('03015', '68134', '10536', 'УЛ.МАЙЧИНА СЛАВА'),
	('03016', '68134', '10548', 'УЛ.МАК'),
	('03017', '68134', '10553', 'УЛ.ЯКОВ КРАЙКОВ'),
	('03018', '68134', '10567', 'УЛ.МАКГАХАН'),
	('03019', '68134', '10570', 'УЛ.МАКЕДОНИЯ'),
	('03020', '68134', '10584', 'УЛ.МАЛА КУРИЯ'),
	('03021', '68134', '10598', 'УЛ.МАЛАШЕВСКА'),
	('03022', '68134', '10625', 'УЛ.МАЛОМИР'),
	('03023', '68134', '10639', 'УЛ.МАЛУША'),
	('03024', '68134', '10642', 'УЛ.ЯВОР (НАДЕЖДА)'),
	('03025', '68134', '10656', 'УЛ.МАЛЬОВИЦА'),
	('03026', '68134', '10673', 'УЛ.МАНУШ ВОЙВОДА'),
	('03027', '68134', '10687', 'УЛ.МАНЬОВО БЪРДО'),
	('03028', '68134', '10690', 'УЛ.ИРИС'),
	('03029', '68134', '10700', 'УЛ.ЕВЛИЯ ЧЕЛЕБИ'),
	('03030', '68134', '10714', 'УЛ.МЕДВЕН'),
	('03031', '68134', '10728', 'УЛ.МАРГАРИТКА'),
	('03032', '68134', '10731', 'УЛ.МАРИН ДАЧЕВ ХРИСТОВ'),
	('03033', '68134', '10745', 'УЛ.МАРИН ДРИНОВ'),
	('03034', '68134', '10759', 'УЛ.МАРИНКОВИЦА'),
	('03035', '68134', '10762', 'УЛ.МАРКО БАЛАБАНОВ'),
	('03036', '68134', '10776', 'УЛ.МАРКО БОЧАР'),
	('03037', '68134', '10793', 'УЛ.МАРКОВА БАНЯ'),
	('03038', '68134', '10803', 'УЛ.МАТЕЙ ПРЕОБРАЖЕНСКИ'),
	('03039', '68134', '10817', 'УЛ.МАРКОВИ КУЛИ'),
	('03040', '68134', '10820', 'УЛ.ПОГЛЕДЕЦ'),
	('03041', '68134', '10834', 'УЛ.СВ.ТОМА'),
	('03042', '68134', '10848', 'УЛ.МАРТА'),
	('03043', '68134', '10851', 'УЛ.МАРТИНА ПАДИНА'),
	('03044', '68134', '10879', 'УЛ.МАРУША'),
	('03045', '68134', '10882', 'УЛ.МАСЛИНОВО КЛОНЧЕ'),
	('03046', '68134', '10906', 'УЛ.ПРОФ.МИЛКО БИЧЕВ'),
	('03047', '68134', '10937', 'УЛ.МАЧУКОВО'),
	('03048', '68134', '10940', 'УЛ.ГАРОВА'),
	('03049', '68134', '10985', 'УЛ.МЕДЖИДИЕ'),
	('03050', '68134', '11003', 'УЛ.МЕЛНИК'),
	('03051', '68134', '11020', 'УЛ.МЕТАЛ'),
	('03052', '68134', '11034', 'УЛ.МЕТКОВЕЦ'),
	('03053', '68134', '11048', 'УЛ.РАЗЛЪКА'),
	('03054', '68134', '11051', 'УЛ.МЕТОДИ КУСЕВИЧ'),
	('03055', '68134', '11065', 'УЛ.МЕТОДИ МАКЕДОНСКИ'),
	('03056', '68134', '11079', 'УЛ.МЕТОДИ ПАТЧЕВ'),
	('03057', '68134', '11082', 'УЛ.ГЕОРГИ БОГРОВСКИ'),
	('03058', '68134', '11096', 'УЛ.МЕТОХИЯ'),
	('03059', '68134', '11106', 'УЛ.МЕЧА ПОЛЯНА'),
	('03060', '68134', '11117', 'УЛ.МЕЧКА'),
	('03061', '68134', '11123', 'УЛ.МЕЧОВО УСОЕ'),
	('03062', '68134', '11137', 'УЛ.МЕЧТА'),
	('03063', '68134', '11154', 'УЛ.МИДЖУР'),
	('03064', '68134', '11168', 'УЛ.МИДИЯ'),
	('03065', '68134', '11171', 'УЛ.МИЗИЯ'),
	('03066', '68134', '11199', 'УЛ.МИЛАН ДЕЛЧЕВ'),
	('03067', '68134', '11209', 'УЛ.МИЛА РОДИНА'),
	('03068', '68134', '11212', 'УЛ.МИЛЕВСКА ПЛАНИНА'),
	('03069', '68134', '11226', 'УЛ.ЧАЯ'),
	('03070', '68134', '11232', 'УЛ.МИЛИН КАМЪК'),
	('03071', '68134', '11243', 'УЛ.ЦВЕТАН МИНКОВ'),
	('03072', '68134', '11257', 'УЛ.МИЛОСЪРДНА'),
	('03073', '68134', '11274', 'УЛ.МИНЗУХАР'),
	('03074', '68134', '11288', 'УЛ.МИНСК'),
	('03075', '68134', '11301', 'УЛ.МИР'),
	('03076', '68134', '11315', 'УЛ.МИРКОВО'),
	('03077', '68134', '11329', 'УЛ.МИРНИ ДНИ'),
	('03078', '68134', '11332', 'УЛ.МИРОВЦИ'),
	('03079', '68134', '11346', 'УЛ.МИТРОПОЛИТ ПАНАРЕТ'),
	('03080', '68134', '11358', 'УЛ.ЗЕЛЕНО ДЪРВО'),
	('03081', '68134', '11363', 'УЛ.МИХАИЛ БУБОТИНОВ'),
	('03082', '68134', '11377', 'УЛ.ПЪРВА БЪЛГАРСКА АРМИЯ'),
	('03083', '68134', '11380', 'УЛ.МАРИЧИНИ ЕЗЕРА'),
	('03084', '68134', '11394', 'УЛ.МИХАИЛ ПАНТАЛЕЕВ'),
	('03085', '68134', '11404', 'УЛ.МИХАИЛ САРАФОВ'),
	('03086', '68134', '11418', 'УЛ.КУТЛОВИЦА'),
	('03087', '68134', '11421', 'УЛ.МИХАЛАКИ ТАШЕВ'),
	('03088', '68134', '11449', 'УЛ.ЦАРЕВО'),
	('03089', '68134', '11483', 'УЛ.КОНСТАНТИН ЩЪРКЕЛОВ'),
	('03090', '68134', '11497', 'УЛ.МЛАДЕЖКА ИСКРА'),
	('03091', '68134', '11507', 'УЛ.ПЕТЪР ПАРМАКОВ'),
	('03092', '68134', '11524', 'УЛ.МЛАДОСТ'),
	('03093', '68134', '11555', 'УЛ.МОГИЛАТА'),
	('03094', '68134', '11572', 'УЛ.МОДЕСТ МУСОРГСКИ'),
	('03095', '68134', '11586', 'УЛ.МОКРЕНСКИ ПРОХОД'),
	('03096', '68134', '11599', 'УЛ.МОМИНА БАНЯ'),
	('03097', '68134', '11604', 'УЛ.МОМИНА КЛИСУРА'),
	('03098', '68134', '11613', 'УЛ.МОМИНА СКАЛА'),
	('03099', '68134', '11661', 'УЛ.МОМКОВА БАНЯ'),
	('03100', '68134', '11675', 'УЛ.МОМКОВО'),
	('03101', '68134', '11692', 'УЛ.МОСКОВСКА'),
	('03102', '68134', '11702', 'УЛ.МРАМОР'),
	('03103', '68134', '11720', 'УЛ.МУКДЕН'),
	('03104', '68134', '11733', 'УЛ.МУР'),
	('03105', '68134', '11747', 'УЛ.МУРГАШ'),
	('03106', '68134', '11750', 'УЛ.МУСАЛА'),
	('03107', '68134', '11764', 'УЛ.МЪГЛИЖ'),
	('03108', '68134', '11778', 'УЛ.МЪДРЕН'),
	('03109', '68134', '11781', 'УЛ.МЪРФИ'),
	('03110', '68134', '11795', 'УЛ.НАДЕЖДА'),
	('03111', '68134', '11805', 'УЛ.НАЙДЕН ГЕОРГИЕВ'),
	('03112', '68134', '11819', 'УЛ.НАЙДЕН ГЕРОВ'),
	('03113', '68134', '11836', 'БУЛ.ТОДОР АЛЕКСАНДРОВ'),
	('03114', '68134', '11853', 'УЛ.НАРОДЕН ГЕРОЙ'),
	('03115', '68134', '11867', 'УЛ.НАРОДЕН ПЕВЕЦ'),
	('03116', '68134', '11870', 'УЛ.ЧУДОМИР'),
	('03117', '68134', '11884', 'УЛ.ХРИСТО ОГНЯНОВ'),
	('03118', '68134', '11898', 'УЛ.БОРИС САРАФОВ'),
	('03119', '68134', '11908', 'УЛ.ВОЙВОДА'),
	('03120', '68134', '11925', 'УЛ.ЛЮЛИНСКИ ПЪТ'),
	('03121', '68134', '11939', 'УЛ.НАРОДНО ХОРО'),
	('03122', '68134', '11942', 'УЛ.НАРОДОВОЛЕЦ'),
	('03123', '68134', '12022', 'УЛ.НЕВЕСТИНА СКАЛА'),
	('03124', '68134', '12042', 'УЛ.НЕЗАБРАВКА'),
	('03125', '68134', '12053', 'УЛ.НЕЗНАЕН ВОИН'),
	('03126', '68134', '12067', 'УЛ.НЕКТАР'),
	('03127', '68134', '12070', 'УЛ.НЕМИРОВИЧ ДАНЧЕНКО'),
	('03128', '68134', '12084', 'УЛ.НЕОФИТ БОЗВЕЛИ'),
	('03129', '68134', '12098', 'УЛ.НЕОФИТ РИЛСКИ'),
	('03130', '68134', '12108', 'УЛ.НЕРАЗДЕЛНИ'),
	('03131', '68134', '12111', 'УЛ.НЕСЕБЪР'),
	('03132', '68134', '12125', 'УЛ.НЕШКОВО'),
	('03133', '68134', '12139', 'УЛ.НЕШО БОНЧЕВ'),
	('03134', '68134', '12168', 'УЛ.БУНАЯ'),
	('03135', '68134', '12173', 'УЛ.НИКОЛА ВАСИЛЕВ'),
	('03136', '68134', '12187', 'УЛ.НИКОЛА ВОЙНОВСКИ'),
	('03137', '68134', '12190', 'УЛ.НИКОЛА ГАБРОВСКИ'),
	('03138', '68134', '12200', 'УЛ.НИКОЛА ГРАМОВСКИ'),
	('03139', '68134', '12214', 'УЛ.ЛУИ АЙЕР'),
	('03140', '68134', '12228', 'УЛ.НИКОЛА КАРАДЖОВ'),
	('03141', '68134', '12231', 'УЛ.НИКОЛА КОЗЛЕВ'),
	('03142', '68134', '12245', 'УЛ.НИКОЛА МИРЧЕВ'),
	('03143', '68134', '12293', 'УЛ.БОЖЕНЦИ'),
	('03144', '68134', '12303', 'УЛ.ЖЕРАВНА'),
	('03145', '68134', '12348', 'УЛ.НИКОЛА СЛАВКОВ'),
	('03146', '68134', '12351', 'УЛ.НОВ ДЕН'),
	('03147', '68134', '12379', 'УЛ.ЦАРИБРОДСКА'),
	('03148', '68134', '12382', 'УЛ.НИКОЛАЙ В.ГОГОЛ'),
	('03149', '68134', '12396', 'УЛ.НИКОЛАЙ КОПЕРНИК'),
	('03150', '68134', '12406', 'УЛ.НИКОЛАЙ ОСТРОВСКИ'),
	('03151', '68134', '12414', 'УЛ.НИКОЛАЙ ПАВЛОВИЧ'),
	('03152', '68134', '12423', 'УЛ.ГОРСКА ТЕМЕНУГА'),
	('03153', '68134', '12440', 'УЛ.НИКОЛАЙ РАКИТИН'),
	('03154', '68134', '12454', 'УЛ.НИКОЛАЙ ХРЕЛКОВ'),
	('03155', '68134', '12471', 'УЛ.НОВАКОВСКА БИТКА'),
	('03156', '68134', '12499', 'УЛ.НОВ ГРАДЕЦ'),
	('03157', '68134', '12509', 'УЛ.НОВ ЖИВОТ'),
	('03158', '68134', '12512', 'УЛ.ОБЕДИНЕНИЕ'),
	('03159', '68134', '12526', 'УЛ.ОБЕЛСКО ШОСЕ'),
	('03160', '68134', '12530', 'УЛ.ОБЕЛЯ'),
	('03161', '68134', '12543', 'УЛ.ЙОСИФ ОБЕРБАУЕР'),
	('03162', '68134', '12557', 'УЛ.ОБЗОР'),
	('03163', '68134', '12560', 'УЛ.ОБОРИЩЕ'),
	('03164', '68134', '12588', 'УЛ.ОВЧАРСКА'),
	('03165', '68134', '12601', 'УЛ.ОГНЕБОРЕЦ'),
	('03166', '68134', '12615', 'УЛ.ОГОСТА'),
	('03167', '68134', '12629', 'УЛ.ОГРАЖДЕН'),
	('03168', '68134', '12632', 'УЛ.ОДЕСА'),
	('03169', '68134', '12646', 'УЛ.ОДРИН'),
	('03170', '68134', '12655', 'УЛ.ОКОЛОВРЪСТЕН ПЪТ'),
	('03171', '68134', '12663', 'УЛ.ОКОЛЧИЦА'),
	('03172', '68134', '12677', 'УЛ.ПЕРУНИКА'),
	('03173', '68134', '12680', 'УЛ.ОМАЙНИЧЕ'),
	('03174', '68134', '12704', 'УЛ.ОПЪЛЧЕНСКА'),
	('03175', '68134', '12718', 'УЛ.ОРАЧ'),
	('03176', '68134', '12721', 'УЛ.ОРЕЛ'),
	('03177', '68134', '12735', 'УЛ.ОРЕХОВСКИ ДОЛ'),
	('03178', '68134', '12749', 'УЛ.ОРЕШАРСКА'),
	('03179', '68134', '12752', 'УЛ.ОРИОН'),
	('03180', '68134', '12766', 'УЛ.ОРЛИЦА'),
	('03181', '68134', '12770', 'УЛ.ОРЛОВО ГНЕЗДО'),
	('03182', '68134', '12797', 'УЛ.ОРФАНО'),
	('03183', '68134', '12807', 'УЛ.ОРФЕЙ'),
	('03184', '68134', '12810', 'УЛ.ОРЧО ВОЙВОДА'),
	('03185', '68134', '12838', 'УЛ.ОСВОБОЖДЕНИЕ'),
	('03186', '68134', '12841', 'УЛ.ОСМИ МАРТ'),
	('03187', '68134', '12855', 'УЛ.ОСТРЕЦ'),
	('03188', '68134', '12869', 'УЛ.ОСТРОВА'),
	('03189', '68134', '12872', 'УЛ.ОСТРУШКА'),
	('03190', '68134', '12886', 'УЛ.ОТДИХ'),
	('03191', '68134', '12896', 'УЛ.ОТЕЦ ПАИСИЙ'),
	('03192', '68134', '12901', 'УЛ.ОТЕЧЕСТВО'),
	('03193', '68134', '12913', 'УЛ.ГЕОРГИ ПАПАНЧЕВ'),
	('03194', '68134', '12927', 'УЛ.АРХИЕПИСКОП ПРОХОР ОХРИДСКИ'),
	('03195', '68134', '12930', 'УЛ.ОХРИДСКО ЕЗЕРО'),
	('03196', '68134', '12944', 'УЛ.ПАВЕЛ БОБЕКОВ'),
	('03197', '68134', '12961', 'УЛ.ПОЛК.ВЛАДИМИР СЕРАФИМОВ'),
	('03198', '68134', '12975', 'УЛ.КАЛИНА МАЛИНА'),
	('03199', '68134', '12989', 'УЛ.ПОПЧЕВО'),
	('03200', '68134', '12992', 'УЛ.ГЕОРГИ СТАМАТОВ'),
	('03201', '68134', '13007', 'УЛ.ПАВИТ'),
	('03202', '68134', '13024', 'УЛ.ХАН ПАГАН'),
	('03203', '68134', '13041', 'УЛ.ПАЛМА'),
	('03204', '68134', '13055', 'УЛ.ПАНАГЮРИЩЕ'),
	('03205', '68134', '13069', 'УЛ.ПАНАЙОТ ВОЛОВ'),
	('03206', '68134', '13086', 'УЛ.ПАНАЙОТ ХИТОВ'),
	('03207', '68134', '13093', 'УЛ.ПАНЕГА'),
	('03208', '68134', '13113', 'УЛ.ПАНОРАМЕН ПЪТ'),
	('03209', '68134', '13127', 'УЛ.ПАНЧЕРИЦА'),
	('03210', '68134', '13144', 'УЛ.ЕЛОВ ДОЛ'),
	('03211', '68134', '13158', 'УЛ.ПАРИЖ'),
	('03212', '68134', '13161', 'УЛ.ПАРИЖКА КОМУНА'),
	('03213', '68134', '13175', 'УЛ.КОНСТАНТИН БОДИН'),
	('03214', '68134', '13189', 'УЛ.АНДРЕЙ ПРОТИЧ'),
	('03215', '68134', '13192', 'УЛ.ПОП ХАРИТОН'),
	('03216', '68134', '13216', 'УЛ.МЕЛОДИЯ'),
	('03217', '68134', '13233', 'УЛ.ЛАЗАРОПОЛЕ'),
	('03218', '68134', '13247', 'УЛ.РОЖДЕСТВО'),
	('03219', '68134', '13278', 'УЛ.ПАСАРЕЛСКИ ЯЗОВИР'),
	('03220', '68134', '13281', 'УЛ.СЪРНЕЛА'),
	('03221', '68134', '13295', 'УЛ.ПАСКАЛ ТОДОРОВ'),
	('03222', '68134', '13305', 'УЛ.ПАСТИРНА'),
	('03223', '68134', '13322', 'УЛ.ПАТЛЕЙНА'),
	('03224', '68134', '13336', 'УЛ.ПАТРИОТ'),
	('03225', '68134', '13340', 'УЛ.ФРАНСИС ДЕ ПРЕСАНСЕ'),
	('03226', '68134', '13353', 'УЛ.ЧЕРКОВНА'),
	('03227', '68134', '13367', 'УЛ.ПАЯК ПЛАНИНА'),
	('03228', '68134', '13370', 'УЛ.ПЕЛИСТЕР'),
	('03229', '68134', '13384', 'УЛ.ПЕЛОВРАГ'),
	('03230', '68134', '13398', 'УЛ.ОСОГОВО'),
	('03231', '68134', '13411', 'УЛ.ПЕРЕ ТОШЕВ'),
	('03232', '68134', '13439', 'УЛ.ПЕРНИК'),
	('03233', '68134', '13442', 'УЛ.ПЕРСЕНК'),
	('03234', '68134', '13487', 'УЛ.ПЕТКО ВОЙВОДА'),
	('03235', '68134', '13490', 'УЛ.ПЕТКО Д.ПЕТКОВ'),
	('03236', '68134', '13500', 'УЛ.ЗАБЪРДЕ'),
	('03237', '68134', '13514', 'УЛ.ПЕТ МОГИЛИ'),
	('03238', '68134', '13528', 'УЛ.ПЛАНИНАРСКА ПЕСЕН'),
	('03239', '68134', '13531', 'УЛ.ПЕТРА'),
	('03240', '68134', '13545', 'УЛ.ПЕТРОХАН'),
	('03241', '68134', '13559', 'УЛ.ПЕТЪР БОНЕВ'),
	('03242', '68134', '13576', 'УЛ.ПЕТЪР БОГДАН'),
	('03243', '68134', '13580', 'УЛ.ТУЛЧА'),
	('03244', '68134', '13593', 'УЛ.ПЕТЪР Б.ВЕЛИЧКОВ'),
	('03245', '68134', '13620', 'УЛ.ПЕТЪР ДЕЛЯН'),
	('03246', '68134', '13634', 'УЛ.КИРИЛ ПЪРЛИЧЕВ'),
	('03247', '68134', '13648', 'УЛ.ПЕТЪР МИТОВ'),
	('03248', '68134', '13651', 'УЛ.ПЕТЪР МИХАЙЛОВ'),
	('03249', '68134', '13682', 'УЛ.ПЕТЪР ПАРЧЕВИЧ'),
	('03250', '68134', '13696', 'УЛ.ПРОФ.АЛЕКСАНДЪР СТАНИШЕВ'),
	('03251', '68134', '13706', 'УЛ.ПЕТЪР СТАНЧЕВ'),
	('03252', '68134', '13711', 'УЛ.МАЛА ПЛАНИНА'),
	('03253', '68134', '13723', 'УЛ.ВЕЛИКДЕН'),
	('03254', '68134', '13737', 'УЛ.ВИХРЕН'),
	('03255', '68134', '13740', 'УЛ.ЯНКО ЗАБУНОВ'),
	('03256', '68134', '13754', 'УЛ.МОРАВЧА'),
	('03257', '68134', '13768', 'УЛ.ПЕХЧЕВО'),
	('03258', '68134', '13771', 'УЛ.ПЕЩЕРА'),
	('03259', '68134', '13785', 'УЛ.ПИЕР ДЕГЕЙТЪР'),
	('03260', '68134', '13799', 'УЛ.МОНТЕВИДЕО'),
	('03261', '68134', '13809', 'УЛ.ПИРИН'),
	('03262', '68134', '13812', 'УЛ.ПИРИНСКИ ИЗВОР'),
	('03263', '68134', '13826', 'УЛ.ПИРИНСКИ ПРОХОД'),
	('03264', '68134', '13843', 'УЛ.ПЛАКАЛНИЦА'),
	('03265', '68134', '13857', 'УЛ.ПЛАНА ПЛАНИНА'),
	('03266', '68134', '13860', 'УЛ.ПЛАНЕТА'),
	('03267', '68134', '13874', 'УЛ.ПЛАНИНЕЦ'),
	('03268', '68134', '13888', 'УЛ.ПЛАНИНИЦА'),
	('03269', '68134', '13891', 'УЛ.ПЛАНИНСКО ЦВЕТЕ'),
	('03270', '68134', '13901', 'УЛ.ПЛАЧКОВИЦА'),
	('03271', '68134', '13915', 'УЛ.ПЛАЧКОВСКИ МАНАСТИР'),
	('03272', '68134', '13929', 'УЛ.ПЛЕВЕН'),
	('03273', '68134', '13932', 'УЛ.ПЛОВДИВ'),
	('03274', '68134', '13946', 'УЛ.ПЛОВДИВСКО ПОЛЕ'),
	('03275', '68134', '13952', 'УЛ.ПОБЕДА'),
	('03276', '68134', '13963', 'УЛ.ПОГАНОВСКИ МАНАСТИР'),
	('03277', '68134', '13977', 'УЛ.ПОГЛЕД'),
	('03278', '68134', '13994', 'УЛ.ПОДЕМ'),
	('03279', '68134', '14009', 'УЛ.ПОДГРАМАДА'),
	('03280', '68134', '14012', 'УЛ.ПОДКРЕПА'),
	('03281', '68134', '14026', 'УЛ.ПОДЛОЗИЩЕ'),
	('03282', '68134', '14034', 'УЛ.ПОДНОЖИЕ'),
	('03283', '68134', '14043', 'УЛ.ПОДПОЛКОВНИК КАЛИТИН'),
	('03284', '68134', '14057', 'УЛ.ПОДПОРУЧИК ФУТЕКОВ'),
	('03285', '68134', '14060', 'УЛ.ПОДУЕВО'),
	('03286', '68134', '14074', 'УЛ.ПОДУЕНСКА'),
	('03287', '68134', '14088', 'УЛ.ПОЗИТАНО'),
	('03288', '68134', '14091', 'УЛ.ПОИБРЕНЕ'),
	('03289', '68134', '14115', 'УЛ.ПОЛК.НИКОЛА ПОПОВ'),
	('03290', '68134', '14129', 'УЛ.ЙОРДАН ХАДЖИКОНСТАНТИНОВ'),
	('03291', '68134', '14132', 'УЛ.ПОЛК.АНТОН КРЪСТЕВ'),
	('03292', '68134', '14146', 'УЛ.ПОЛСКИ ВЕНЕЦ'),
	('03293', '68134', '14150', 'УЛ.ПОЛСКО ЦВЕТЕ'),
	('03294', '68134', '14177', 'УЛ.КУЗМАН ШАПКАРЕВ'),
	('03295', '68134', '14180', 'УЛ.ПОП БОГОМИЛ'),
	('03296', '68134', '14194', 'УЛ.ПОП ГРУЮ'),
	('03297', '68134', '14218', 'УЛ.ПОПОВО'),
	('03298', '68134', '14221', 'УЛ.ПОРДИМ'),
	('03299', '68134', '14249', 'УЛ.ПОРТО ЛАГОС'),
	('03300', '68134', '14252', 'УЛ.ПОРУЧИК ОРОЗОВ'),
	('03301', '68134', '14266', 'УЛ.ПОРУЧИК ПАЧЕВ'),
	('03302', '68134', '14275', 'УЛ.ПРОФ.Д-Р Г.ПАВЛОВ'),
	('03303', '68134', '14283', 'УЛ.ПОЛК.БОРИС ДРАНГОВ'),
	('03304', '68134', '14297', 'УЛ.ПОТОЧЕ'),
	('03305', '68134', '14307', 'УЛ.ПОЩЕНСКА'),
	('03306', '68134', '14310', 'УЛ.ПОП ЕВСТАТИ ВИТОШКИ'),
	('03307', '68134', '14324', 'УЛ.ПРОФ.Д-Р ДИМ.АТАНАСОВ'),
	('03308', '68134', '14338', 'УЛ.ПРЕДЕЛ'),
	('03309', '68134', '14341', 'УЛ.ПРЕЗВИТЕР КОЗМА'),
	('03310', '68134', '14355', 'УЛ.ПРЕОБРАЖЕНСКО ВЪСТАНИЕ'),
	('03311', '68134', '14369', 'УЛ.ПРЕПОЛАЦ'),
	('03312', '68134', '14372', 'УЛ.ПРЕСЛАВ'),
	('03313', '68134', '14390', 'УЛ.ПРЕСПА'),
	('03314', '68134', '14413', 'УЛ.ПРИБОЙНИЦА'),
	('03315', '68134', '14430', 'УЛ.ПРИРОДА'),
	('03316', '68134', '14444', 'УЛ.ПРОБУДА'),
	('03317', '68134', '14458', 'УЛ.ПРОМИШЛЕНА'),
	('03318', '68134', '14461', 'УЛ.ПРОСВЕТА'),
	('03319', '68134', '14475', 'УЛ.ПРОФ.АНТОН МИТОВ'),
	('03320', '68134', '14489', 'УЛ.ПРОФ.АСЕН ЗЛАТАРОВ'),
	('03321', '68134', '14492', 'УЛ.ПРОФ.АТАНАС ИШИРКОВ'),
	('03322', '68134', '14502', 'УЛ.ПРОФ.БЕНЬО ЦОНЕВ'),
	('03323', '68134', '14516', 'УЛ.ПРОФ.ВАЙГАНД'),
	('03324', '68134', '14521', 'УЛ.ПРОФ.ДЖОВАНИ ГОРИНИ'),
	('03325', '68134', '14533', 'УЛ.ПРОФ.ИВАН ШИШМАНОВ'),
	('03326', '68134', '14550', 'УЛ.ПРОФ.НИКОЛАЙ ДЕРЖАВИН'),
	('03327', '68134', '14564', 'УЛ.ПРОФ.ФРИТЬОФ НАНСЕН'),
	('03328', '68134', '14578', 'УЛ.ПРОФ.ХРИСТО ВАКАРЕЛСКИ'),
	('03329', '68134', '14581', 'УЛ.ПРОХЛАДА'),
	('03330', '68134', '14605', 'УЛ.ПЧЕЛА'),
	('03331', '68134', '14619', 'УЛ.ПЧИНЯ'),
	('03332', '68134', '14622', 'УЛ.ПЪРВЕНЕЦ'),
	('03333', '68134', '14653', 'УЛ.ИВАН МОМЧИЛОВ'),
	('03334', '68134', '14667', 'УЛ.АДАМ МИЦКЕВИЧ'),
	('03335', '68134', '14684', 'УЛ.ПРОФ.ГЕОРГИ БРАДИСТИЛОВ'),
	('03336', '68134', '14698', 'УЛ.РАДИН ДОЛ'),
	('03337', '68134', '14711', 'УЛ.РАДИЧЕВЦИ'),
	('03338', '68134', '14756', 'УЛ.РАЗВИГОР'),
	('03339', '68134', '14762', 'УЛ.РАЗГРАД'),
	('03340', '68134', '14773', 'УЛ.РАЗЛИВО'),
	('03341', '68134', '14787', 'УЛ.РАЗЛОГ'),
	('03342', '68134', '14790', 'УЛ.ТОМА ДАВИДОВ (РАЗ.ЦЕЛИНА)'),
	('03343', '68134', '14800', 'УЛ.РАЗСЛАТИЦА'),
	('03344', '68134', '14828', 'УЛ.РАЙКО ЖИНЗИФОВ'),
	('03345', '68134', '14831', 'УЛ.РАЙЛЬОВСКО ГРАДИЩЕ'),
	('03346', '68134', '14845', 'УЛ.ДОБРИ ЧИНТУЛОВ'),
	('03347', '68134', '14859', 'УЛ.РАЙНА КНЯГИНЯ'),
	('03348', '68134', '14862', 'УЛ.РАЙНО ПОПОВИЧ'),
	('03349', '68134', '14876', 'УЛ.РАКИТА'),
	('03350', '68134', '14893', 'УЛ.РАЛИЦА'),
	('03351', '68134', '14903', 'УЛ.МАРКО ЛЕРИНСКИ'),
	('03352', '68134', '14917', 'УЛ.НИКОЛАЙ РАЙНОВ'),
	('03353', '68134', '14920', 'УЛ.РАЧКА'),
	('03354', '68134', '14934', 'УЛ.РАЧО ДИМЧЕВ'),
	('03355', '68134', '14951', 'УЛ.РЕЗБАРСКА'),
	('03356', '68134', '14965', 'УЛ.РЕЗНЬОВЕТЕ (Р-Н ВИТОША)'),
	('03357', '68134', '14979', 'УЛ.РАВЕН'),
	('03358', '68134', '15014', 'УЛ.РЕКА ОСЪМ'),
	('03359', '68134', '15028', 'УЛ.ХАДЖИ МАНО СТОЯНОВ'),
	('03360', '68134', '15031', 'УЛ.РЕПУБЛИКА'),
	('03361', '68134', '15059', 'УЛ.РИБАРИЦА'),
	('03362', '68134', '15062', 'УЛ.РИБЕН БУКВАР'),
	('03363', '68134', '15103', 'УЛ.РИЖКИ ПРОХОД'),
	('03364', '68134', '15117', 'УЛ.РИЛСКА ОБИТЕЛ'),
	('03365', '68134', '15120', 'УЛ.РИЛСКИ ЕЗЕРА'),
	('03366', '68134', '15134', 'УЛ.ПЛАДНИЩЕ'),
	('03367', '68134', '15148', 'УЛ.РОГЛЕЦ'),
	('03368', '68134', '15151', 'УЛ.РОДЕН КЪТ'),
	('03369', '68134', '15165', 'УЛ.РОДИНА'),
	('03370', '68134', '15196', 'УЛ.РОДОПИ'),
	('03371', '68134', '15206', 'УЛ.РОДОПСКИ ИЗВОР'),
	('03372', '68134', '15216', 'УЛ.РОДОСТО'),
	('03373', '68134', '15237', 'УЛ.РОЖЕНСКИ ПРОХОД'),
	('03374', '68134', '15240', 'УЛ.РОЗА'),
	('03375', '68134', '15254', 'УЛ.РОЗАРИУМ'),
	('03376', '68134', '15268', 'УЛ.РОЗОВА ДОЛИНА'),
	('03377', '68134', '15299', 'УЛ.РОСЕН'),
	('03378', '68134', '15309', 'УЛ.РОСИЦА'),
	('03379', '68134', '15312', 'УЛ.РОСНА КИТКА'),
	('03380', '68134', '15326', 'УЛ.РОСНА КИТКА'),
	('03381', '68134', '15331', 'УЛ.РОСТОВ'),
	('03382', '68134', '15343', 'УЛ.РУДАРКА'),
	('03383', '68134', '15357', 'УЛ.РУДОЗЕМ'),
	('03384', '68134', '15360', 'УЛ.РУЕН'),
	('03385', '68134', '15388', 'УЛ.РУЙ ПЛАНИНА'),
	('03386', '68134', '15391', 'УЛ.РУМЕН ВОЙВОДА'),
	('03387', '68134', '15415', 'УЛ.РУМЯНА ВОЙВОДА'),
	('03388', '68134', '15429', 'УЛ.РУСАЛКА'),
	('03389', '68134', '15432', 'УЛ.РУСАЛИЙСКИ ПРОХОД'),
	('03390', '68134', '15446', 'УЛ.РУСАЛСКИ ЛЪК'),
	('03391', '68134', '15457', 'УЛ.РУСАЛЯ'),
	('03392', '68134', '15463', 'УЛ.РУСЕ'),
	('03393', '68134', '15494', 'УЛ.САВА МИХАЙЛОВ'),
	('03394', '68134', '15504', 'УЛ.САВА ОГНЯНОВ'),
	('03395', '68134', '15518', 'УЛ.САВА РАДУЛОВ'),
	('03396', '68134', '15521', 'УЛ.САВА ЦОНЕВ'),
	('03397', '68134', '15549', 'УЛ.ДОНЧО ВАТАХ'),
	('03398', '68134', '15552', 'УЛ.САМОДИВСКО ИЗВОРЧЕ'),
	('03399', '68134', '15572', 'УЛ.САМОКОВ'),
	('03400', '68134', '15583', 'УЛ.СВЕТА ПЕТКА ТЪРНОВСКА'),
	('03401', '68134', '15607', 'УЛ.САМУИЛЕЦ'),
	('03402', '68134', '15610', 'УЛ.САН СТЕФАНО'),
	('03403', '68134', '15624', 'УЛ.САПУНДЖИЙСКА'),
	('03404', '68134', '15638', 'УЛ.САРАНЦИ'),
	('03405', '68134', '15641', 'УЛ.ЛЯСТОВИЦА'),
	('03406', '68134', '15655', 'УЛ.КИРИЛ ДРАНГОВ'),
	('03407', '68134', '15672', 'УЛ.СВЕТА ГОРА'),
	('03408', '68134', '15686', 'УЛ.СВЕТА СОФИЯ'),
	('03409', '68134', '15698', 'УЛ.СВЕТЛА'),
	('03410', '68134', '15713', 'УЛ.ПОЛК.ВАСИЛ ЗЛАТАРЕВ'),
	('03411', '68134', '15730', 'УЛ.СВЕТОСЛАВ ОБРЕТЕНОВ'),
	('03412', '68134', '15744', 'УЛ.СВЕТОСЛАВ ТЕРТЕР'),
	('03413', '68134', '15761', 'УЛ.СВИЛЕНИЦА'),
	('03414', '68134', '15775', 'УЛ.БОЯН МАГЕСНИК'),
	('03415', '68134', '15789', 'УЛ.СВОБОДА'),
	('03416', '68134', '15792', 'УЛ.СВОБОДНА'),
	('03417', '68134', '15802', 'УЛ.СВОГЕ'),
	('03418', '68134', '15816', 'УЛ.СВЪРЗОЧНИК'),
	('03419', '68134', '15829', 'УЛ.СГОВОРНА ДРУЖИНА'),
	('03420', '68134', '15850', 'УЛ.СТЕФАН ДУНЬОВ'),
	('03421', '68134', '15864', 'УЛ.СВЕТИ СВ.СЕДМОЧИСЛЕНИЦИ'),
	('03422', '68134', '15878', 'УЛ.СЕДЯНКА'),
	('03423', '68134', '15881', 'УЛ.СЕКВОЯ'),
	('03424', '68134', '15895', 'УЛ.ДЕТЕЛИНА'),
	('03425', '68134', '15905', 'УЛ.СЕЛИМИЦА'),
	('03426', '68134', '15919', 'УЛ.ФИДАНКА'),
	('03427', '68134', '15922', 'УЛ.СЕЛИЩЕ'),
	('03428', '68134', '15953', 'УЛ.КЕШАН'),
	('03429', '68134', '15967', 'УЛ.МАРА БЕЛЧЕВА'),
	('03430', '68134', '15970', 'УЛ.МИТРОПОЛИТ АВКСЕНТИЙ ВЕЛЕШК'),
	('03431', '68134', '15984', 'УЛ.РОМАН'),
	('03432', '68134', '15998', 'УЛ.СЕРГЕЙ РУМЯНЦЕВ'),
	('03433', '68134', '16002', 'УЛ.СЕРДИКА'),
	('03434', '68134', '16033', 'УЛ.СИЛИВРИЯ'),
	('03435', '68134', '16047', 'УЛ.СИЛИСТРА'),
	('03436', '68134', '16078', 'УЛ.МАРАГИДИК'),
	('03437', '68134', '16081', 'УЛ.СИМЕОНОВ ВЕК'),
	('03438', '68134', '16095', 'УЛ.СИМЕОНОВО'),
	('03439', '68134', '16119', 'УЛ.АНАСТАС ЛОЗАНЧЕВ'),
	('03440', '68134', '16122', 'УЛ.СИНИ ВИР'),
	('03441', '68134', '16136', 'УЛ.СИНИТЕ КАМЪНИ'),
	('03442', '68134', '16141', 'УЛ.СИНЧЕЦ'),
	('03443', '68134', '16153', 'УЛ.СИНЬО ЕЗЕРО'),
	('03444', '68134', '16167', 'УЛ.СИНЯТА СКАЛА'),
	('03445', '68134', '16198', 'УЛ.СИРМА ВОЙВОДА'),
	('03446', '68134', '16211', 'УЛ.СКАЙЛЕР'),
	('03447', '68134', '16225', 'УЛ.СКАКАВИЦА'),
	('03448', '68134', '16239', 'УЛ.СКОПИЕ'),
	('03449', '68134', '16256', 'УЛ.СЛАВА'),
	('03450', '68134', '16267', 'УЛ.СЛАВИЩЕ'),
	('03451', '68134', '16273', 'УЛ.СЛАВОВИЦА'),
	('03452', '68134', '16287', 'УЛ.СЛАВЯНКА'),
	('03453', '68134', '16290', 'УЛ.СЛАВЯНСКА'),
	('03454', '68134', '16300', 'УЛ.СЛАТИНСКА РЕКА'),
	('03455', '68134', '16328', 'УЛ.СЛИВЕН'),
	('03456', '68134', '16345', 'УЛ.ЧУДОТВОРЦИ'),
	('03457', '68134', '16359', 'УЛ.СМИЛИЦА'),
	('03458', '68134', '16376', 'УЛ.СМОЛЯНСКА'),
	('03459', '68134', '16382', 'УЛ.СМРИКА'),
	('03460', '68134', '16393', 'УЛ.СМЪРЧ'),
	('03461', '68134', '16403', 'УЛ.СНЕЖНИК'),
	('03462', '68134', '16420', 'УЛ.СОЛЕНИЦИТЕ'),
	('03463', '68134', '16434', 'УЛ.СОЛУН'),
	('03464', '68134', '16448', 'УЛ.СОПОТ'),
	('03465', '68134', '16451', 'УЛ.СОТИР АНДОНОВ'),
	('03466', '68134', '16479', 'УЛ.СОФИЙСКА ПАНОРАМА'),
	('03467', '68134', '16482', 'УЛ.СОФИЙСКИ ГЕРОЙ'),
	('03468', '68134', '16496', 'УЛ.СОФИЙСКО ПОЛЕ'),
	('03469', '68134', '16506', 'УЛ.СОФИЯ'),
	('03470', '68134', '16513', 'УЛ.СОФРОНИЙ ВРАЧАНСКИ'),
	('03471', '68134', '16523', 'УЛ.МАРА БУНЕВА'),
	('03472', '68134', '16537', 'УЛ.СПАС ВАЦОВ'),
	('03473', '68134', '16554', 'УЛ.СТАР БЕЛОВОДСКИ ПЪТ'),
	('03474', '68134', '16568', 'УЛ.СПЪТНИК'),
	('03475', '68134', '16571', 'УЛ.СРЕДНА ГОРА'),
	('03476', '68134', '16585', 'УЛ.СРЕДОРЕК'),
	('03477', '68134', '16609', 'УЛ.СТАНИСЛАВ ДОСПЕВСКИ'),
	('03478', '68134', '16612', 'УЛ.ПОПОВА ШАПКА'),
	('03479', '68134', '16626', 'УЛ.ОХРИД'),
	('03480', '68134', '16660', 'УЛ.СТАРА ПЛАНИНА'),
	('03481', '68134', '16674', 'УЛ.СТАРА СТЕНА'),
	('03482', '68134', '16688', 'УЛ.БЕЛОВОДСКИ ПЪТ'),
	('03483', '68134', '16715', 'УЛ.СТАРОСЕЛСКА'),
	('03484', '68134', '16729', 'УЛ.БЪДНИК'),
	('03485', '68134', '16746', 'УЛ.СТЕФАН БОГОРИДИ'),
	('03486', '68134', '16763', 'УЛ.РОЯК'),
	('03487', '68134', '16777', 'УЛ.ОТЕЦ МИХАЛ'),
	('03488', '68134', '16780', 'УЛ.СТЕФАН КАРАДЖА'),
	('03489', '68134', '16794', 'УЛ.СТЕФАН КИРОВ'),
	('03490', '68134', '16804', 'УЛ.СТЕФАН МАЛИНОВ'),
	('03491', '68134', '16818', 'УЛ.КОРЕНЯЦИТЕ'),
	('03492', '68134', '16835', 'УЛ.СТЕФАНСОН'),
	('03493', '68134', '16849', 'УЛ.СТОИЛ ВОЙВОДА'),
	('03494', '68134', '16866', 'УЛ.СТОИЛ ФИНДЖЕКОВ'),
	('03495', '68134', '16883', 'УЛ.СТОЛЕТНИК'),
	('03496', '68134', '16907', 'УЛ.СТОЯН ЗАИМОВ'),
	('03497', '68134', '16924', 'УЛ.СТОЯН МИХАЙЛОВСКИ'),
	('03498', '68134', '16938', 'УЛ.СТЕФАН ПЕШЕВ'),
	('03499', '68134', '16941', 'УЛ.ДАСКАЛ СТОЯН ПОПАНДРЕЕВ'),
	('03500', '68134', '16955', 'УЛ.СТОЯН ПОПОВ'),
	('03501', '68134', '16969', 'УЛ.СТОЯН СТОИМЕНОВ'),
	('03502', '68134', '16972', 'УЛ.ЕЛА'),
	('03503', '68134', '16986', 'УЛ.СТРАЖИЦА'),
	('03504', '68134', '16995', 'УЛ.СТРАНДЖА'),
	('03505', '68134', '17004', 'УЛ.СТРАХИЛ ВОЙВОДА'),
	('03506', '68134', '17018', 'УЛ.СТРАЦИН'),
	('03507', '68134', '17021', 'УЛ.СТРЕЗИМИРОВЦИ'),
	('03508', '68134', '17035', 'УЛ.СТРЕЛЧА'),
	('03509', '68134', '17049', 'УЛ.СТРЕМА'),
	('03510', '68134', '17052', 'УЛ.СТРУГА'),
	('03511', '68134', '17066', 'УЛ.СТРУМА'),
	('03512', '68134', '17077', 'УЛ.СТРУМИЦА'),
	('03513', '68134', '17083', 'УЛ.СТУДЕН КЛАДЕНЕЦ'),
	('03514', '68134', '17097', 'УЛ.СУЛИНА'),
	('03515', '68134', '17107', 'УЛ.СУЛТАН ТЕПЕ'),
	('03516', '68134', '17110', 'УЛ.СУХИНДОЛ'),
	('03517', '68134', '17124', 'УЛ.СУХОДОЛ'),
	('03518', '68134', '17138', 'УЛ.СУХОДОЛСКА'),
	('03519', '68134', '17141', 'УЛ.АНДРЕЙ НИКОЛОВ'),
	('03520', '68134', '17169', 'УЛ.СЪЕДИНЕНИЕ'),
	('03521', '68134', '17172', 'УЛ.СЪЗЛИЙКА'),
	('03522', '68134', '17186', 'УЛ.СЪЗНАНИЕ'),
	('03523', '68134', '17192', 'УЛ.ЗАРЯ'),
	('03524', '68134', '17208', 'УЛ.ТЕОДОР ТЕОДОРОВ'),
	('03525', '68134', '17227', 'УЛ.ТАЙГА'),
	('03526', '68134', '17244', 'УЛ.ГЕОРГИ ВОЙТЕХ (ТАНКИСТ)'),
	('03527', '68134', '17258', 'УЛ.ТАРАС ШЕВЧЕНКО'),
	('03528', '68134', '17261', 'УЛ.ТАТАРЛИ'),
	('03529', '68134', '17289', 'УЛ.ТВЪРДИШКИ ПРОХОД'),
	('03530', '68134', '17292', 'УЛ.НАДЕЖДА (ТЕЖКИЯ ТАНК)'),
	('03531', '68134', '17316', 'УЛ.ТЕМЕНУГА'),
	('03532', '68134', '17347', 'УЛ.СВЕТИ ТЕОДОСИЙ ТЪРНОВСКИ'),
	('03533', '68134', '17350', 'УЛ.ТЕОФИЛ ГАНЕВ'),
	('03534', '68134', '17364', 'УЛ.ТЕРЕЛИК'),
	('03535', '68134', '17378', 'УЛ.ГУРГУЛЯТ'),
	('03536', '68134', '17381', 'УЛ.ТИНТЯВА'),
	('03537', '68134', '17395', 'УЛ.ТИХИ КЪТ'),
	('03538', '68134', '17405', 'УЛ.КРАИЩЕ (ТОДОР АТАНАСОВ)'),
	('03539', '68134', '17419', 'УЛ.АНЖЕЛО РОНКАЛИ'),
	('03540', '68134', '17422', 'УЛ.ТОДОР БУРМОВ'),
	('03541', '68134', '17436', 'УЛ.ТОДОР Г.ВЛАЙКОВ'),
	('03542', '68134', '17453', 'УЛ.ТОДОР ИКОНОМОВ'),
	('03543', '68134', '17467', 'УЛ.ТОДОР КАБЛЕШКОВ'),
	('03544', '68134', '17470', 'УЛ.ТОДОР КРЪШКОВ'),
	('03545', '68134', '17498', 'УЛ.РАЙКО АЛЕКСИЕВ'),
	('03546', '68134', '17508', 'УЛ.ТОДОР СТОЯНОВ'),
	('03547', '68134', '17511', 'УЛ.ТУЛОВО'),
	('03548', '68134', '17539', 'УЛ.ТОДОРИНИ КУКЛИ'),
	('03549', '68134', '17573', 'УЛ.ТОПЛИ ДОЛ'),
	('03550', '68134', '17587', 'УЛ.ТОПЛО ИЗВОРЧЕ'),
	('03551', '68134', '17590', 'УЛ.ТОПОЛА'),
	('03552', '68134', '17600', 'УЛ.ТОПОЛНИЦА'),
	('03553', '68134', '17628', 'УЛ.ГУСЛАРИ'),
	('03554', '68134', '17631', 'УЛ.ТРАЕН МИР'),
	('03555', '68134', '17645', 'УЛ.ТРАЙКО СТАНОЕВ'),
	('03556', '68134', '17659', 'УЛ.ВАРШАВСКО ВЪСТАНИЕ'),
	('03557', '68134', '17662', 'УЛ.СВ.НАУМ'),
	('03558', '68134', '17676', 'УЛ.ТРАКИЯ(ГЕН.ХР.ЛУКОВ)'),
	('03559', '68134', '17693', 'УЛ.ТРАПЕЗИЦА'),
	('03560', '68134', '17703', 'УЛ.ТРАЯНОВА ВРАТА'),
	('03561', '68134', '17717', 'УЛ.ТРЕПЕТЛИКА'),
	('03562', '68134', '17734', 'УЛ.ТРИАДИЦА'),
	('03563', '68134', '17748', 'УЛ.ПРОФ.СТОЯН КИРКОВИЧ'),
	('03564', '68134', '17751', 'УЛ.ТРИ КЛАДЕНЦИ'),
	('03565', '68134', '17765', 'УЛ.13-ТИ МАРТ'),
	('03566', '68134', '17779', 'УЛ.РЪЖАНА (ТРИ УШИ)'),
	('03567', '68134', '17782', 'УЛ.ТРИЧКО ВЕЛЕВ'),
	('03568', '68134', '17796', 'УЛ.ТРОЯН'),
	('03569', '68134', '17806', 'УЛ.ТРОЯНСКИ ПРОХОД'),
	('03570', '68134', '17823', 'УЛ.ТРУДОЛЮБИЕ'),
	('03571', '68134', '17854', 'УЛ.ТУМБА'),
	('03572', '68134', '17868', 'УЛ.ТУНДЖА'),
	('03573', '68134', '17871', 'УЛ.ТУТРАКАН'),
	('03574', '68134', '17885', 'УЛ.ТЪРГОВСКА'),
	('03575', '68134', '17899', 'УЛ.ТЪРНОВО'),
	('03576', '68134', '17909', 'УЛ.ТИРАНА'),
	('03577', '68134', '17926', 'УЛ.УДОВО'),
	('03578', '68134', '17936', 'УЛ.УЗУНДЖОВСКА'),
	('03579', '68134', '17943', 'УЛ.ЛИПА (УЙЛЯМ ГЛАДСТОН)'),
	('03580', '68134', '17960', 'УЛ.ИВАН РАДОЕВ (УЛЯНА ГРОМОВА)'),
	('03581', '68134', '17974', 'УЛ.УНИВЕРСИТЕТСКА'),
	('03582', '68134', '17988', 'УЛ.УОШБЪРН'),
	('03583', '68134', '17991', 'УЛ.УРАЛ'),
	('03584', '68134', '18006', 'УЛ.УРВИЧ'),
	('03585', '68134', '18018', 'УЛ.УТРИННА РОСА'),
	('03586', '68134', '18037', 'УЛ.УСТА ГЕНЧО'),
	('03587', '68134', '18054', 'УЛ.УЧИЛИЩНА'),
	('03588', '68134', '18068', 'УЛ.КНЯЗ ГЕОРГИЙ ЛВОВ'),
	('03589', '68134', '18071', 'УЛ.ФЕЛИКС КАНИЦ'),
	('03590', '68134', '18085', 'УЛ.АКАД.НИКОЛА ОБРЕШКОВ'),
	('03591', '68134', '18109', 'УЛ.МАЙОР ДИМ.ДУМБАЛАКОВ'),
	('03592', '68134', '18133', 'УЛ.БОРИС ХРИСТОВ'),
	('03593', '68134', '18157', 'УЛ.ФИЛИП СТАНИСЛАВОВ'),
	('03594', '68134', '18160', 'УЛ.ФИЛИП ТОТЮ'),
	('03595', '68134', '18174', 'УЛ.ФИЛИПОВСКО ШОСЕ'),
	('03596', '68134', '18188', 'УЛ.ФОРТОВ ПЪТ'),
	('03597', '68134', '18191', 'УЛ.ЖОРЖ ДАНТОН'),
	('03598', '68134', '18201', 'УЛ.ФРУЖИН'),
	('03599', '68134', '18229', 'УЛ.ФРЕДЕРИК ЖОЛИО КЮРИ'),
	('03600', '68134', '18232', 'УЛ.ХАДЖИ ДИМИТЪР'),
	('03601', '68134', '18246', 'УЛ.ХАДЖИ ХР.ПАНКАТА'),
	('03602', '68134', '18263', 'УЛ.ХАЙДУТ ВЕЛКО'),
	('03603', '68134', '18277', 'УЛ.ХАЙДУТ СИДЕР'),
	('03604', '68134', '18280', 'УЛ.ХАЙДУШКА ГОРА'),
	('03605', '68134', '18304', 'УЛ.ХАЙДУШКА ПОЛЯНА'),
	('03606', '68134', '18318', 'УЛ.ХАЙДУШКО ИЗВОРЧЕ'),
	('03607', '68134', '18321', 'УЛ.ХАН АСПАРУХ'),
	('03608', '68134', '18335', 'УЛ.ХАН КАРДАМ'),
	('03609', '68134', '18349', 'УЛ.ХАН КРУМ'),
	('03610', '68134', '18352', 'УЛ.ХАН КУБРАТ'),
	('03611', '68134', '18366', 'УЛ.ХАН ОМУРТАГ'),
	('03612', '68134', '18374', 'УЛ.ХАНОВО'),
	('03613', '68134', '18383', 'УЛ.ХАРАЛАМПИ КАРАСТОЯНОВ'),
	('03614', '68134', '18397', 'УЛ.ХАРМАНЛИЙСКО ВЪСТАНИЕ'),
	('03615', '68134', '18407', 'УЛ.ХАСКОВО'),
	('03616', '68134', '18410', 'УЛ.ХВОЙНА'),
	('03617', '68134', '18424', 'УЛ.ХЕМУС'),
	('03618', '68134', '18438', 'УЛ.ХИЖИТЕ'),
	('03619', '68134', '18455', 'УЛ.ХИМИК'),
	('03620', '68134', '18469', 'УЛ.ХИМИТЛИЙСКИ ПРОХОД'),
	('03621', '68134', '18472', 'УЛ.ХИСАРЯ'),
	('03622', '68134', '18490', 'УЛ.ХМЕЛНИЦА'),
	('03623', '68134', '18530', 'УЛ.ХРИЗАНТЕМА'),
	('03624', '68134', '18544', 'УЛ.ХРИСТАКИ ПАВЛОВИЧ'),
	('03625', '68134', '18561', 'УЛ.ЛИСЕЦ'),
	('03626', '68134', '18575', 'УЛ.ХРИСТО БЛАГОЕВ'),
	('03627', '68134', '18589', 'УЛ.ХРИСТО ГАНЧЕВ'),
	('03628', '68134', '18633', 'УЛ.ХРИСТО КОВАЧЕВ'),
	('03629', '68134', '18647', 'УЛ.СИРАК СКИТНИК'),
	('03630', '68134', '18650', 'УЛ.ХРИСТО МАКСИМОВ'),
	('03631', '68134', '18664', 'УЛ.ЛАЗАР МИХАЙЛОВ'),
	('03632', '68134', '18681', 'УЛ.ЖАК ДЮКЛО'),
	('03633', '68134', '18695', 'УЛ.КАМЕЛИЯ'),
	('03634', '68134', '18719', 'УЛ.ХРИСТО ПАТРЕВ'),
	('03635', '68134', '18722', 'УЛ.ХРИСТО СТАНЧЕВ'),
	('03636', '68134', '18746', 'УЛ.ХРИСТО ТРАЙКОВ'),
	('03637', '68134', '18753', 'УЛ.ХРИСТО ХАЛАЧЕВ'),
	('03638', '68134', '18770', 'УЛ.ХРИСТО ЦЕНОВ'),
	('03639', '68134', '18784', 'УЛ.ХРИСТО ЧЕРНОПЕЕВ'),
	('03640', '68134', '18798', 'УЛ.ХУБАВКА'),
	('03641', '68134', '18808', 'УЛ.ХУБЧА'),
	('03642', '68134', '18811', 'УЛ.ХЪШОВЕ'),
	('03643', '68134', '18825', 'УЛ.ЦАНИ ГИНЧЕВ'),
	('03644', '68134', '18839', 'УЛ.ЦАНКА ГАНЧЕВА'),
	('03645', '68134', '18842', 'УЛ.ЦАНКО ДЮСТАБАНОВ'),
	('03646', '68134', '18856', 'УЛ.ЦАНКО ЦЕРКОВСКИ'),
	('03647', '68134', '18861', 'УЛ.ЦАР АСЕН'),
	('03648', '68134', '18873', 'УЛ.ЦАР ИВАН АСЕН II'),
	('03649', '68134', '18887', 'УЛ.ЦАР КАЛОЯН'),
	('03650', '68134', '18900', 'УЛ.ЦАР ПЕТЪР'),
	('03651', '68134', '18914', 'УЛ.ЦАР САМУИЛ'),
	('03652', '68134', '18928', 'УЛ.ЦАР СИМЕОН'),
	('03653', '68134', '18931', 'УЛ.ЦАР ШИШМАН'),
	('03654', '68134', '18945', 'УЛ.ЦАРЕВА ЛИВАДА'),
	('03655', '68134', '18959', 'УЛ.ЦАРЕВЕЦ'),
	('03656', '68134', '18962', 'УЛ.ЦАРЕВО СЕЛО'),
	('03657', '68134', '18976', 'УЛ.ЦАРИБРОД'),
	('03658', '68134', '19008', 'УЛ.ЦАРИЧИНА'),
	('03659', '68134', '19011', 'УЛ.ЦВЕТА ЗОГРАФСКА'),
	('03660', '68134', '19025', 'УЛ.КАВАК'),
	('03661', '68134', '19039', 'УЛ.ПРОФ.ИВАН ГЕОРГОВ'),
	('03662', '68134', '19042', 'УЛ.ЦВЕТАН ВИТОВ'),
	('03663', '68134', '19069', 'УЛ.ЦИГОВ ЧАРК'),
	('03664', '68134', '19090', 'УЛ.ЦВЕТНА ГРАДИНА'),
	('03665', '68134', '19114', 'УЛ.ЦЕРОВА ГОРА'),
	('03666', '68134', '19131', 'УЛ.ЦИКЛАМА'),
	('03667', '68134', '19162', 'УЛ.БУРЕЛ'),
	('03668', '68134', '19176', 'УЛ.ЦЪРКВИЩЕ'),
	('03669', '68134', '19184', 'УЛ.ЦЪРНООК'),
	('03670', '68134', '19193', 'УЛ.ЧАВДАР ВОЙВОДА'),
	('03671', '68134', '19203', 'УЛ.СВЕТИ НИКОЛА НОВИ'),
	('03672', '68134', '19217', 'УЛ.ХРИСТО СТАНИШЕВ'),
	('03673', '68134', '19220', 'УЛ.ЧАЙКА'),
	('03674', '68134', '19234', 'УЛ.ЧАМКОРИЯ'),
	('03675', '68134', '19248', 'УЛ.ЧАПАЕВ'),
	('03676', '68134', '19251', 'УЛ.ЧАР'),
	('03677', '68134', '19265', 'УЛ.ЧАРДАКЛИЯ'),
	('03678', '68134', '19279', 'УЛ.ЧАРЛЗ ДАРВИН'),
	('03679', '68134', '19282', 'УЛ.ЧАТАЛДЖА'),
	('03680', '68134', '19306', 'УЛ.ЧЕМЕРИКА'),
	('03681', '68134', '19337', 'УЛ.ЧЕПЕЛАРЕ'),
	('03682', '68134', '19340', 'УЛ.ЧЕПИНО'),
	('03683', '68134', '19368', 'УЛ.СЛАТИНСКА'),
	('03684', '68134', '19371', 'УЛ.ТАНГРА'),
	('03685', '68134', '19385', 'УЛ.МОРЕНИ'),
	('03686', '68134', '19399', 'УЛ.ЧЕРВЕНА РОЗА'),
	('03687', '68134', '19409', 'УЛ.ЧЕРВЕНА СТЕНА'),
	('03688', '68134', '19412', 'УЛ.СПРАВЕДЛИВОСТ'),
	('03689', '68134', '19426', 'УЛ.ЧЕРВЕНО ЗНАМЕ'),
	('03690', '68134', '19430', 'УЛ.НАРОДНИ БУДИТЕЛИ'),
	('03691', '68134', '19443', 'УЛ.ЧЕРЕША'),
	('03692', '68134', '19460', 'УЛ.ЧЕРЕШОВА ГРАДИНА'),
	('03693', '68134', '19474', 'УЛ.ПЕТЪР ГОРАНОВ'),
	('03694', '68134', '19488', 'УЛ.СЪВЕТ НА ЕВРОПА'),
	('03695', '68134', '19491', 'БУЛ.ЧЕРНИ ВРЪХ'),
	('03696', '68134', '19515', 'УЛ.ЧЕРНИ ЛОМ'),
	('03697', '68134', '19532', 'УЛ.ЧЕРНОРИЗЕЦ ХРАБЪР'),
	('03698', '68134', '19556', 'УЛ.ЧИНАР'),
	('03699', '68134', '19563', 'УЛ.ЧИПРОВСКО ВЪСТАНИЕ'),
	('03700', '68134', '19577', 'УЛ.ЧИПРОВЦИ'),
	('03701', '68134', '19604', 'УЛ.ЧОРЛУ'),
	('03702', '68134', '19618', 'УЛ.ЧУЖДЕНЕЦ'),
	('03703', '68134', '19621', 'УЛ.ЧУКАР'),
	('03704', '68134', '19635', 'УЛ.ЧУЧУЛИГА'),
	('03705', '68134', '19649', 'УЛ.ШАБЛА'),
	('03706', '68134', '19666', 'УЛ.ШАНДОР ПЕТЬОФИ'),
	('03707', '68134', '19671', 'УЛ.ШАР ПЛАНИНА'),
	('03708', '68134', '19683', 'УЛ.ШЕЙНОВО'),
	('03709', '68134', '19697', 'УЛ.ШЕМНИЦА'),
	('03710', '68134', '19707', 'УЛ.6-ТИ СЕПТЕМВРИ'),
	('03711', '68134', '19710', 'УЛ.ШИПКА'),
	('03712', '68134', '19724', 'УЛ.ШИПЧЕНСКИ ПРОХОД'),
	('03713', '68134', '19741', 'УЛ.ШЛОСЕР'),
	('03714', '68134', '19769', 'УЛ.СЕЛИОЛУ'),
	('03715', '68134', '19786', 'УЛ.ШУМЕН'),
	('03716', '68134', '19802', 'УЛ.ЩАСТИЕ'),
	('03717', '68134', '19813', 'УЛ.БОЛЯРСКА'),
	('03718', '68134', '19827', 'УЛ.ЮНАК'),
	('03719', '68134', '19830', 'УЛ.ЮНАШКА ПЕСЕН'),
	('03720', '68134', '19844', 'УЛ.ЮНДОЛА'),
	('03721', '68134', '19858', 'УЛ.ЮМРУКЧАЛ'),
	('03722', '68134', '19875', 'УЛ.ЯВОРЕЦ'),
	('03723', '68134', '19889', 'УЛ.ЯВОРИЦА'),
	('03724', '68134', '19892', 'УЛ.ЯВОРОВА ЧУКА'),
	('03725', '68134', '19933', 'УЛ.ЯКУБИЦА'),
	('03726', '68134', '19950', 'УЛ.ЯЛТА'),
	('03727', '68134', '19964', 'УЛ.ЯМБОЛ'),
	('03728', '68134', '19978', 'УЛ.СВЕТИ КЛИМЕНТ'),
	('03729', '68134', '19981', 'УЛ.ЯНА (ДЪРВЕНИЦА)'),
	('03730', '68134', '20002', 'УЛ.ЗЛЕТОВО'),
	('03731', '68134', '20016', 'УЛ.ВРАБЧА'),
	('03732', '68134', '20047', 'УЛ.ЯНТРА'),
	('03733', '68134', '20078', 'УЛ.ЯРОСЛАВ ВЕШИН'),
	('03734', '68134', '20081', 'УЛ.ЯРЕБИЧНА ПЛАНИНА'),
	('03735', '68134', '20122', 'УЛ.ЯСТРЕБЕЦ'),
	('03736', '68134', '20136', 'УЛ.БЯЛА БУКА'),
	('03737', '68134', '20142', 'УЛ.ЗЕМЕДЕЛСКА'),
	('03738', '68134', '20153', 'УЛ.229-ТА (ВРЪБНИЦА)'),
	('03739', '68134', '20167', 'УЛ.ТОНЧО ЖЕЧЕВ'),
	('03740', '68134', '20170', 'УЛ.761-ВА (КРАСНА ПОЛЯНА)'),
	('03741', '68134', '20256', 'УЛ.ВЕСЕЛИН ХАНЧЕВ'),
	('03742', '68134', '20328', 'УЛ.ТЕОДОР ТРАЯНОВ (277-МА)'),
	('03743', '68134', '20331', 'УЛ.763-ТА (КРАСНА ПОЛЯНА)'),
	('03744', '68134', '20376', 'УЛ.3-ТА (ОБЕЛЯ)'),
	('03745', '68134', '20420', 'УЛ.4-ТА (ОБЕЛЯ)'),
	('03746', '68134', '20451', 'УЛ.765-ТА (КРАСНА ПОЛЯНА)'),
	('03747', '68134', '20479', 'УЛ.5-ТА (ОБЕЛЯ)'),
	('03748', '68134', '20496', 'УЛ.766-ТА (КРАСНА ПОЛЯНА)'),
	('03749', '68134', '20523', 'УЛ.6-ТА (ОБЕЛЯ)'),
	('03750', '68134', '20540', 'УЛ.767-МА (ОВЧА КУПЕЛ)'),
	('03751', '68134', '20571', 'УЛ.7-МА (ОБЕЛЯ)'),
	('03752', '68134', '20612', 'УЛ.8-МА (ОБЕЛЯ)'),
	('03753', '68134', '20643', 'УЛ.9-ТА (ОБЕЛЯ)'),
	('03754', '68134', '20674', 'УЛ.10-ТА (ОБЕЛЯ)'),
	('03755', '68134', '20729', 'УЛ.11-ТА (ОБЕЛЯ)'),
	('03756', '68134', '20777', 'УЛ.12-ТА (ОБЕЛЯ)'),
	('03757', '68134', '20821', 'УЛ.13-ТА (ОБЕЛЯ)'),
	('03758', '68134', '20852', 'УЛ.14-ТА (ОБЕЛЯ)'),
	('03759', '68134', '20907', 'УЛ.15-ТА (ОБЕЛЯ)'),
	('03760', '68134', '20924', 'УЛ.269-ТА (ВРЪБНИЦА)'),
	('03761', '68134', '21018', 'УЛ.17-ТА (ОБЕЛЯ)'),
	('03762', '68134', '21052', 'УЛ.18-ТА (ОБЕЛЯ)'),
	('03763', '68134', '21097', 'УЛ.19-ТА (ОБЕЛЯ)'),
	('03764', '68134', '21138', 'УЛ.20-ТА (ОБЕЛЯ)'),
	('03765', '68134', '21169', 'УЛ.21-ВА (ОБЕЛЯ)'),
	('03766', '68134', '21193', 'УЛ.22-РА (ОБЕЛЯ)'),
	('03767', '68134', '21230', 'УЛ.23-ТА (ОБЕЛЯ)'),
	('03768', '68134', '21261', 'УЛ.24-ТА (ОБЕЛЯ)'),
	('03769', '68134', '21292', 'УЛ.25-ТА (ОБЕЛЯ)'),
	('03770', '68134', '21316', 'УЛ.БОЯНСКА ПЕСЕН (774-ТА)'),
	('03771', '68134', '21333', 'УЛ.26-ТА (ОБЕЛЯ)'),
	('03772', '68134', '21364', 'УЛ.БРЪШЛЯН (620-ТА)'),
	('03773', '68134', '21381', 'УЛ.28-МА (ОБЕЛЯ)'),
	('03774', '68134', '21405', 'УЛ.ПРОФ.Д-Р ИВАН СТРАНСКИ'),
	('03775', '68134', '21422', 'УЛ.СТАМЕН ПАНЧЕВ (771-ВА)'),
	('03776', '68134', '21854', 'УЛ.КЛИМЕНТ ДЕНЧЕВ (101-ВА)'),
	('03777', '68134', '21899', 'УЛ.АСЕН ПЕЙКОВ'),
	('03778', '68134', '21909', 'УЛ.Д-Р СТАМЕН ГРИГОРОВ'),
	('03779', '68134', '21912', 'УЛ.132-РА (ИЗГРЕВ)'),
	('03780', '68134', '21943', 'УЛ.СТАРОЗАГОРСКО ВЪСТАНИЕ'),
	('03781', '68134', '21960', 'УЛ.ЙОСИФ ХЕРБСТ (206-ТА)'),
	('03782', '68134', '21988', 'УЛ.ХРИСТОФОР ЖЕФАРОВИЧ (210)'),
	('03783', '68134', '21991', 'УЛ.Д-Р КРЪСТЬО КРЪСТЕВ(211-ТА)'),
	('03784', '68134', '22006', 'УЛ.212-ТА (ВРЪБНИЦА)'),
	('03785', '68134', '22109', 'УЛ.КАП.АТАНАС БЕНДРЕВ (220-ТА)'),
	('03786', '68134', '22112', 'УЛ.225-ТА (ЛОЗЕНЕЦ'),
	('03787', '68134', '22126', 'УЛ.КОТИС (226-ТА)'),
	('03788', '68134', '22201', 'УЛ.236-ТА (НАДЕЖДА)'),
	('03789', '68134', '22250', 'УЛ.БРАТЯ ШКОРПИЛ (240-ТА)'),
	('03790', '68134', '22318', 'УЛ.250-ТА (СЕРДИКА)'),
	('03791', '68134', '22321', 'УЛ.251-ВА (СЕРДИКА)'),
	('03792', '68134', '22335', 'УЛ.252-РА (СЕРДИКА)'),
	('03793', '68134', '22366', 'УЛ.271-ВА (ВРЪБНИЦА)'),
	('03794', '68134', '22397', 'УЛ.276-ТА (ВРЪБНИЦА)'),
	('03795', '68134', '22407', 'УЛ.278-МА (ВРЪБНИЦА)'),
	('03796', '68134', '22410', 'УЛ.279-ТА (СЕРДИКА)'),
	('03797', '68134', '22424', 'УЛ.280-ТА (ВРЪБНИЦА)'),
	('03798', '68134', '22438', 'УЛ.ПЕТЪР ПАНАЙОТОВ (281-ВА)'),
	('03799', '68134', '22455', 'УЛ.300-ТА (КРАСНА ПОЛЯНА)'),
	('03800', '68134', '22469', 'УЛ.301-ВА А (КРАСНА ПОЛЯНА)'),
	('03801', '68134', '22486', 'УЛ.302-РА (КРАСНА ПОЛЯНА)'),
	('03802', '68134', '22490', 'УЛ.303-ТА (КРАСНА ПОЛЯНА)'),
	('03803', '68134', '22513', 'УЛ.304-ТА (КРАСНА ПОЛЯНА)'),
	('03804', '68134', '22527', 'УЛ.305-ТА (КРАСНА ПОЛЯНА)'),
	('03805', '68134', '22530', 'УЛ.306-ТА (КРАСНА ПОЛЯНА)'),
	('03806', '68134', '22544', 'УЛ.307-МА (КРАСНА ПОЛЯНА)'),
	('03807', '68134', '22561', 'УЛ.308-МА (КРАСНА ПОЛЯНА)'),
	('03808', '68134', '22589', 'УЛ.309-ТА (КРАСНА ПОЛЯНА)'),
	('03809', '68134', '22616', 'УЛ.311-ТА (КРАСНА ПОЛЯНА)'),
	('03810', '68134', '22633', 'УЛ.312-ТА (КРАСНА ПОЛЯНА)'),
	('03811', '68134', '22647', 'УЛ.312-ТА А (КРАСНА ПОЛЯНА)'),
	('03812', '68134', '22650', 'УЛ.313-ТА (КРАСНА ПОЛЯНА)'),
	('03813', '68134', '22695', 'УЛ.315-ТА (КРАСНА ПОЛЯНА)'),
	('03814', '68134', '22705', 'УЛ.316-ТА (КРАСНА ПОЛЯНА)'),
	('03815', '68134', '22719', 'УЛ.318-ТА (КРАСНА ПОЛЯНА)'),
	('03816', '68134', '22722', 'УЛ.320-ТА (КРАСНА ПОЛЯНА)'),
	('03817', '68134', '22736', 'УЛ.321-ВА (КРАСНА ПОЛЯНА)'),
	('03818', '68134', '22747', 'УЛ.322-РА (КРАСНА ПОЛЯНА)'),
	('03819', '68134', '22753', 'УЛ.323-ТА (КРАСНА ПОЛЯНА)'),
	('03820', '68134', '22767', 'УЛ.324-ТА (ЛЮЛИН)'),
	('03821', '68134', '22770', 'УЛ.325-ТА (ЛЮЛИН)'),
	('03822', '68134', '22798', 'УЛ.328-МА (ЛЮЛИН ВРЪБНИЦА)'),
	('03823', '68134', '22808', 'УЛ.329-ТА (ЛЮЛИН)'),
	('03824', '68134', '22811', 'УЛ.330-ТА (ЛЮЛИН)'),
	('03825', '68134', '22825', 'УЛ.331-ВА (ЛЮЛИН)'),
	('03826', '68134', '22839', 'УЛ.332-РА (ЛЮЛИН)'),
	('03827', '68134', '22862', 'УЛ.335-ТА (ЛЮЛИН)'),
	('03828', '68134', '22887', 'УЛ.337-МА (ЛЮЛИН)'),
	('03829', '68134', '22890', 'УЛ.338-МА (ЛЮЛИН)'),
	('03830', '68134', '22900', 'УЛ.339-ТА (ЛЮЛИН)'),
	('03831', '68134', '22914', 'УЛ.340-ТА (ЛЮЛИН)'),
	('03832', '68134', '22976', 'УЛ.349-ТА (КРАСНА ПОЛЯНА)'),
	('03833', '68134', '23011', 'УЛ.357-МА (ВРЪБНИЦА)'),
	('03834', '68134', '23025', 'УЛ.359-ТА (ВРЪБНИЦА)'),
	('03835', '68134', '23039', 'УЛ.360-ТА (ВРЪБНИЦА)'),
	('03836', '68134', '23042', 'УЛ.361-ВА (ВРЪБНИЦА)'),
	('03837', '68134', '23056', 'УЛ.362-РА (ВРЪБНИЦА)'),
	('03838', '68134', '23060', 'УЛ.363-ТА (ВРЪБНИЦА)'),
	('03839', '68134', '23073', 'УЛ.364-ТА (ВРЪБНИЦА)'),
	('03840', '68134', '23090', 'УЛ.365-ТА (ВРЪБНИЦА)'),
	('03841', '68134', '23100', 'УЛ.367-МА (ВРЪБНИЦА)'),
	('03842', '68134', '23128', 'УЛ.368-МА (ВРЪБНИЦА)'),
	('03843', '68134', '23131', 'УЛ.369-ТА (ВРЪБНИЦА)'),
	('03844', '68134', '23145', 'УЛ.370-ТА (ВРЪБНИЦА)'),
	('03845', '68134', '23159', 'УЛ.371-ВА (ВРЪБНИЦА)'),
	('03846', '68134', '23162', 'УЛ.372-РА (ВРЪБНИЦА)'),
	('03847', '68134', '23185', 'УЛ.373-ТА (ВРЪБНИЦА)'),
	('03848', '68134', '23193', 'УЛ.375-ТА (ВРЪБНИЦА)'),
	('03849', '68134', '23203', 'УЛ.376-ТА (ВРЪБНИЦА)'),
	('03850', '68134', '23217', 'УЛ.377-МА (ВРЪБНИЦА)'),
	('03851', '68134', '23220', 'УЛ.378-МА (ВРЪБНИЦА)'),
	('03852', '68134', '23234', 'УЛ.379-ТА (ВРЪБНИЦА)'),
	('03853', '68134', '23248', 'УЛ.381-ВА (ВРЪБНИЦА)'),
	('03854', '68134', '23279', 'УЛ.386-ТА (КРАСНА ПОЛЯНА)'),
	('03855', '68134', '23282', 'УЛ.387-МА (ЛЮЛИН)'),
	('03856', '68134', '23296', 'УЛ.390-ТА (ЛЮЛИН)'),
	('03857', '68134', '23316', 'УЛ.392-РА (ЛЮЛИН)'),
	('03858', '68134', '23368', 'УЛ.397-МА (ЛЮЛИН)'),
	('03859', '68134', '23371', 'УЛ.398-МА (ЛЮЛИН)'),
	('03860', '68134', '23385', 'УЛ.399-ТА (ЛЮЛИН)'),
	('03861', '68134', '23399', 'УЛ.ГЕНЕРАЛ КАЗИМИР ЕРНРОТ'),
	('03862', '68134', '23443', 'УЛ.402-РА (ТРИАДИЦА)'),
	('03863', '68134', '23460', 'УЛ.ИСТОРИЯ СЛАВЯНОБЪЛГАРСКА'),
	('03864', '68134', '23491', 'УЛ.406-ТА (ТРИАДИЦА)'),
	('03865', '68134', '23515', 'УЛ.ШАРЛ ШАМПО (407 И 414)'),
	('03866', '68134', '23532', 'УЛ.408-МА (ТРИАДИЦА)'),
	('03867', '68134', '23563', 'УЛ.409-ТА (ТРИАДИЦА)'),
	('03868', '68134', '23580', 'УЛ.412-ТА (ТРИАДИЦА)'),
	('03869', '68134', '23594', 'УЛ.413-ТА (ТРИАДИЦА'),
	('03870', '68134', '23604', 'УЛ.414-ТА (ТРИАДИЦА)'),
	('03871', '68134', '23618', 'УЛ.ГРИГОР ЧЕШМЕДЖИЕВ'),
	('03872', '68134', '23649', 'УЛ.418-ТА (ТРИАДИЦА)'),
	('03873', '68134', '23652', 'УЛ.ЙОРДАН БАКАЛОВ-СТУБЕЛ (419)'),
	('03874', '68134', '23666', 'УЛ.420-ТА (ТРИАДИЦА)'),
	('03875', '68134', '23707', 'УЛ.АСЕН РАЗЦВЕТНИКОВ (431-ВА)'),
	('03876', '68134', '23710', 'УЛ.ЕМАНУИЛ ПОПДИМИТРОВ (432)'),
	('03877', '68134', '23724', 'УЛ.АНГЕЛ КАРАЛИЙЧЕВ (433-ТА)'),
	('03878', '68134', '23738', 'УЛ.ГЕОРГИ РАЙЧЕВ (434-ТА)'),
	('03879', '68134', '23741', 'УЛ.ПРОФ.АЛ.БАЛАБАНОВ (435-ТА)'),
	('03880', '68134', '23755', 'УЛ.ЙОРДАН БАДЕВ (436-ТА)'),
	('03881', '68134', '23769', 'УЛ.КОНСТАНТИН ПЕТКАНОВ (437)'),
	('03882', '68134', '23772', 'УЛ.438-МА (ЛОЗЕНЕЦ)'),
	('03883', '68134', '23786', 'УЛ.АЛЕКСАНДЪР БОЖИНОВ (439-ТА)'),
	('03884', '68134', '23813', 'УЛ.ТРИФОН КУНЕВ (441-ВА)'),
	('03885', '68134', '23827', 'УЛ.ДАНАИЛ КРАПЧЕВ (442-РА)'),
	('03886', '68134', '23844', 'УЛ.ИВАН ПЕЙЧЕВ (443-ТА)'),
	('03887', '68134', '23858', 'УЛ.ЙОРДАН СТУБЕЛ (444-ТА)'),
	('03888', '68134', '23875', 'УЛ.258-МА (СЕРДИКА)'),
	('03889', '68134', '23892', 'УЛ.ДИМИТЪР ШИШМАНОВ (446-ТА)'),
	('03890', '68134', '23902', 'УЛ.ЯНА ЯЗОВА (447-МА)'),
	('03891', '68134', '23916', 'УЛ.254-ТА (СЕРДИКА)'),
	('03892', '68134', '23929', 'УЛ.ЕКАТЕРИНА НЕНЧЕВА (448-МА)'),
	('03893', '68134', '23950', 'УЛ.ДИМ.СТРАШИМИРОВ (451-ВА)'),
	('03894', '68134', '23964', 'УЛ.ЧАВДАР МУТАФОВ (452-РА)'),
	('03895', '68134', '23978', 'УЛ.ТОДОР КОЖУХАРОВ (453-ТА)'),
	('03896', '68134', '23995', 'УЛ.ПРОФ.ГЕОРГИ ЗЛАТАРСКИ (454)'),
	('03897', '68134', '24000', 'УЛ.455-ТА (СТУДЕНТСКИ)'),
	('03898', '68134', '24013', 'УЛ.ИВАН РАДОЕВ (456-ТА)'),
	('03899', '68134', '24027', 'УЛ.РАН БОСИЛЕК (461-ВА)'),
	('03900', '68134', '24030', 'УЛ.ДИМИТЪР БОЯДЖИЕВ (475-ТА)'),
	('03901', '68134', '24058', 'УЛ.СТ.Л.КОСТОВ (477-МА)'),
	('03902', '68134', '24075', 'УЛ.ФАНИ ПОПОВА-МУТАФОВА (479)'),
	('03903', '68134', '24089', 'УЛ.БОРИС РУМЕНОВ (482-РА)'),
	('03904', '68134', '24092', 'УЛ.САШО НИКОЛОВ-СЛАДУРА (483)'),
	('03905', '68134', '24102', 'УЛ.АСПАРУХ ЛЕШНИКОВ (484-ТА)'),
	('03906', '68134', '24126', 'УЛ.АСЕН ЙОРДАНОВ (486-ТА)'),
	('03907', '68134', '24133', 'УЛ.ДЖОН АТАНАСОВ (487-МА)'),
	('03908', '68134', '24147', 'УЛ.488-МА (ТРИАДИЦА)'),
	('03909', '68134', '24178', 'УЛ.ИВАН АНДОНОВ (491-ВА)'),
	('03910', '68134', '24181', 'УЛ.ГАТЬО ШИШКОВ'),
	('03911', '68134', '24222', 'УЛ.ЛЮБА ВЕЛИЧКОВА (497-МА)'),
	('03912', '68134', '24241', 'УЛ.498-МА (ТРИАДИЦА)'),
	('03913', '68134', '24253', 'УЛ.501-ВА (СЛАТИНА)'),
	('03914', '68134', '24267', 'УЛ.502-РА (СЛАТИНА)'),
	('03915', '68134', '24270', 'УЛ.503-ТА (СЛАТИНА)'),
	('03916', '68134', '24284', 'УЛ.504-ТА (СЛАТИНА)'),
	('03917', '68134', '24298', 'УЛ.505-ТА (СЛАТИНА)'),
	('03918', '68134', '24308', 'УЛ.506-ТА (СЛАТИНА)'),
	('03919', '68134', '24311', 'УЛ.507-МА (СЛАТИНА)'),
	('03920', '68134', '24325', 'УЛ.508-МА (СЛАТИНА)'),
	('03921', '68134', '24339', 'УЛ.509-ТА (СЛАТИНА)'),
	('03922', '68134', '24342', 'УЛ.510-ТА (СЛАТИНА)'),
	('03923', '68134', '24356', 'УЛ.511-ТА (СЛАТИНА)'),
	('03924', '68134', '24367', 'УЛ.512-ТА (СЛАТИНА)'),
	('03925', '68134', '24373', 'УЛ.513-ТА (СЛАТИНА)'),
	('03926', '68134', '24387', 'УЛ.514-ТА (СЛАТИНА)'),
	('03927', '68134', '24390', 'УЛ.515-ТА (СЛАТИНА)'),
	('03928', '68134', '24400', 'УЛ.516-ТА (СЛАТИНА)'),
	('03929', '68134', '24414', 'УЛ.517-ТА (СЛАТИНА)'),
	('03930', '68134', '24428', 'УЛ.518-ТА (СЛАТИНА)'),
	('03931', '68134', '24431', 'УЛ.519-ТА (СЛАТИНА)'),
	('03932', '68134', '24445', 'УЛ.520-ТА (СЛАТИНА)'),
	('03933', '68134', '24459', 'УЛ.521-ВА (СЛАТИНА)'),
	('03934', '68134', '24462', 'УЛ.522-РА (СЛАТИНА)'),
	('03935', '68134', '24476', 'УЛ.523-ТА (СЛАТИНА)'),
	('03936', '68134', '24482', 'УЛ.524-ТА (СЛАТИНА)'),
	('03937', '68134', '24493', 'УЛ.525-ТА (СЛАТИНА)'),
	('03938', '68134', '24503', 'УЛ.526-ТА (СЛАТИНА)'),
	('03939', '68134', '24517', 'УЛ.527-МА (СЛАТИНА)'),
	('03940', '68134', '24520', 'УЛ.528-МА (СЛАТИНА)'),
	('03941', '68134', '24534', 'УЛ.529-ТА (СЛАТИНА)'),
	('03942', '68134', '24548', 'УЛ.530-ТА (СЛАТИНА)'),
	('03943', '68134', '24551', 'УЛ.532-РА (СЛАТИНА)'),
	('03944', '68134', '24565', 'УЛ.ВИЛА РУСТИКА (534-ТА)'),
	('03945', '68134', '24582', 'УЛ.ГЕОРГИ ИЛИЕВ (536-ТА)'),
	('03946', '68134', '24596', 'УЛ.540-ТА (ПОДУЯНЕ)'),
	('03947', '68134', '24606', 'УЛ.541-ВА (КВ.ЛЕВСКИ)'),
	('03948', '68134', '24613', 'УЛ.542-РА (КВ.ЛЕВСКИ)'),
	('03949', '68134', '24623', 'УЛ.543-ТА (КВ.ЛЕВСКИ)'),
	('03950', '68134', '24637', 'УЛ.544-ТА (КВ.ЛЕВСКИ)'),
	('03951', '68134', '24640', 'УЛ.545-ТА (КВ.ЛЕВСКИ)'),
	('03952', '68134', '24654', 'УЛ.546-ТА (КВ.ЛЕВСКИ)'),
	('03953', '68134', '24668', 'УЛ.547-МА (КВ.ЛЕВСКИ)'),
	('03954', '68134', '24671', 'УЛ.548-МА (КВ.ЛЕВСКИ)'),
	('03955', '68134', '24685', 'УЛ.549-ТА (ПОДУЯНЕ)'),
	('03956', '68134', '24709', 'УЛ.ПОП ЙОВЧО (552-РА)'),
	('03957', '68134', '24712', 'УЛ.553-ТА (КВ.ЛЕВСКИ)'),
	('03958', '68134', '24726', 'УЛ.554-ТА (СЛАТИНА)'),
	('03959', '68134', '24739', 'УЛ.555-ТА (СЛАТИНА)'),
	('03960', '68134', '24743', 'УЛ.557-МА (СЛАТИНА)'),
	('03961', '68134', '24757', 'УЛ.558-МА (СЛАТИНА)'),
	('03962', '68134', '24760', 'УЛ.559-ТА (СЛАТИНА)'),
	('03963', '68134', '24774', 'УЛ.560-ТА (КВ.ЛЕВСКИ)'),
	('03964', '68134', '24801', 'УЛ.563-ТА (КВ.ЛЕВСКИ)'),
	('03965', '68134', '24815', 'УЛ.564-ТА (КВ.ЛЕВСКИ)'),
	('03966', '68134', '24829', 'УЛ.565-ТА (КВ.ЛЕВСКИ)'),
	('03967', '68134', '24846', 'УЛ.566-ТА (КВ.ЛЕВСКИ)'),
	('03968', '68134', '24854', 'УЛ.567-МА (КВ.ЛЕВСКИ)'),
	('03969', '68134', '24863', 'УЛ.568-МА (КВ.ЛЕВСКИ)'),
	('03970', '68134', '24877', 'УЛ.ЯРОСЛАВ ХАШЕК (569 ЛЕВСКИ)'),
	('03971', '68134', '24880', 'УЛ.570-ТА (КВ.ЛЕВСКИ)'),
	('03972', '68134', '24894', 'УЛ.571-ВА (КВ.ЛЕВСКИ)'),
	('03973', '68134', '24904', 'УЛ.572-РА (КВ.ЛЕВСКИ)'),
	('03974', '68134', '24918', 'УЛ.573-ТА (КВ.ЛЕВСКИ)'),
	('03975', '68134', '24921', 'УЛ.575-ТА (КВ.ЛЕВСКИ)'),
	('03976', '68134', '24935', 'УЛ.577-МА (КВ.ЛЕВСКИ)'),
	('03977', '68134', '24949', 'УЛ.583-ТА (КВ.ЛЕВСКИ)'),
	('03978', '68134', '24952', 'УЛ.584-ТА (СЛАТИНА)'),
	('03979', '68134', '24966', 'УЛ.585-ТА (СЛАТИНА)'),
	('03980', '68134', '24970', 'УЛ.586-ТА (СЛАТИНА)'),
	('03981', '68134', '24983', 'УЛ.587-МА (СЛАТИНА)'),
	('03982', '68134', '24997', 'УЛ.588-МА (СЛАТИНА)'),
	('03983', '68134', '25001', 'УЛ.589-ТА (СЛАТИНА)'),
	('03984', '68134', '25015', 'УЛ.590-ТА (СЛАТИНА)'),
	('03985', '68134', '25029', 'УЛ.592-РА (СЛАТИНА)'),
	('03986', '68134', '25032', 'УЛ.593-ТА (СЛАТИНА)'),
	('03987', '68134', '25046', 'УЛ.594-ТА (СЛАТИНА)'),
	('03988', '68134', '25051', 'УЛ.595-ТА (СЛАТИНА)'),
	('03989', '68134', '25063', 'УЛ.596-ТА (СЛАТИНА)'),
	('03990', '68134', '25077', 'УЛ.597-МА (СЛАТИНА)'),
	('03991', '68134', '25080', 'УЛ.598-МА (СЛАТИНА)'),
	('03992', '68134', '25094', 'УЛ.599-ТА (СЛАТИНА)'),
	('03993', '68134', '25104', 'УЛ.600-НА (ВИТОША)'),
	('03994', '68134', '25118', 'УЛ.603-ТА (ВИТОША)'),
	('03995', '68134', '25121', 'УЛ.605-ТА (ВИТОША)'),
	('03996', '68134', '25135', 'УЛ.ЦЪРКОВНА'),
	('03997', '68134', '25149', 'УЛ.НАЙДЕН НИКОЛОВ (607-МА)'),
	('03998', '68134', '25152', 'УЛ.ИЛИЯ КУТЕВ (608-МА)'),
	('03999', '68134', '25166', 'УЛ.БОТКО ВОЙВОДА (611-ТА)'),
	('04000', '68134', '25177', 'УЛ.ДЕЯН ГЬОРГОВ (612-ТА)'),
	('04001', '68134', '25183', 'УЛ.БУЛАИР (613-ТА)'),
	('04002', '68134', '25197', 'УЛ.БОЙНА СЛАВА (615-ТА)'),
	('04003', '68134', '25207', 'УЛ.КЛЕК (618-ТА 616-ТА)'),
	('04004', '68134', '25210', 'УЛ.ТИС (619-ТА)'),
	('04005', '68134', '25224', 'УЛ.ШИШМАНОВА КОННИЦА (620-ТА)'),
	('04006', '68134', '25238', 'УЛ.БЯЛ РАВНЕЦ (621-ВА)'),
	('04007', '68134', '25241', 'УЛ.СТОИЛ СЛАТИНСКИ (622-РА)'),
	('04008', '68134', '25255', 'УЛ.ДИВ КЕСТЕН (623-ТА)'),
	('04009', '68134', '25269', 'УЛ.ПАНТЕЛЕЙ НИКОЛОВ (624-ТА)'),
	('04010', '68134', '25286', 'УЛ.626-ТА (ВИТОША)'),
	('04011', '68134', '25292', 'УЛ.МАНОЛ ТОДОРОВ (627-МА)'),
	('04012', '68134', '25308', 'УЛ.СРЕБРИСТА ЛИПА (630-ТА)'),
	('04013', '68134', '25313', 'УЛ.КАМЕНАРЧЕ (631-ВА)'),
	('04014', '68134', '25327', 'УЛ.633-ТА (ВИТОША)'),
	('04015', '68134', '25330', 'УЛ.ГЕОРГИ ВОЙТЕХ (634-ТА)'),
	('04016', '68134', '25361', 'УЛ.637-МА (ОВЧА КУПЕЛ)'),
	('04017', '68134', '25375', 'УЛ.638-МА (ОВЧА КУПЕЛ)'),
	('04018', '68134', '25389', 'УЛ.639-ТА (ОВЧА КУПЕЛ ВИТОША)'),
	('04019', '68134', '25392', 'УЛ.640-ТА (ОВЧА КУПЕЛ)'),
	('04020', '68134', '25402', 'УЛ.641-ВА (ОВЧА КУПЕЛ)'),
	('04021', '68134', '25416', 'УЛ.642-РА (ОВЧА КУПЕЛ)'),
	('04022', '68134', '25423', 'УЛ.ДРЯН (643 И 640)'),
	('04023', '68134', '25433', 'УЛ.643-ТА (ВИТОША ОВЧА КУПЕЛ)'),
	('04024', '68134', '25447', 'УЛ.БОЙЧО БОЙЧЕВ'),
	('04025', '68134', '25464', 'УЛ.646-ТА (ОВЧА КУПЕЛ)'),
	('04026', '68134', '25481', 'УЛ.647-МА (560 ОВЧА КУПЕЛ)'),
	('04027', '68134', '25495', 'УЛ.648-МА (ОВЧА КУПЕЛ)'),
	('04028', '68134', '25505', 'УЛ.649-ТА (ОВЧА КУПЕЛ)'),
	('04029', '68134', '25519', 'УЛ.650-ТА (ОВЧА КУПЕЛ)'),
	('04030', '68134', '25584', 'УЛ.695-ТА'),
	('04031', '68134', '25608', 'УЛ.656-ТА (КРАСНО СЕЛО)'),
	('04032', '68134', '25625', 'УЛ.658-МА (ОВЧА КУПЕЛ)'),
	('04033', '68134', '25639', 'УЛ.659-ТА (ОВЧА КУПЕЛ)'),
	('04034', '68134', '25642', 'УЛ.660-ТА (ОВЧА КУПЕЛ)'),
	('04035', '68134', '25656', 'УЛ.661-ВА (ОВЧА КУПЕЛ)'),
	('04036', '68134', '25664', 'УЛ.662-РА (ОВЧА КУПЕЛ)'),
	('04037', '68134', '25673', 'УЛ.663-ТА (ОВЧА КУПЕЛ)'),
	('04038', '68134', '25728', 'УЛ.668-МА (ОВЧА КУПЕЛ)'),
	('04039', '68134', '25731', 'УЛ.ЛУННА ПАПРАТ (669-ТА)'),
	('04040', '68134', '25745', 'УЛ.670-ТА (ОВЧА КУПЕЛ)'),
	('04041', '68134', '25759', 'УЛ.671-ВА (ОВЧА КУПЕЛ)'),
	('04042', '68134', '25762', 'УЛ.672-РА (ОВЧА КУПЕЛ)'),
	('04043', '68134', '25780', 'УЛ.674-ТА (ОВЧА КУПЕЛ)'),
	('04044', '68134', '25803', 'УЛ.675-ТА (ОВЧА КУПЕЛ)'),
	('04045', '68134', '25817', 'УЛ.678-МА (ОВЧА КУПЕЛ)'),
	('04046', '68134', '25820', 'УЛ.679-ТА (ОВЧА КУПЕЛ)'),
	('04047', '68134', '25834', 'УЛ.680-ТА (ОВЧА КУПЕЛ)'),
	('04048', '68134', '25848', 'УЛ.681-ВА (ОВЧА КУПЕЛ)'),
	('04049', '68134', '25851', 'УЛ.682-РА (ОВЧА КУПЕЛ)'),
	('04050', '68134', '25865', 'УЛ.683-ТА (ОВЧА КУПЕЛ)'),
	('04051', '68134', '25879', 'УЛ.685-ТА (ОВЧА КУПЕЛ)'),
	('04052', '68134', '25882', 'УЛ.686-ТА (ОВЧА КУПЕЛ)'),
	('04053', '68134', '25896', 'УЛ.687-МА (ОВЧА КУПЕЛ)'),
	('04054', '68134', '25906', 'УЛ.688-МА (ОВЧА КУПЕЛ)'),
	('04055', '68134', '25910', 'УЛ.ПРОФ.МИХАЙЛО ПАРАШЧУК (690)'),
	('04056', '68134', '25923', 'УЛ.692-РА (ОВЧА КУПЕЛ)'),
	('04057', '68134', '25937', 'УЛ.693-ТА (ОВЧА КУПЕЛ)'),
	('04058', '68134', '25940', 'УЛ.694-ТА (ОВЧА КУПЕЛ)'),
	('04059', '68134', '25954', 'УЛ.696-ТА (ОВЧА КУПЕЛ)'),
	('04060', '68134', '25968', 'УЛ.697-МА (ОВЧА КУПЕЛ)'),
	('04061', '68134', '25985', 'УЛ.СИЯЙНА (701-ВА)'),
	('04062', '68134', '25999', 'УЛ.ЖИВОПИСНА (702-РА)'),
	('04063', '68134', '26017', 'УЛ.ОМАЯ (703-ТА)'),
	('04064', '68134', '26020', 'УЛ.ВЪРБА (704-ТА)'),
	('04065', '68134', '26048', 'УЛ.ПОВЕТ (705-ТА)'),
	('04066', '68134', '26051', 'УЛ.ДЪБРАВА (706 И 707)'),
	('04067', '68134', '26079', 'УЛ.707-МА'),
	('04068', '68134', '26082', 'УЛ.ГЕРБЕР (708-МА)'),
	('04069', '68134', '26106', 'УЛ.709-ТА (КРАСНА ПОЛЯНА)'),
	('04070', '68134', '26118', 'УЛ.РОЗМАРИН (709-ТА)'),
	('04071', '68134', '26137', 'УЛ.РОСЯНКА (710-ТА)'),
	('04072', '68134', '26140', 'УЛ.711-ТА (ЛЮЛИН)'),
	('04073', '68134', '26154', 'УЛ.711-ТА (ВИТОША)'),
	('04074', '68134', '26171', 'УЛ.ВИТОШКИ БОР (712-ТА)'),
	('04075', '68134', '26199', 'УЛ.713-ТА (ВИТОША)'),
	('04076', '68134', '26212', 'УЛ.714-ТА (ВИТОША)'),
	('04077', '68134', '26226', 'УЛ.3011-ТА (ЛЮЛИН)'),
	('04078', '68134', '26260', 'УЛ.717-ТА (ВИТОША)'),
	('04079', '68134', '26288', 'УЛ.718-ТА (ВИТОША)'),
	('04080', '68134', '26301', 'УЛ.719-ТА (ВИТОША)'),
	('04081', '68134', '26329', 'УЛ.720-ТА (ВИТОША)'),
	('04082', '68134', '26332', 'УЛ.721-ВА (ВИТОША)'),
	('04083', '68134', '26346', 'УЛ.722-РА (ВИТОША)'),
	('04084', '68134', '26363', 'УЛ.СВ.ЛУКА (723-ТА)'),
	('04085', '68134', '26380', 'УЛ.724-ТА (ВИТОША)'),
	('04086', '68134', '26435', 'УЛ.КИТНА (727-МА)'),
	('04087', '68134', '26452', 'УЛ.БЯЛА РУЖА (728-МА)'),
	('04088', '68134', '26474', 'УЛ.АСЕН ГЕОРГИЕВ (730-ТА)'),
	('04089', '68134', '26497', 'УЛ.КАЛОЯНОВА КРЕПОСТ (731-ВА)'),
	('04090', '68134', '26510', 'УЛ.732-РА (ЛЮЛИН)'),
	('04091', '68134', '26524', 'УЛ.732-РА (ВИТОША)'),
	('04092', '68134', '26538', 'УЛ.733-ТА (ЛЮЛИН)'),
	('04093', '68134', '26541', 'УЛ.РАДЕЦКИ (733-ТА-ВИТОША)'),
	('04094', '68134', '26569', 'УЛ.734-ТА (КРАСНА ПОЛЯНА)'),
	('04095', '68134', '26586', 'УЛ.735-ТА (КРАСНА ПОЛЯНА)'),
	('04096', '68134', '26590', 'УЛ.736-ТА (ОВЧА КУПЕЛ)'),
	('04097', '68134', '26613', 'УЛ.738-МА (ОВЧА КУПЕЛ)'),
	('04098', '68134', '26627', 'УЛ.739-ТА (ОВЧА КУПЕЛ)'),
	('04099', '68134', '26630', 'УЛ.3021-ВА (ВРЪБНИЦА)'),
	('04100', '68134', '26644', 'УЛ.740-ТА (ОВЧА КУПЕЛ)'),
	('04101', '68134', '26658', 'УЛ.3022-РА (ВРЪБНИЦА)'),
	('04102', '68134', '26661', 'УЛ.744-ТА (ГОРНА БАНЯ)'),
	('04103', '68134', '26689', 'УЛ.745-ТА (ГОРНА БАНЯ)'),
	('04104', '68134', '26692', 'УЛ.746-ТА (ОВЧА КУПЕЛ)'),
	('04105', '68134', '26702', 'УЛ.747-МА (ГОРНА БАНЯ)'),
	('04106', '68134', '26716', 'УЛ.748-МА (ГОРНА БАНЯ)'),
	('04107', '68134', '26720', 'УЛ.749-ТА (ОВЧА КУПЕЛ)'),
	('04108', '68134', '26733', 'УЛ.750-ТА (ОВЧА КУПЕЛ)'),
	('04109', '68134', '26750', 'УЛ.754-ТА (ИЛИНДЕН)'),
	('04110', '68134', '26764', 'УЛ.755-ТА (ОВЧА КУПЕЛ)'),
	('04111', '68134', '26778', 'УЛ.756-ТА (ОВЧА КУПЕЛ)'),
	('04112', '68134', '26795', 'УЛ.757-МА (ОВЧА КУПЕЛ)'),
	('04113', '68134', '26805', 'УЛ.758-МА (ОВЧА КУПЕЛ)'),
	('04114', '68134', '26822', 'УЛ.759-ТА (ОВЧА КУПЕЛ)'),
	('04115', '68134', '26836', 'УЛ.760-ТА (ОВЧА КУПЕЛ)'),
	('04116', '68134', '26846', 'УЛ.761-ВА (ОВЧА КУПЕЛ)'),
	('04117', '68134', '26853', 'УЛ.762-РА (ОВЧА КУПЕЛ)'),
	('04118', '68134', '26867', 'УЛ.763-ТА (КР.ПОЛЯНА ОВ.КУПЕЛ)'),
	('04119', '68134', '26870', 'УЛ.764-ТА (КР.ПОЛЯНА ОВ.КУПЕЛ)'),
	('04120', '68134', '26908', 'УЛ.3002-РА (ЛЮЛИН)'),
	('04121', '68134', '26911', 'УЛ.3005-ТА (717 ЛЮЛИН)'),
	('04122', '68134', '26925', 'УЛ.3014-ТА (755 ИЛИНДЕН)'),
	('04123', '68134', '26939', 'УЛ.3019-ТА (ВРЪБНИЦА)'),
	('04124', '68134', '26942', 'УЛ.3020-ТА (ВРЪБНИЦА)'),
	('04125', '68134', '26956', 'УЛ.АРХ.ГЕОРГИ НЕНОВ'),
	('04126', '68134', '26961', 'УЛ.21-ВИ ВЕК (СТУДЕНТСКИ)'),
	('04127', '68134', '26973', 'УЛ.НИКОЛА КРУШКИН ЧОЛАКА (494)'),
	('04128', '68134', '27022', 'УЛ.АКАД.СТЕФАН МЛАДЕНОВ'),
	('04129', '68134', '27139', 'УЛ.ХАН ТЕЛЕРИГ'),
	('04130', '68134', '27156', 'УЛ.КИШИНЕВ'),
	('04131', '68134', '27187', 'УЛ.ПЕТРИЧ'),
	('04132', '68134', '27200', 'УЛ.3003-ТА (ЛЮЛИН)'),
	('04133', '68134', '27231', 'УЛ.578-МА (КВ.ЛЕВСКИ)'),
	('04134', '68134', '27259', 'УЛ.ДРУШЛЯВИЦА'),
	('04135', '68134', '27284', 'УЛ.374-ТА (ВРЪБНИЦА)'),
	('04136', '68134', '27293', 'УЛ.3004-ТА (ЛЮЛИН)'),
	('04137', '68134', '27334', 'УЛ.НИКОЛАЙ ЛИЛИЕВ'),
	('04138', '68134', '27351', 'УЛ.533-ТА (СЛАТИНА)'),
	('04139', '68134', '27365', 'УЛ.БЯЛ НАРЦИС'),
	('04140', '68134', '27379', 'УЛ.582-РА (КВ.ЛЕВСКИ)'),
	('04141', '68134', '27437', 'УЛ.255-ТА (СЕРДИКА)'),
	('04142', '68134', '27440', 'УЛ.ИСКЪРСКО ШОСЕ'),
	('04143', '68134', '27468', 'УЛ.319-ТА (КРАСНА ПОЛЯНА)'),
	('04144', '68134', '27680', 'УЛ.770-ТА (ОВЧА КУПЕЛ)'),
	('04145', '68134', '27694', 'УЛ.НАРЦИС'),
	('04146', '68134', '28100', 'УЛ.601-ВА'),
	('04147', '68134', '28113', 'УЛ.612-ТА (ВИТОША)'),
	('04148', '68134', '28144', 'УЛ.БОЯНСКА ЛЕГЕНДА (610-ТА)'),
	('04149', '68134', '28189', 'УЛ.ЯНЬОВИЦА (609-ТА)'),
	('04150', '68134', '28336', 'УЛ.776-ТА (ВИТОША)'),
	('04151', '68134', '29012', 'УЛ.729-ТА (ВИТОША)'),
	('04152', '68134', '29035', 'УЛ.781-ВА (ВИТОША)'),
	('04153', '68134', '29129', 'УЛ.366-ТА (ВРЪБНИЦА)'),
	('04154', '68134', '29132', 'УЛ.275-ТА (ОБЕЛЯ)'),
	('04155', '68134', '29146', 'УЛ.273-ТА (ВРЪБНИЦА)'),
	('04156', '68134', '29150', 'УЛ.266-ТА (ОБЕЛЯ)'),
	('04157', '68134', '29163', 'УЛ.16-ТА (ОБЕЛЯ)'),
	('04158', '68134', '29180', 'УЛ.НОВО СЕЛО'),
	('04159', '68134', '30020', 'УЛ.5-002 (ИСКЪР)'),
	('04160', '68134', '30034', 'УЛ.ДИМИТЪР ПЕШЕВ'),
	('04161', '68134', '30048', 'УЛ.5-004 (ИСКЪР)'),
	('04162', '68134', '30079', 'УЛ.5-007 (ИСКЪР)'),
	('04163', '68134', '30082', 'УЛ.5-008 (ИСКЪР)'),
	('04164', '68134', '30096', 'УЛ.ПОРУЧИК НЕДЕЛЧО БОНЧЕВ'),
	('04165', '68134', '30106', 'УЛ.ПОРУЧИК ХРИСТО ТОПРАКЧИЕВ'),
	('04166', '68134', '30119', 'УЛ.ПОДПОРУЧИК ЙОРДАН ТОДОРОВ'),
	('04167', '68134', '30350', 'УЛ.5-036 (ИСКЪР)'),
	('04168', '68134', '30418', 'УЛ.СТОЯН ТЕРЗИЙСКИ (5-042)'),
	('04169', '68134', '30569', 'УЛ.579-ТА (КВ.ЛЕВСКИ)'),
	('04170', '68134', '30572', 'УЛ.580-ТА (КВ.ЛЕВСКИ)'),
	('04171', '68134', '30586', 'УЛ.ГЕРЕНО'),
	('04172', '68134', '30590', 'УЛ.ЕМБОРЕ'),
	('04173', '68134', '30606', 'УЛ.АЛЕКСАНДРОВСКА'),
	('04174', '68134', '30613', 'УЛ.КАЛИЯ'),
	('04175', '68134', '30627', 'УЛ.СТАРАТА ВОДЕНИЦА'),
	('04176', '68134', '30630', 'УЛ.ПРОСТОР'),
	('04177', '68134', '30644', 'УЛ.АЛИПИ АНДРЕЕВ'),
	('04178', '68134', '30658', 'УЛ.222-РА (ВРЪБНИЦА)'),
	('04179', '68134', '30692', 'УЛ.214-ТА (ВРЪБНИЦА)'),
	('04180', '68134', '30716', 'УЛ.228-МА (СЕРДИКА)'),
	('04181', '68134', '30733', 'УЛ.788-МА (ВИТОША)'),
	('04182', '68134', '30747', 'УЛ.614-ТА (ВИТОША)'),
	('04183', '68134', '30750', 'УЛ.ВЛ.ДИМИТРОВ-МАЙСТОРА (772)'),
	('04184', '68134', '30764', 'УЛ.773-ТА (ВИТОША)'),
	('04185', '68134', '30778', 'УЛ.ПРОЛЕТ (775-ТА)'),
	('04186', '68134', '30781', 'УЛ.ЧЕРЕШОВА ГРАДИНА'),
	('04187', '68134', '30795', 'УЛ.САЛЮТ'),
	('04188', '68134', '30805', 'УЛ.ПОЛЕТ'),
	('04189', '68134', '30822', 'УЛ.737-МА (ОВЧА КУПЕЛ)'),
	('04190', '68134', '30847', 'УЛ.ДИМИТЪР ШИШМАНОВ (752-РА)'),
	('04191', '68134', '30853', 'УЛ.741-ВА (ОВЧА КУПЕЛ)'),
	('04192', '68134', '30898', 'УЛ.777-МА (ВИТОША)'),
	('04193', '68134', '30911', 'УЛ.676-ТА (ОВЧА КУПЕЛ)'),
	('04194', '68134', '30925', 'УЛ.677-МА (ОВЧА КУПЕЛ)'),
	('04195', '68134', '30939', 'УЛ.ОРХИДЕЯ (753-ТА ОВ.КУПЕЛ)'),
	('04196', '68134', '30942', 'УЛ.754-ТА (ОВЧА КУПЕЛ)'),
	('04197', '68134', '30956', 'УЛ.742-РА (ОВЧА КУПЕЛ)'),
	('04198', '68134', '30973', 'УЛ.КИПАРИС (726-ТА)'),
	('04199', '68134', '31111', 'УЛ.143-ТА (ИЗГРЕВ)'),
	('04200', '68134', '31139', 'УЛ.157-МА'),
	('04201', '68134', '31142', 'УЛ.158-МА (ИЗГРЕВ)'),
	('04202', '68134', '31187', 'УЛ.170-ТА (ИЗГРЕВ)'),
	('04203', '68134', '31245', 'УЛ.753-ТА (ИЛИНДЕН)'),
	('04204', '68134', '31262', 'УЛ.151-ВА (ИЗГРЕВ)'),
	('04205', '68134', '31303', 'УЛ.ПРОФ.Д-Р ГАНЧО ГАНЕВ'),
	('04206', '68134', '31334', 'УЛ.131-ВА (ИЗГРЕВ)'),
	('04207', '68134', '31437', 'УЛ.384-ТА (ЛЮЛИН)'),
	('04208', '68134', '31440', 'УЛ.385-ТА (КРАСНА ПОЛЯНА)'),
	('04209', '68134', '31468', 'УЛ.МОДЕРНО ПРЕДГРАДИЕ'),
	('04210', '68134', '31499', 'УЛ.326-ТА (ЛЮЛИН)'),
	('04211', '68134', '31557', 'УЛ.383-ТА (ЛЮЛИН)'),
	('04212', '68134', '31588', 'УЛ.ДОБРИ НЕМИРОВ'),
	('04213', '68134', '31646', 'УЛ.746-ТА (КРАСНА ПОЛЯНА)'),
	('04214', '68134', '31657', 'УЛ.747-МА (ОВЧА КУПЕЛ)'),
	('04215', '68134', '31663', 'УЛ.748-МА (ОВЧА КУПЕЛ)'),
	('04216', '68134', '31680', 'УЛ.768-МА (КРАСНА ПОЛЯНА)'),
	('04217', '68134', '31704', 'УЛ.767-МА (КРАСНА ПОЛЯНА)'),
	('04218', '68134', '31718', 'УЛ.762-РА (КРАСНА ПОЛЯНА)'),
	('04219', '68134', '31721', 'УЛ.КРАИЩЕ (735-ТА)'),
	('04220', '68134', '31735', 'УЛ.259-ТА (СЕРДИКА)'),
	('04221', '68134', '32010', 'УЛ.БИГЛА'),
	('04222', '68134', '32161', 'УЛ.350-ТА (ВРЪБНИЦА)'),
	('04223', '68134', '32175', 'УЛ.ЛУИ ПАСТЬОР'),
	('04224', '68134', '32336', 'УЛ.ШИБОЙ'),
	('04225', '68134', '32353', 'УЛ.215-ТА (ВРЪБНИЦА)'),
	('04226', '68134', '32367', 'УЛ.221-ВА (ЛЮЛИН)'),
	('04227', '68134', '32398', 'УЛ.8-МИ ДЕКЕМВРИ'),
	('04228', '68134', '32411', 'УЛ.253-ТА (СЕРДИКА)'),
	('04229', '68134', '32439', 'УЛ.574-ТА (КВ.ЛЕВСКИ)'),
	('04230', '68134', '32442', 'УЛ.576-ТА (КВ.ЛЕВСКИ)'),
	('04231', '68134', '32456', 'УЛ.581-ВА (КВ.ЛЕВСКИ)'),
	('04232', '68134', '32737', 'УЛ.РИДО'),
	('04233', '68134', '32932', 'УЛ.ЗЕМЛЯНЕ'),
	('04234', '68134', '33619', 'УЛ.63-ТА (СТУДЕНТСКИ)'),
	('04235', '68134', '34299', 'УЛ.БОСИЛЕК'),
	('04236', '68134', '34326', 'УЛ.1-ВА (СТУДЕНТСКА)'),
	('04237', '68134', '35242', 'УЛ.333-ТА (ЛЮЛИН)'),
	('04238', '68134', '35537', 'УЛ.181-ВА (МЛАДОСТ)'),
	('04239', '68134', '35997', 'УЛ.105-ТА (СЛАТИНА)'),
	('04240', '68134', '36066', 'УЛ.301-ВА (КРАСНА ПОЛЯНА)'),
	('04241', '68134', '36302', 'УЛ.421-ВА (ТРИАДИЦА)'),
	('04242', '68134', '36823', 'УЛ.187-МА (КВ.МАЛ.ДОЛИНА)'),
	('04243', '68134', '40097', 'УЛ.РОСНА'),
	('04244', '68134', '40124', 'УЛ.111-ТА (МЛАДОСТ)'),
	('04245', '68134', '40155', 'УЛ.КОНСТАНТИН СТОИЛОВ'),
	('04246', '68134', '40186', 'УЛ.ПОСТОЯНСТВО'),
	('04247', '68134', '40195', 'УЛ.АЛФРЕД НОБЕЛ'),
	('04248', '68134', '40213', 'УЛ.ВЪЗРОЖДЕНСКА'),
	('04249', '68134', '40227', 'УЛ.БАБА НЕДЕЛЯ'),
	('04250', '68134', '40230', 'УЛ.СЪБОРНА'),
	('04251', '68134', '40302', 'УЛ.КРЪСТЮ РАКОВСКИ'),
	('04252', '68134', '40316', 'УЛ.ИЛИЯ БЕШКОВ'),
	('04253', '68134', '40333', 'УЛ.ВАСИЛ КАРАГЬОЗОВ'),
	('04254', '68134', '46084', 'УЛ.2-РА (КВ.МАЛ.ДОЛИНА)'),
	('04255', '68134', '46098', 'УЛ.3-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04256', '68134', '46111', 'УЛ.5-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04257', '68134', '46139', 'УЛ.7-МА (КВ.МАЛ.ДОЛИНА)'),
	('04258', '68134', '46160', 'УЛ.182-РА (КВ.МАЛ.ДОЛИНА)'),
	('04259', '68134', '46173', 'УЛ.184-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04260', '68134', '46187', 'УЛ.185-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04261', '68134', '46190', 'УЛ.186-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04262', '68134', '46200', 'УЛ.188-МА (КВ.МАЛ.ДОЛИНА)'),
	('04263', '68134', '46214', 'УЛ.189-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04264', '68134', '46228', 'УЛ.190-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04265', '68134', '46245', 'УЛ.192-РА (КВ.МАЛ.ДОЛИНА)'),
	('04266', '68134', '46351', 'УЛ.БОСИЛЕГРАД'),
	('04267', '68134', '46417', 'УЛ.ВОДЕНИЧНИЦА'),
	('04268', '68134', '46423', 'УЛ.БОЯНСКИ МАЙСТОР'),
	('04269', '68134', '46454', 'УЛ.ОСТРИЦА'),
	('04270', '68134', '46468', 'УЛ.КАМЕННО ЗДАНИЕ'),
	('04271', '68134', '46471', 'УЛ.МАРИНИ КРУШИ'),
	('04272', '68134', '46526', 'УЛ.АНДЕЗИТ'),
	('04273', '68134', '46532', 'УЛ.ДЕТСКИ МИР'),
	('04274', '68134', '46543', 'УЛ.СИРИ ДОЛ'),
	('04275', '68134', '46557', 'УЛ.МОМИНА МОГИЛА'),
	('04276', '68134', '46560', 'УЛ.ТРИЧКОВА МОГИЛА'),
	('04277', '68134', '46574', 'УЛ.698-МА (ВИТОША)'),
	('04278', '68134', '46591', 'УЛ.691-ВА (КРАСНО СЕЛО)'),
	('04279', '68134', '46601', 'УЛ.БАЛКАНСКА ВОЙНА'),
	('04280', '68134', '46629', 'УЛ.КИКИШ'),
	('04281', '68134', '46646', 'УЛ.СЪЛЗИЦА'),
	('04282', '68134', '46680', 'УЛ.УЧИТЕЛЯТ'),
	('04283', '68134', '46704', 'УЛ.БЕЛАТА ЧЕШМА'),
	('04284', '68134', '46718', 'УЛ.256-ТА (СЕРДИКА)'),
	('04285', '68134', '46735', 'УЛ.183-ТА (КВ.МАЛ.ДОЛИНА)'),
	('04286', '68134', '35585', 'УЛ.5 (ТОЛЕВА МАХАЛА)'),
	('04287', '68134', '51634', 'УЛ.СЛЪНЦЕ'),
	('04288', '68134', '57323', 'БУЛ.ЦАРИЦА ЙОАННА'),
	('04289', '68134', '59642', 'БУЛ.ДЖАВАХАРЛАЛ НЕРУ'),
	('04290', '68134', '60006', 'БУЛ.АЛЕКСАНДЪР СТАМБОЛИЙСКИ'),
	('04291', '68134', '60012', 'БУЛ.РОЖЕН'),
	('04292', '68134', '60037', 'БУЛ.ДЖЕЙМС БАУЧЕР'),
	('04293', '68134', '60040', 'БУЛ.ЕВРОПА'),
	('04294', '68134', '60054', 'БУЛ.БОТЕВГРАДСКО ШОСЕ'),
	('04295', '68134', '60068', 'БУЛ.БРАТЯ БЪКСТОН'),
	('04296', '68134', '60085', 'УЛ.КОСТЕНСКИ ВОДОПАД'),
	('04297', '68134', '60099', 'БУЛ.ВИТОША'),
	('04298', '68134', '60109', 'БУЛ.ВЛАДИМИР ВАЗОВ'),
	('04299', '68134', '60112', 'БУЛ.ЦАРИГРАДСКО ШОСЕ'),
	('04300', '68134', '60126', 'БУЛ.ВОЛГОГРАД'),
	('04301', '68134', '60138', 'БУЛ.ВЪЛЧО ИВАНОВ'),
	('04302', '68134', '60143', 'БУЛ.Г.М.ДИМИТРОВ'),
	('04303', '68134', '60157', 'БУЛ.ЯНКО САКЪЗОВ'),
	('04304', '68134', '60160', 'БУЛ.ГЕНЕРАЛ СКОБЕЛЕВ'),
	('04305', '68134', '60174', 'БУЛ.КНЯГИНЯ МАРИЯ ЛУИЗА'),
	('04306', '68134', '60188', 'БУЛ.СТЕФАН СТАМБОЛОВ'),
	('04307', '68134', '60191', 'БУЛ.ГЕОРГИ ТРАЙКОВ'),
	('04308', '68134', '60215', 'БУЛ.ЦАР БОРИС III'),
	('04309', '68134', '60229', 'БУЛ.МАКЕДОНИЯ'),
	('04310', '68134', '60232', 'БУЛ.КНЯЗ АЛ.ДОНДУКОВ-КОРСАКОВ'),
	('04311', '68134', '60246', 'БУЛ.ДРАГАН ЦАНКОВ'),
	('04312', '68134', '60253', 'БУЛ.ЕВЛОГИ И ХРИСТО ГЕОРГИЕВИ'),
	('04313', '68134', '60263', 'УЛ.ДОБРИНОВА СКАЛА'),
	('04314', '68134', '60277', 'БУЛ.ГОЦЕ ДЕЛЧЕВ'),
	('04315', '68134', '60280', 'БУЛ.ЕРНСТ ТЕЛМАН'),
	('04316', '68134', '60294', 'БУЛ.КЛЕМЕНТ ГОТВАЛД'),
	('04317', '68134', '60304', 'БУЛ.КОНСТАНТИН ВЕЛИЧКОВ'),
	('04318', '68134', '60318', 'БУЛ.ИЛИЯНЦИ'),
	('04319', '68134', '60321', 'БУЛ.ХРИСТОФОР КОЛУМБ'),
	('04320', '68134', '60335', 'БУЛ.ПЕТКО Ю.ТОДОРОВ'),
	('04321', '68134', '60349', 'БУЛ.НИКОЛА Й.ВАПЦАРОВ'),
	('04322', '68134', '60352', 'УЛ.ЛЮЛИН ПЛАНИНА'),
	('04323', '68134', '60366', 'БУЛ.ОВЧА КУПЕЛ'),
	('04324', '68134', '60379', 'БУЛ.ПРОФ.НИКОЛА МИЛЕВ'),
	('04325', '68134', '60383', 'БУЛ.ПАТРИАРХ ЕВТИМИЙ'),
	('04326', '68134', '60397', 'БУЛ.ПЕЙО К.ЯВОРОВ'),
	('04327', '68134', '60407', 'БУЛ.ПЕНЧО СЛАВЕЙКОВ'),
	('04328', '68134', '60410', 'БУЛ.ПЕТКО КАРАВЕЛОВ'),
	('04329', '68134', '60424', 'БУЛ.НИКОЛА ПЕТКОВ'),
	('04330', '68134', '60438', 'БУЛ.ЗАХАРИ СТОЯНОВ'),
	('04331', '68134', '60441', 'БУЛ.ПРАГА'),
	('04332', '68134', '60455', 'БУЛ.ЦАР ОСВОБОДИТЕЛ'),
	('04333', '68134', '60469', 'БУЛ.СЛИВНИЦА'),
	('04334', '68134', '60472', 'БУЛ.СТАНКЕ ДИМИТРОВ'),
	('04335', '68134', '60500', 'БУЛ.ВЪЗКРЕСЕНИЕ'),
	('04336', '68134', '60527', 'БУЛ.ХРИСТО БОТЕВ'),
	('04337', '68134', '60530', 'БУЛ.СИТНЯКОВО'),
	('04338', '68134', '60544', 'БУЛ.ХРИСТО СМИРНЕНСКИ'),
	('04339', '68134', '60558', 'БУЛ.ГЕНЕРАЛ ДАНАИЛ НИКОЛАЕВ'),
	('04340', '68134', '60561', 'БУЛ.ВАРДАР'),
	('04341', '68134', '60602', 'БУЛ.АЛЕКСАНДЪР ПУШКИН'),
	('04342', '68134', '60616', 'БУЛ.БЪЛГАРИЯ'),
	('04343', '68134', '60625', 'БУЛ.ИНЖ.ИВАН ИВАНОВ'),
	('04344', '68134', '60633', 'БУЛ.КЛИМЕНТ ОХРИДСКИ'),
	('04345', '68134', '60705', 'БУЛ.АЛ.МАЛИНОВ'),
	('04346', '68134', '61635', 'УЛ.ГЕНЕРАЛ КИРИЛ БОТЕВ'),
	('04347', '68134', '62517', 'БУЛ.ВАСИЛ ЛЕВСКИ'),
	('04348', '68134', '66041', 'БУЛ.ЛОМСКО ШОСЕ'),
	('04349', '68134', '66069', 'БУЛ.МАДРИД'),
	('04350', '68134', '70038', 'ПЛ.БАБА НЕДЕЛЯ'),
	('04351', '68134', '70055', 'ПЛ.ВЕЛЧОВА ЗАВЕРА'),
	('04352', '68134', '70069', 'ПЛ.СВЕТА НЕДЕЛЯ'),
	('04353', '68134', '70072', 'ПЛ.ВЪЗРАЖДАНЕ'),
	('04354', '68134', '70099', 'ПЛ.ДЖУЗЕПЕ ГАРИБАЛДИ'),
	('04355', '68134', '70113', 'ПЛ.ЖУРНАЛИСТ'),
	('04356', '68134', '70130', 'ПЛ.ЛЪВОВ МОСТ'),
	('04357', '68134', '70144', 'ПЛ.НАРОДНО СЪБРАНИЕ'),
	('04358', '68134', '70192', 'ПЛ.ПЕТКО Р.СЛАВЕЙКОВ'),
	('04359', '68134', '70233', 'ПЛ.РАЙКО ДАСКАЛОВ'),
	('04360', '68134', '70247', 'ПЛ.РОДИНА'),
	('04361', '68134', '70281', 'ПЛ.СБОРИЩЕ'),
	('04362', '68134', '70295', 'ПЛ.ПАПА ЙОАН ПАВЕЛ II'),
	('04363', '68134', '70305', 'ПЛ.СРЕД СЕЛО'),
	('04364', '68134', '70322', 'УЛ.ЯСЕН'),
	('04365', '68134', '70832', 'ПЛ.ПИЪРС О\'МАХОНИ'),
	('04366', '68134', '35599', 'УЛ.ПРОФ.КРЪСТЬО МИРСКИ'),
	('04367', '68134', '35609', 'УЛ.ВАСКО АБАДЖИЕВ'),
	('04368', '68134', '35612', 'УЛ.МЛАДЕН ПАВЛОВ'),
	('04369', '68134', '35626', 'УЛ.ВЛАДИМИР ВАСИЛЕВ'),
	('04370', '68134', '35630', 'УЛ.АКАД.МИХАИЛ МАДЖАРОВ'),
	('04371', '68134', '90026', 'УЛ.ГОЛЯМА МОГИЛА'),
	('04372', '68134', '90074', 'УЛ.ДЪБЕТО'),
	('04373', '68134', '35691', 'УЛ.ПРЕСЛАВСКА ПЛАНИНА'),
	('04374', '68134', '35701', 'УЛ.РАВНОГОР'),
	('04375', '68134', '35715', 'УЛ.АКАДЕМИЧНА'),
	('04376', '68134', '05685', 'УЛ.МАЛКОТО КОПИТО'),
	('04377', '68134', '46807', 'УЛ.УНИВЕРСИТЕТСКИ ПАРК'),
	('04378', '68134', '07733', 'УЛ.ЙОРДАН РАДИЧКОВ'),
	('04379', '68134', '45051', 'УЛ.Д-Р НИКОЛАЙ П.НИКОЛАЕВ'),
	('04380', '68134', '46904', 'УЛ.ЛОКОМОТИВ'),
	('04381', '68134', '20345', 'УЛ.ЕФРЕМ КАРАНФИЛОВ'),
	('04382', '68134', '20434', 'УЛ.АНДРЕЙ ГЕРМАНОВ'),
	('04383', '68134', '20465', 'УЛ.ГЕОРГИ КАРАСЛАВОВ'),
	('04384', '68134', '20514', 'УЛ.ДОБРИ ЖОТЕВ'),
	('04385', '68134', '05935', 'УЛ.Д-Р БОРИС ВЪЛЧЕВ'),
	('04386', '68134', '18143', 'УЛ.ФЕНИКС'),
	('04387', '68134', '00984', 'УЛ.БАКУ'),
	('04388', '68134', '13665', 'УЛ.ПРОФ.ПЕТЪР ДЖИДРОВ'),
	('04389', '68134', '13679', 'УЛ.ПРОФ.НИКОЛАЙ ГЕНЧЕВ'),
	('04390', '68134', '13980', 'УЛ.ПРОФ.ВИТАЛИ ТАДЖЕР'),
	('04391', '68134', '14427', 'УЛ.ГЕН.ВЛАДИМИР СТОЙЧЕВ'),
	('04392', '68134', '14595', 'УЛ.АКАД.АНГЕЛ БАЛЕВСКИ'),
	('04393', '68134', '04042', 'УЛ.ГЕН.КОНСТ.КОНСТАНТИНОВ'),
	('04394', '68134', '04635', 'УЛ.ГРИГОРИЙ ГОРБАТЕНКО'),
	('04395', '68134', '18023', 'УЛ.ФИЛИП АВРАМОВ'),
	('04396', '68134', '00330', 'УЛ.АКАД.ИВАН БУРЕШ'),
	('04397', '68134', '00391', 'УЛ.АРАРАТ'),
	('04398', '68134', '15179', 'УЛ.РИККАРДО ВАККАРИНИ'),
	('04399', '68134', '03745', 'УЛ.ВЪРТОПО'),
	('04400', '68134', '07185', 'УЛ.ИВАН БАГРЯНОВ'),
	('04401', '68134', '08293', 'УЛ.КОЦЕ ЦИПУШЕВ'),
	('04402', '68134', '12276', 'УЛ.НИКОЛАЙ ХАЙТОВ'),
	('04403', '68134', '05699', 'УЛ.Д-Р СОФИЯ АВРАМОВА'),
	('04404', '68134', '05726', 'УЛ.Д-Р ПЕТЪР ДИМКОВ'),
	('04405', '68134', '08471', 'УЛ.КЕДЪР'),
	('04406', '68134', '15477', 'УЛ.САКАР ПЛАНИНА'),
	('04407', '68134', '15566', 'УЛ.САША ПОПОВ'),
	('04408', '68134', '05061', 'УЛ.ДВЕ ЛИПИ'),
	('04409', '68134', '40347', 'УЛ.ПОЛКОВНИК ХРИСТО АРНАУДОВ'),
	('04410', '68134', '40350', 'УЛ.ПРОФ.КОНСТАНТИН ЧИЛОВ'),
	('04411', '68134', '01050', 'УЛ.АКАД.ЙОРДАН ТРИФОНОВ'),
	('04412', '68134', '08499', 'УЛ.КИРИЛ БУЮКЛИЙСКИ'),
	('04413', '68134', '15936', 'УЛ.СВЕТИ САВА'),
	('04414', '68134', '06094', 'УЛ.Д-Р АТАНАС МОСКОВ'),
	('04415', '68134', '06776', 'УЛ.ЗОГРАФИНА'),
	('04416', '68134', '04649', 'УЛ.ГУСЛА'),
	('04417', '68134', '02779', 'УЛ.ВАСИЛ РАДОСЛАВОВ'),
	('04418', '68134', '07449', 'УЛ.ИЗТОЧНА ТАНГЕНТА'),
	('04419', '68134', '11845', 'УЛ.НИКОЛА ГЕНАДИЕВ'),
	('04420', '68134', '18486', 'УЛ.ФИЛИП КУТЕВ'),
	('04421', '68134', '16599', 'УЛ.СЛЬНЧОГЛЕД'),
	('04422', '68134', '18527', 'УЛ.ФЛОРА КЪНЕВА'),
	('04423', '68134', '01170', 'УЛ.БЕЛ КАМЬК'),
	('04424', '68134', '01184', 'УЛ.ГЕРГЬОВДЕН'),
	('04425', '68134', '35105', 'УЛ.СРЕБЪРНА'),
	('04426', '68134', '60650', 'БУЛ.Д-Р ПЕТЪР ДЕРТЛИЕВ'),
	('04427', '68134', '04858', 'УЛ.Д-Р ЙОРДАН ЙОСИФОВ'),
	('04428', '68134', '17230', 'УЛ.СТРАНДЖАТА'),
	('04429', '68134', '10402', 'УЛ.МАГНАУРСКА ШКОЛА'),
	('04430', '68134', '70041', 'ПЛ.ЮРИ БУКОВ'),
	('04431', '68134', '01969', 'УЛ.БУЕНОС АЙРЕС'),
	('04432', '68134', '01420', 'УЛ.АЛЕКСАНДЪР ГЕРОВ'),
	('04433', '68134', '01434', 'УЛ.АРХ.ФРАНК ЛОЙД РАЙТ'),
	('04434', '68134', '15182', 'УЛ.ПЪСТРОЦВЕТНА'),
	('04435', '68134', '15223', 'УЛ.ЧЕРЕШОВО ДЪРВО'),
	('04436', '68134', '13250', 'УЛ.ПЕТЪР ПАПАКОЧЕВ'),
	('04437', '68134', '85090', 'УЛ.ЛЪВСКИ РИД'),
	('04438', '68134', '19159', 'УЛ.ЛЕСКОВА ГОРА'),
	('04439', '68134', '95162', 'УЛ.ПРОФ.Д-Р АЛ.ТЕОДОРОВ-БАЛАН'),
	('04440', '68134', '95176', 'УЛ.ПЕТЪР ПРОТИЧ'),
	('04441', '68134', '95181', 'УЛ.ПРОФ.Д-Р ВАСИЛ ЗЛАТАРСКИ'),
	('04442', '68134', '95193', 'УЛ.АЛЕКСАНДЪР ПАСКАЛЕВ'),
	('04443', '68134', '95203', 'УЛ.БОЖАН АНГЕЛОВ'),
	('04444', '68134', '95217', 'УЛ.БОРИС НИКОЛОВ КОВАЧЕВ'),
	('04445', '68134', '13264', 'УЛ.ЛАЗАРИЦА'),
	('04446', '68134', '30212', 'УЛ.5010'),
	('04447', '68134', '38087', 'УЛ.ПЪСТЪР СВЯТ'),
	('04448', '68134', '29996', 'УЛ.СМЕСНА КИТКА'),
	('04449', '68134', '29951', 'УЛ.ВИСАРИОН БЕЛИНСКИ'),
	('04450', '68134', '29965', 'УЛ.ПРОДАН ТАРАКЧИЕВ'),
	('04451', '68134', '29979', 'УЛ.ЮРИЙ ЗАХАРЧУК'),
	('04452', '68134', '35119', 'УЛ.ПРОФ.МАРКО СЕМОВ'),
	('04453', '68134', '34816', 'УЛ.МРАМОРСКО ШОСЕ'),
	('04454', '68134', '61916', 'БУЛ.ПАНЧО ВЛАДИГЕРОВ'),
	('04455', '68134', '37383', 'УЛ.СИНАНИШКО ЕЗЕРО'),
	('04456', '68134', '39935', 'УЛ.БОРИС ДИМОВСКИ'),
	('04457', '68134', '30003', 'УЛ.ШОПСКА КИТКА'),
	('04458', '68134', '46406', 'УЛ.БОЯНЕЦ'),
	('04459', '68134', '19056', 'УЛ.ПРОФ.МИЛЧО ЛАЛКОВ'),
	('04460', '68134', '95457', 'УЛ.АБАНОС'),
	('04461', '68134', '20290', 'УЛ.АКАД.НИКОЛАЙ СТОЯНОВ'),
	('04462', '68134', '66229', 'БУЛ.РАЙКО ДАСКАЛОВ'),
	('04463', '68134', '66055', 'БУЛ.АНДРЕЙ ЛЯПЧЕВ(УНИВЕРСИАДА)'),
	('04464', '68134', '60023', 'БУЛ.АСЕН ЙОРДАНОВ (ХО ШИ МИН)'),
	('04465', '68134', '16208', 'БУЛ.МИХАЙ ЕМИНЕСКУ (СИТНЯКОВО)'),
	('04466', '68134', '12694', 'БУЛ.ПРЕЗИДЕНТ ЛИНКЪЛН'),
	('04467', '68134', '36004', 'УЛ.106-ТА (ОБЕЛЯ)'),
	('04468', '68134', '20239', 'УЛ.109-ТА (ЛЮЛИН)'),
	('04469', '68134', '46259', 'УЛ.191-ВА (КВ.МАЛ.ДОЛИНА МЛАДО'),
	('04470', '68134', '22294', 'УЛ.315 А (КРАСНА ПОЛЯНА)'),
	('04471', '68134', '30140', 'УЛ.5-015 (ИСКЪР)'),
	('04472', '68134', '25570', 'УЛ.654-ТА (ВИТОША)'),
	('04473', '68134', '25793', 'УЛ.684-ТА (ВИТОША)'),
	('04474', '68134', '26034', 'УЛ.689-ТА (ВИТОША)'),
	('04475', '68134', '26003', 'УЛ.705-ТА (ЛЮЛИН)'),
	('04476', '68134', '26781', 'УЛ.743-ТА (ГОРНА БАНЯ)'),
	('04477', '68134', '26819', 'УЛ.765-ТА (ОВЧА КУПЕЛ)'),
	('04478', '68134', '27019', 'УЛ.АКАД.БОРИС СТЕФАНОВ'),
	('04479', '68134', '23577', 'УЛ.АКАД.ГЕОРГИ НАДЖАКОВ (410)'),
	('04480', '68134', '20287', 'УЛ.АКАД.ДМИТРИЙ ЛИХАЧОВ (2-РА)'),
	('04481', '68134', '23889', 'УЛ.АКАД.ПЕТЪР ДИНЕКОВ (445-ТА)'),
	('04482', '68134', '05092', 'УЛ.АЛДОМИРОВСКА'),
	('04483', '68134', '24195', 'УЛ.АСЕН НАЙДЕНОВ (493)'),
	('04484', '68134', '46365', 'УЛ.БАНИШКА РЕКА(193-ТА МЛАДОСТ'),
	('04485', '68134', '17302', 'УЛ.БАТОЛОВА ВОДЕНИЦА(ТЕМ.НЕНКО'),
	('04486', '68134', '01362', 'УЛ.БИСЕРНО ИЗВОРЧЕ(ГОРНА БАНЯ)'),
	('04487', '68134', '03335', 'УЛ.БЛАГА ДИМИТРОВА(ВЛ.ТРИЧКОВ)'),
	('04488', '68134', '25272', 'УЛ.БОЯНСКА КИТКА (625-ТА)'),
	('04489', '68134', '04697', 'УЛ.БРАТЯ ЧАКРИН (438-МА)'),
	('04490', '68134', '14708', 'УЛ.БУЛИНА ЛИВАДА (Р.ПЕТКОВ)'),
	('04491', '68134', '03174', 'УЛ.ВЕЧЕРНА ПРОХЛАДА (Г.БАНЯ)'),
	('04492', '68134', '25344', 'УЛ.ВИТОШКО ЛАЛЕ (635-ТА)'),
	('04493', '68134', '01211', 'УЛ.ВЪРБА (БОЯНА)'),
	('04494', '68134', '25478', 'УЛ.ГАБРОВНИЦА (639-ТА)'),
	('04495', '68134', '07079', 'УЛ.ГЕН.АСЕН НИКОЛОВ (ИВ.БОТЕВ)'),
	('04496', '68134', '24150', 'УЛ.ГЕН.ИВАН КОЛЕВ (489)'),
	('04497', '68134', '17912', 'УЛ.ГЕН.КОСТА ГЕОРГИЕВ(УДАРНИК)'),
	('04498', '68134', '01660', 'УЛ.ГЕН.КОСТА НИКОЛОВ(БОЛШЕВИК)'),
	('04499', '68134', '06851', 'УЛ.ГЕН.МИХАИЛ САВОВ(БИЖО БАКАЛ'),
	('04500', '68134', '13408', 'УЛ.ГЕН.НИКОЛА ЖЕКОВ(П.ТОДОРОВА'),
	('04501', '68134', '15597', 'УЛ.ГЕНО КИРОВ (САМОЛЕТ)'),
	('04502', '68134', '26572', 'УЛ.ГЕОРГИ ВОЙТЕХ (734-ТА)'),
	('04503', '68134', '46142', 'УЛ.ГЕОРГИ КЬОСЕИВАНОВ (8-МА)'),
	('04504', '68134', '04981', 'УЛ.ГЕОРГИ МИНЧЕВ(ДЕЧО СТЕФАНОВ'),
	('04505', '68134', '17155', 'УЛ.ГЕОРГИ СПАСОВ (СЪБИ ДИЧЕВ)'),
	('04506', '68134', '31098', 'УЛ.Д-Р Г.АТАНАСОВИЧ (115-ТА)'),
	('04507', '68134', '06029', 'УЛ.ДИАМАНТ (ГОРНА БАНЯ)'),
	('04508', '68134', '00388', 'УЛ.ДИМИТЪР ГОРОВ(АНА МАЙМУНКОВ'),
	('04509', '68134', '00103', 'УЛ.ДИМИТЪР МОЛЛОВ'),
	('04510', '68134', '04114', 'УЛ.ДИМИТЪР ТЪРКАЛАНОВ(КАП.Д.СП'),
	('04511', '68134', '05431', 'УЛ.ДОБРИ ХРИСТОВ (421-ВА)'),
	('04512', '68134', '02600', 'УЛ.ДЯКОН ИГНАТИЙ(ВАСИЛ ЛЕВСКИ)'),
	('04513', '68134', '46156', 'УЛ.ЕВГЕНИЙ СИЛЯНОВ (9-ТА)'),
	('04514', '68134', '24164', 'УЛ.ЕМИЛИЯН СТАНЕВ (490-ТА)'),
	('04515', '68134', '20198', 'УЛ.ЕФРЕМ ЧУЧКОВ (1-ВА ОБЕЛЯ)'),
	('04516', '68134', '26507', 'УЛ.ЗЕЛЕНИКА (743-ТА)'),
	('04517', '68134', '27485', 'УЛ.ИВАН БОЙЧЕВ (КОРЕНЯК)'),
	('04518', '68134', '07658', 'УЛ.ИГЛИКА (ГОРНА БАНЯ)'),
	('04519', '68134', '07572', 'УЛ.ИЗВОР (ВРЪБНИЦА)'),
	('04520', '68134', '46070', 'УЛ.ИНЖ.СТОИМЕН САРАФОВ (1-ВА)'),
	('04521', '68134', '00919', 'УЛ.КАП.НИКОЛА БОЖКОВ(КР.САМОХО'),
	('04522', '68134', '16465', 'УЛ.КНЯЗ АЛЕКСАНДЪР I(АЛ.БАТЕНБ'),
	('04523', '68134', '46108', 'УЛ.КОНСТАНТИН МУРАВИЕВ (4-ТА)'),
	('04524', '68134', '11185', 'УЛ.КОНЬОВИЦА (МИКО ПАПО)'),
	('04525', '68134', '12365', 'УЛ.КУБАН (ЦАРЕВО СЕЛО НИК.ЗАНЕ'),
	('04526', '68134', '25536', 'УЛ.КУКУРЯК (651-ВА)'),
	('04527', '68134', '31632', 'УЛ.КЪРПИКОЖУХ (744-ТА)'),
	('04528', '68134', '09843', 'УЛ.ЛАЗУР (ГОРНА БАНЯ)'),
	('04529', '68134', '25553', 'УЛ.ЛЕДЕНЧЕ (652-РА)'),
	('04530', '68134', '09929', 'УЛ.ЛИЛЯЧЕ (ЛИЗА КАЛО)'),
	('04531', '68134', '06269', 'УЛ.МАГДА ПЕТКАНОВА(ЕМ.ПУГАЧОВ)'),
	('04532', '68134', '46276', 'УЛ.МАЕСТРО МИХАИЛ МИЛКОВ(102-Р'),
	('04533', '68134', '23621', 'УЛ.МАЙОР ПАВЕЛ ПАВЛОВ (416)'),
	('04534', '68134', '25687', 'УЛ.МАЙСТОР АЛЕКСИ РИЛЕЦ (664)'),
	('04535', '68134', '25700', 'УЛ.МАЙСТОР Д.СОФИЯНЛИЯТА (666)'),
	('04536', '68134', '25714', 'УЛ.МАЙСТОР МИЛ.РАДОМИРЕЦ( 667)'),
	('04537', '68134', '25690', 'УЛ.МАЙСТОР ПАВЕЛ ОТ КРИМИН(665'),
	('04538', '68134', '24205', 'УЛ.МАНФРЕД ВЬОРНЕР (495)'),
	('04539', '68134', '26675', 'УЛ.МЕСЕЧИНКА (745-ТА)'),
	('04540', '68134', '07274', 'УЛ.МИМИ БАЛКАНСКА(ИВ.НЕД.-ШАБЛ'),
	('04541', '68134', '25549', 'УЛ.МИТР.СЕРАФИМ СЛИВЕНСКИ'),
	('04542', '68134', '24219', 'УЛ.МИЧМАН ТОДОР САЕВ (496)'),
	('04543', '68134', '30051', 'УЛ.МЮНХЕН (5-005)'),
	('04544', '68134', '12019', 'УЛ.НЕВЕН (ГОРНА БАНЯ)'),
	('04545', '68134', '11987', 'УЛ.НЕСТИНАРКА (Г.БАНЯ)'),
	('04546', '68134', '12783', 'УЛ.ОБЕЛСКИ ПЪТ (ОБ.ШОСЕ)'),
	('04547', '68134', '04529', 'УЛ.ПАРТЕНИЙ ЗОГРАФСКИ (ГРАНИТ)'),
	('04548', '68134', '18126', 'УЛ.ПОЛК.СТОЙНО БАЧИЙСКИ'),
	('04549', '68134', '00669', 'УЛ.ПРЕЛОМ (АСЕН ХАЛАЧЕВ)'),
	('04550', '68134', '13473', 'УЛ.ПРОЛЕТ (БОЯНА)'),
	('04551', '68134', '23798', 'УЛ.ПРОФ.ВАСИЛ СТОИН (440-ТА)'),
	('04552', '68134', '25358', 'УЛ.ПРОФ.ДОЧО ЛЕКОВ (636)'),
	('04553', '68134', '24116', 'УЛ.ПРОФ.МАРИН ГОЛЕМИНОВ (485)'),
	('04554', '68134', '04460', 'УЛ.ПРОФ.ПЕТЪР МУТАФЧИЕВ'),
	('04555', '68134', '11644', 'УЛ.ПРОФ.ЦВЕТАН ЛАЗАРОВ'),
	('04556', '68134', '16732', 'УЛ.ПРОФ.ЯНАКИ МОЛЛОВ (СТАЧНИК)'),
	('04557', '68134', '17542', 'УЛ.РИЛА (14-ТА ОБЕЛЯ)'),
	('04558', '68134', '27084', 'УЛ.РОСАРИО (ПР.ХАДЖИХРИСТОВ)'),
	('04559', '68134', '08512', 'УЛ.СВ.КЛИМЕНТ ОХРИДСКИ'),
	('04560', '68134', '10094', 'УЛ.СВ.НИКОЛАЙ ЧУДОТВОРЕЦ'),
	('04561', '68134', '00953', 'УЛ.СВЕТА МАРИНА (БАНДЕРА)'),
	('04562', '68134', '09408', 'УЛ.СВЕТИ КИПРИЯН'),
	('04563', '68134', '46125', 'УЛ.СТАНИМИР СТАНИМИРОВ (6-ТА)'),
	('04564', '68134', '25567', 'УЛ.ТЕМЕНУЖКА (653-ТА)'),
	('04565', '68134', '27454', 'УЛ.ТЕОДОР ТЕОДОРОВ (СВ.БЪДЕЩЕ)'),
	('04566', '68134', '23635', 'УЛ.ТОДОР ДЖЕБАРОВ (417)'),
	('04567', '68134', '17837', 'УЛ.ТРЪНСКИ МАЙСТОР(ТРЪН.ОТРЯД)'),
	('04568', '68134', '24236', 'УЛ.ХЕНРИК ИБСЕН (СРЕБЪРНА)'),
	('04569', '68134', '23306', 'УЛ.ХРИСТО ФОТЕВ (391-ВА ЛЮЛИН)'),
	('04570', '68134', '20050', 'УЛ.ЯСНО УТРО (ГОРНА БАНЯ)'),
	('04571', '68134', '00254', 'УЛ.КОЗЯК (АЛЕКСАНДЪР КОСТОВ)'),
	('04572', '68134', '29177', 'УЛ.КРАКРА (ЕВЛОГИ ГЕОРГИЕВ)'),
	('04573', '68134', '05124', 'УЛ.РУСОКАСТРО (ГЕН.Д.ГРЪБЧЕВ)'),
	('04574', '68134', '58863', 'УЛ.ЯВОР (ВИТОША)'),
	('04575', '68134', '00179', 'УЛ.АЛАБИН И.ВЛ.'),
	('04576', '68134', '01417', 'УЛ.БЕТХОВЕН Л.В.'),
	('04577', '68134', '05760', 'УЛ.ДОСТОЕВСКИ Ф.М.'),
	('04578', '68134', '20033', 'УЛ.ЯНКО СОФ.ВОЙВОДА'),
	('04579', '68134', '69780', 'БУЛ.КОПЕНХАГЕН'),
	('04580', '68134', '46231', 'УЛ.ПРОФ.КИРИЛ ПОПОВ(ВЪРБАН ГЕН'),
	('04581', '68134', '22383', 'УЛ.ВАСКА БАЛАРЕВА'),
	('04582', '68134', '11627', 'УЛ.НИКОЛА МАВРОДИЕВ'),
	('04583', '68134', '13562', 'УЛ.ПРОФ.АЛЕКСАНДЪР ФОЛ'),
	('04584', '68134', '13603', 'УЛ.ПРОФ.РАШО РАШЕВ'),
	('04585', '68134', '27036', 'УЛ.АКАД.МИХАИЛ АРНАУДОВ'),
	('04586', '68134', '17680', 'УЛ.ТОДОР Ф.ЧИПЕВ'),
	('04587', '68134', '19902', 'УЛ.ПРОФ.ЖЕЧО АТАНАСОВ'),
	('04588', '68134', '76056', 'ПЛ.ПОЗИТАНО'),
	('04589', '68134', '35732', 'УЛ.ЙОСИФ БРАДАТИ'),
	('04590', '68134', '35756', 'УЛ.УТРО (КНЯЖЕВО)'),
	('04591', '68134', '35777', 'УЛ.736-ТА (КРАСНА ПОЛЯНА)'),
	('04592', '68134', '35780', 'УЛ.АКАД.ЧУДОМИР НАЧЕВ'),
	('04593', '68134', '35794', 'УЛ.МИХАИЛ ТЕНЕВ'),
	('04594', '68134', '35804', 'УЛ.БОЯН ДАМЯНОВ'),
	('04595', '68134', '35818', 'УЛ.ПЕТКО НАУМОВ'),
	('04596', '68134', '35835', 'УЛ.ГЕНЕРАЛ ЙОРДАН ВЕНЕДИКОВ'),
	('04597', '68134', '35849', 'УЛ.ПРОФ.Д-Р ДИМИТЪР ДОБРЕВ'),
	('04598', '68134', '35852', 'УЛ.АКАД.ВЕРА МУТАФЧИЕВА'),
	('04599', '68134', '35866', 'УЛ.ИНЖ.НИКОЛА ДИМКОВ'),
	('04600', '68134', '35969', 'УЛ.ДИМИТЪР МАНЧЕВ'),
	('04601', '68134', '35871', 'УЛ.ПЕТЪР КАРАПЕТРОВ'),
	('04602', '68134', '35883', 'УЛ.ЛЕБЕД'),
	('04603', '68134', '35897', 'УЛ.ДИМИТЪР САГАЕВ'),
	('04604', '68134', '35972', 'УЛ.ПРОФ.ИВАН СПАСОВ'),
	('04605', '68134', '35986', 'УЛ.ФРЕДЕРИК ШОПЕН'),
	('04606', '68134', '18620', 'УЛ.ХРИСТО СТОЯНОВ'),
	('04607', '68134', '36169', 'УЛ.ФРАНСОА МИТЕРАН'),
	('04608', '68134', '36155', 'УЛ.ГЕОРГИ ТУТЕВ'),
	('04609', '68134', '36141', 'УЛ.ИВАН ПАНТАЛЕЕВ'),
	('04610', '68134', '36138', 'УЛ.ДИМИТЪР ДЮЛГЕРОВ'),
	('04611', '68134', '36186', 'УЛ.ВИЛИ КАЗАСЯН'),
	('04612', '68134', '36194', 'УЛ.СВЕТОСЛАВ МИНКОВ'),
	('04613', '68134', '36200', 'УЛ.КОНЧЕ ВИХРОГОНЧЕ'),
	('04614', '68134', '36213', 'УЛ.ПРОФ.Д-Р КОСТА СТОЯНОВ'),
	('04615', '68134', '36227', 'УЛ.ЮРИЙ БУКОВ'),
	('04616', '68134', '36230', 'УЛ.МАРИНЧО БЕНЛИ'),
	('04617', '68134', '36083', 'УЛ.ТИШИНА'),
	('04618', '68134', '36244', 'УЛ.ВЕЙНИЧЕ (ГОРНА БАНЯ)'),
	('04619', '68134', '36258', 'УЛ.ВАСИЛ СТЕФАНОВ'),
	('04620', '68134', '36261', 'УЛ.СВЕТО ПРЕОБРАЖЕНИЕ'),
	('04621', '68134', '36275', 'УЛ.ЦВЕТНА'),
	('04622', '68134', '36107', 'УЛ.ЖИВИ КАМЪЧЕТА'),
	('04623', '68134', '36097', 'УЛ.СИБИРСКИ СИНЧЕЦ'),
	('04624', '68134', '36289', 'УЛ.ПРОФ.ПЕТЪР ШАПКАРЕВ'),
	('04625', '68134', '36292', 'УЛ.ПОРУЧИК ГЕОРГИ КЮМЮРДЖИЕВ'),
	('04626', '68134', '37246', 'УЛ.МАЛОБУЧИНСКИ ПЪТ'),
	('04627', '68134', '37250', 'УЛ.КОНСТАНТИН ПОПГЕОРГИЕВ'),
	('04628', '68134', '37263', 'УЛ.ОВЧАРЕНСКИ ВОДОПАД'),
	('04629', '68134', '37277', 'УЛ.ПРОФ.АРХ.ПЕТЪР А.ТАШЕВ'),
	('04630', '68134', '37280', 'УЛ.ГЕОРГИ РУСЕВ'),
	('04631', '68134', '38683', 'УЛ.ПИЕР ДЬО РОНСАР'),
	('04632', '68134', '38697', 'УЛ.АНТОНИН КОЛАР'),
	('04633', '68134', '38707', 'УЛ.ХЕРМАН МАЙЕР'),
	('04634', '68134', '38710', 'УЛ.АНДРЕАС ГРАЙС'),
	('04635', '68134', '38724', 'УЛ.ФРИДРИХ ГРЮНАНГЕР'),
	('04636', '68134', '38738', 'УЛ.ЛИКУРГО АМАДЕЙ'),
	('04637', '68134', '38741', 'УЛ.БРАТЯ БАРТЕЛ'),
	('04638', '68134', '38755', 'УЛ.ВАЦЛАВ РОУБАЛ'),
	('04639', '68134', '38769', 'УЛ.НИКОЛАЙ КОПИТКИН'),
	('04640', '68134', '38772', 'УЛ.КАРЛ ТРЪНКА'),
	('04641', '68134', '38786', 'УЛ.БРАТЯ ПРОШЕК (769-ТА)'),
	('04642', '68134', '38799', 'УЛ.ЛЮЛИНСКА СКАЛА'),
	('04643', '68134', '37294', 'УЛ.СВ.ТОМА ИКОНОПИСЕЦ'),
	('04644', '68134', '37304', 'УЛ.СТЕФАН КОНСУЛОВ'),
	('04645', '68134', '37318', 'УЛ.ДИМИТЪР СТРАГАЧЕВ'),
	('04646', '68134', '37321', 'УЛ.КАРЛ ДЖЕРСИ'),
	('04647', '68134', '37335', 'УЛ.АКАД.ДИМИТЪР ПОПОВ'),
	('04648', '68134', '37349', 'УЛ.ПРОФ.ГЕОРГИ ШИШКОВ'),
	('04649', '68134', '37366', 'УЛ.ПЕТЪР ПЕТРОВ'),
	('04650', '68134', '37376', 'УЛ.ВИДЕН ТАБАКОВ'),
	('04651', '68134', '38804', 'УЛ.ПРОФ.ВАСИЛ АРНАУДОВ'),
	('04652', '68134', '38813', 'УЛ.ЖЮЛ ЛОШО'),
	('04653', '68134', '38861', 'УЛ.РАДИ РАДЕВ'),
	('04654', '68134', '38875', 'УЛ.ДИМИТЪР ЯБЛАНСКИ'),
	('04655', '68134', '38889', 'УЛ.МАРИН ТОДОРОВ'),
	('04656', '68134', '38892', 'УЛ.АКАД.ИВАН СНЕГАРОВ'),
	('04657', '68134', '22506', 'УЛ.СТЕФАН ГЕЧЕВ'),
	('04658', '68134', '38902', 'УЛ.ПРОФ.СТОЯН БЕЛИНОВ'),
	('04659', '68134', '38916', 'УЛ.ДАТЕКС'),
	('04660', '68134', '38933', 'УЛ.ФЛОРА'),
	('04661', '68134', '38947', 'УЛ.АРЕКА'),
	('04662', '68134', '38950', 'УЛ.ФЕЛИЦИЯ'),
	('04663', '68134', '38964', 'УЛ.БЛАГА ВЕСТ'),
	('04664', '68134', '38978', 'УЛ.СТУБЕЛА'),
	('04665', '68134', '37397', 'УЛ.НИКОЛА ТЕСЛА'),
	('04666', '68134', '37407', 'УЛ.ПРОФ.КОНСТАНТИН ГЪЛЪБОВ'),
	('04667', '68134', '38981', 'УЛ.ЛЕОПОЛД СЕДАР СЕНГОР'),
	('04668', '68134', '38995', 'УЛ.ПИЕР ДЬО РОНСАР'),
	('04669', '68134', '39001', 'УЛ.ВЪЛКО ВОЙВОДА'),
	('04670', '68134', '37410', 'УЛ.НИКОЛА ЗОЗИКОВ'),
	('04671', '68134', '39116', 'УЛ.ИВАН КИРКОВ'),
	('04672', '68134', '39127', 'УЛ.ЦАНКО ЛАВРЕНОВ'),
	('04673', '68134', '39133', 'УЛ.БАЕВИЦА'),
	('04674', '68134', '37424', 'УЛ.СРЕБРИСТО СИЯНИЕ'),
	('04675', '68134', '45106', 'УЛ.ДИМИТЪР ИЛ. ДИМИТРОВ'),
	('04676', '68134', '45110', 'УЛ.КАКТУС'),
	('04677', '68134', '45003', 'УЛ.ЗВЕЗДЕН ЖАСМИН'),
	('04678', '68134', '45017', 'УЛ.ЗАРНИЧЕ'),
	('04679', '68134', '45020', 'УЛ.ВОСЪЧЕ'),
	('04680', '68134', '45034', 'УЛ.ЗЛАТЕН ДЪЖД'),
	('04681', '68134', '45048', 'УЛ.ЕНЬОВЧЕ'),
	('04682', '68134', '45065', 'УЛ.МАЙСКИ СНЯГ'),
	('04683', '68134', '45079', 'УЛ.ПЛАМЪЧЕ'),
	('04684', '68134', '45082', 'УЛ.САБИНА'),
	('04685', '68134', '45096', 'УЛ.ПАРИЧКА'),
	('04686', '68134', '45644', 'УЛ.ЕРИКА'),
	('04687', '68134', '45658', 'УЛ.ОБИЧКА'),
	('04688', '68134', '47408', 'УЛ.ПЪРВА (КВ.РЕПУБЛИКА-2)'),
	('04689', '68134', '47411', 'УЛ.ВТОРА (КВ.РЕПУБЛИКА-2)'),
	('04690', '68134', '47425', 'УЛ.ТРЕТА (КВ.РЕПУБЛИКА-2)'),
	('04691', '68134', '47442', 'УЛ.ПЕТА (КВ.РЕПУБЛИКА-2)'),
	('04692', '68134', '47456', 'УЛ.ШЕСТА (КВ.РЕПУБЛИКА-2)'),
	('04693', '68134', '47468', 'УЛ.СЕДМА (КВ.РЕПУБЛИКА-2)'),
	('04694', '68134', '47473', 'УЛ.ОСМА (КВ.РЕПУБЛИКА-2)'),
	('04695', '68134', '47487', 'УЛ.ДЕВЕТА (КВ.РЕПУБЛИКА-2)'),
	('04696', '68134', '47439', 'УЛ.ЧЕТВЪРТА(КВ.РЕПУБЛИКА-2)'),
	('04697', '68134', '47247', 'УЛ.ЛИЛЯНА ПАНИЦА'),
	('04698', '68134', '37438', 'УЛ.ЖЪЛТ РАВНЕЦ'),
	('04699', '68134', '37441', 'УЛ.МУЗА'),
	('04700', '68134', '37455', 'УЛ.СИБИРСКИ СИНЧЕЦ'),
	('04701', '68134', '37469', 'УЛ.ТРИЦВЕТНА ТЕМЕНУГА'),
	('04702', '68134', '37472', 'УЛ.ПУСТИННА РОЗА'),
	('04703', '68134', '37486', 'УЛ.ЖИВИ КАМЪЧЕТА'),
	('04704', '68134', '37491', 'УЛ.ДАФИНОВО КЛОНЧЕ'),
	('04705', '68134', '37507', 'УЛ.САЛВИЯ'),
	('04706', '68134', '37513', 'УЛ.ВАНДА'),
	('04707', '68134', '37527', 'УЛ.ВЕЙНИЦИ'),
	('04708', '68134', '37530', 'УЛ.СТУБЕЛО'),
	('04709', '68134', '37544', 'УЛ.НИКОЛАЙ МАСАЛИТИНОВ'),
	('04710', '68134', '52400', 'УЛ.ЕЛИЕЗЕР ПАПО'),
	('04711', '68134', '52413', 'УЛ.СЕРДИКИЙСКИ СЪБОР'),
	('04712', '68134', '52427', 'УЛ.СВ.ТРОИЦА'),
	('04713', '68134', '52430', 'УЛ.СВ.АТАНАСИЙ ВЕЛИКИ'),
	('04714', '68134', '52444', 'УЛ.СВ.ОСИЙ КОРДОБСКИ'),
	('04715', '68134', '52458', 'УЛ.ЕПИСКОП ПРОТОГЕН'),
	('04716', '68134', '36364', 'УЛ.КОНСТАНТИН КОСТЕНЕЧКИ'),
	('04717', '68134', '39308', 'УЛ.ПОЛСКА КАЛИНА'),
	('04718', '68134', '39311', 'УЛ.ПРОФ.КОНСТАНТИН ИЛИЕВ'),
	('04719', '68134', '39325', 'УЛ.ЧЕРВЕН ДЪБ'),
	('04720', '68134', '39178', 'УЛ.ОРЛОВ КАМЪК'),
	('04721', '68134', '53730', 'УЛ.КОНСТАНТИН ПОПРУСИНОВ'),
	('04722', '68134', '52461', 'УЛ.ЛЮТИЧЕ'),
	('04723', '68134', '53744', 'УЛ.ВЛАДИМИР ПАШОВ'),
	('04724', '68134', '47977', 'УЛ.МАТЕЙ ПРЕОБРАЖЕНСКИ(ВИТОША)'),
	('04725', '68134', '53758', 'УЛ.ТОДОР ПОПОВ'),
	('04726', '68134', '53761', 'УЛ.ПРОФ.АЛЕКСАНДЪР ТАНЕВ'),
	('04727', '68134', '53775', 'УЛ.ГЕОРГИ ЧЕРКИН'),
	('04728', '68134', '53789', 'УЛ.БОРИС ИБРИШИМОВ'),
	('04729', '68134', '53792', 'УЛ.СТЕФАН ИКОНОМОВ'),
	('04730', '68134', '53802', 'УЛ.ИВЕЛИН ДИМИТРОВ'),
	('04731', '68134', '53816', 'УЛ.ТРИФОН СИЛЯНОВСКИ'),
	('04732', '68134', '53822', 'УЛ.ЛАЗАР НИКОЛОВ'),
	('04733', '68134', '53833', 'УЛ.ГЕНЧО СТОЕВ'),
	('04734', '68134', '43815', 'УЛ.СВЕТИ НИКОЛА'),
	('04735', '68134', '54804', 'УЛ.РЕСЕН'),
	('04736', '68134', '84471', 'УЛ.СТ.ПОДОФИЦЕР Й. ДИМИТРОВ'),
	('04737', '68134', '59745', 'УЛ.ПРОФ.БОРИС БОРОВСКИ'),
	('04738', '68134', '39147', 'УЛ.СРЕБЪРНА ГОРА'),
	('04739', '68134', '39150', 'УЛ.СВЕТИ ЛАВРЕНТИЙ'),
	('04740', '68134', '39164', 'УЛ.КОТЛЕНСКИ ПРОХОД'),
	('04741', '68134', '39181', 'УЛ.АРБАНАСИ'),
	('04742', '68134', '39195', 'УЛ.СПАС СОКОЛОВ'),
	('04743', '68134', '39205', 'УЛ.АКАД.ХРИСТО Я.ХРИСТОВ'),
	('04744', '68134', '39219', 'УЛ.108-МА'),
	('04745', '68134', '39222', 'УЛ.ПРОФ.АРХ.ХРАБЪР ПОПОВ'),
	('04746', '68134', '01821', 'УЛ.БОРОВИЦА'),
	('04747', '68134', '40498', 'УЛ.782-РА(ОВЧА КУПЕЛ)'),
	('04748', '68134', '53850', 'УЛ.МАРКО ЦЕПЕНКОВ'),
	('04749', '68134', '39236', 'УЛ.ВИТОШКО ЦВЕТЕ'),
	('04750', '68134', '53847', 'УЛ.НИКОЛА ОБРАЗОПИСОВ'),
	('04751', '68134', '54002', 'УЛ.ДЕТСКА ПРИКАЗКА'),
	('04752', '68134', '54016', 'УЛ.МАЛКИЯТ ПРИНЦ'),
	('04753', '68134', '54020', 'УЛ.ЧУДНА ГРАДИНА'),
	('04754', '68134', '54033', 'УЛ.УСМИВКА'),
	('04755', '68134', '54047', 'УЛ.СЪРЧИЦЕ'),
	('04756', '68134', '54050', 'УЛ.ДЕТСКА МЕЧТА'),
	('04757', '68134', '54064', 'УЛ.СЛЪНЧЕВОТО ЗАЙЧЕ'),
	('04758', '68134', '54078', 'УЛ.СТО УСМИВКИ'),
	('04759', '68134', '54081', 'УЛ.ИЛИЯ ДИМУШЕВ'),
	('04760', '68134', '54095', 'УЛ.ПРОФ.Д-Р БОЯН БОЯНОВ'),
	('04761', '68134', '54105', 'ПЛ.НИКОЛА ГЮЗЕЛЕВ'),
	('04762', '68134', '54119', 'УЛ.ПРОФ.АРХ.СТАНЧО БЕЛКОВСКИ'),
	('04763', '68134', '54167', 'УЛ.ПРОЛЕТЕН ДЕН'),
	('04764', '68134', '54170', 'УЛ.1001'),
	('04765', '68134', '54184', 'УЛ.1002'),
	('04766', '68134', '54198', 'УЛ.1003'),
	('04767', '68134', '54208', 'УЛ.1004'),
	('04768', '68134', '54211', 'УЛ.1005'),
	('04769', '68134', '54225', 'УЛ.1006'),
	('04770', '68134', '54239', 'УЛ.1007'),
	('04771', '68134', '54242', 'УЛ.1008'),
	('04772', '68134', '54256', 'УЛ.1009'),
	('04773', '68134', '54260', 'УЛ.1010'),
	('04774', '68134', '54273', 'УЛ.1011'),
	('04775', '68134', '54287', 'УЛ.1012'),
	('04776', '68134', '54290', 'УЛ.1013'),
	('04777', '68134', '54300', 'УЛ.1014'),
	('04778', '68134', '54314', 'УЛ.1015'),
	('04779', '68134', '54328', 'УЛ.1016'),
	('04780', '68134', '40364', 'УЛ.ПРОФ.БОЯН КАМЕНОВ'),
	('04781', '68134', '54122', 'УЛ.КИТНА ГРАДИНА'),
	('04782', '68134', '55052', 'УЛ.СВЕТИ ЙОАН БОГОСЛОВ'),
	('04783', '68134', '54331', 'УЛ.ТРАЙЧО СИНАПОВ'),
	('04784', '68134', '54482', 'УЛ.МАРА РАЧОВА'),
	('04785', '68134', '54345', 'УЛ.РАВНА'),
	('04786', '68134', '54359', 'УЛ.КОНЯРСКИ РИД'),
	('04787', '68134', '54362', 'УЛ.БОГОРОДИЧЕН МАНАСТИР'),
	('04788', '68134', '54376', 'УЛ.АРХИМАНДРИТ ТЕОФИЛАКТ'),
	('04789', '68134', '39863', 'УЛ.ЕДУАРД ГЕНОВ'),
	('04790', '68134', '44481', 'УЛ.НОВАЧНИЦА'),
	('04791', '68134', '44495', 'УЛ.БОГОРОДИЧЕ'),
	('04792', '68134', '13072', 'УЛ.ЗЕЛЕН ПАРК'),
	('04793', '68134', '98048', 'УЛ.ПРОФ.СТЕФАН ДИМИТРОВ'),
	('04794', '68134', '39877', 'УЛ.ИЛИЯНСКО ШОСЕ'),
	('04795', '68134', '39880', 'УЛ.ЯБЪЛКА'),
	('04796', '68134', '39921', 'УЛ.ПРАСКОВА'),
	('04797', '68134', '39949', 'УЛ.КАЙСИЯ'),
	('04798', '68134', '39952', 'УЛ.ВИШНА'),
	('04799', '68134', '39966', 'УЛ.БАДЕМ'),
	('04800', '68134', '39242', 'УЛ.РАНГЕЛ ВЪЛЧАНОВ'),
	('04801', '68134', '39253', 'УЛ.АЛЕКСАНДЪР БРЪЗИЦОВ'),
	('04802', '68134', '39267', 'УЛ.МЕДОВИНА'),
	('04803', '68134', '39270', 'УЛ.ЙОРДАН КАСАБОВ'),
	('04804', '68134', '39284', 'УЛ.ИЗВОРЪТ НА БЕЛОНОГАТА'),
	('04805', '68134', '39970', 'УЛ.СЪР СТИВЪН РЪНСИМАН'),
	('04806', '68134', '39298', 'УЛ.НЕЛСЪН МАНДЕЛА'),
	('04807', '68134', '39339', 'УЛ.ИВАЙЛО ПЕТРОВ'),
	('04808', '68134', '39342', 'УЛ.ДАНИИЛ ЕТРОПОЛСКИ'),
	('04809', '68134', '39373', 'УЛ.ПРОФ.КРИКОР АЗАРЯН'),
	('04810', '68134', '39356', 'УЛ.САМАРА'),
	('04811', '68134', '39368', 'УЛ.АЛМУС'),
	('04812', '68134', '39983', 'УЛ.СОЙКА'),
	('04813', '68134', '39390', 'УЛ.СТЕФАН НИКОЛОВ'),
	('04814', '68134', '39400', 'УЛ.ЛАЙКА'),
	('04815', '68134', '39414', 'УЛ.ПЕТЪР УВАЛИЕВ'),
	('04816', '68134', '39428', 'УЛ.АРХ.БОГДАН ТОМАЛЕВСКИ'),
	('04817', '68134', '39431', 'УЛ.ВОДЕНИЧАРСКИ ПЪТ'),
	('04818', '68134', '39445', 'УЛ.СТОЯН РОБОВСКИ'),
	('04819', '68134', '40070', 'УЛ.Д-Р ХАРАЛАН ПОПОВ'),
	('04820', '68134', '39459', 'УЛ.ЦВЕТАН АНГЕЛОВ'),
	('04821', '68134', '39462', 'УЛ.ПОЛК.НИКОЛА БОТЕВ'),
	('04822', '68134', '39483', 'УЛ.ПРОФ.МИХАИЛ АНДРЕЕВ'),
	('04823', '68134', '39503', 'УЛ.СТОЯН КАМБАРЕВ'),
	('04824', '68134', '39517', 'УЛ.МАРИЯ АТАНАСОВА'),
	('04825', '68134', '39534', 'УЛ.ГЕНЕРАЛ КЛИМЕНТ БОЯДЖИЕВ'),
	('04826', '68134', '39640', 'УЛ.ВЕРА ИГНАТИЕВА'),
	('04827', '68134', '39654', 'УЛ.ИВАН АБАДЖИЕВ'),
	('04828', '68134', '39668', 'УЛ.НИКОЛА КОЦЕВ'),
	('04829', '68134', '39671', 'УЛ.ЕФРЕЙТОР НИКОЛА ПАСКАЛЕВ'),
	('04830', '68134', '39709', 'УЛ.АКАД.ДИМО ВЕЛЕВ'),
	('04831', '80409', '00014', 'УЛ.ЗОРА'),
	('04832', '80409', '00031', 'УЛ.ХОРИЗОНТ'),
	('04833', '80409', '00045', 'УЛ.ИСКЪР'),
	('04834', '80409', '00059', 'УЛ.РАЗЛИВ'),
	('04835', '80409', '00062', 'УЛ.МУРГАШ'),
	('04836', '80409', '00076', 'УЛ.ДЕТЕЛИНА'),
	('04837', '80409', '00084', 'УЛ.ПРОЛЕТ'),
	('04838', '80409', '00093', 'УЛ.ХАН АСПАРУХ'),
	('04839', '80409', '00103', 'УЛ.РАДОСТ'),
	('04840', '80409', '00117', 'УЛ.НАПРЕДЪК'),
	('04841', '80409', '00120', 'УЛ.УЧИЛИЩНА'),
	('04842', '80409', '00134', 'УЛ.ОТЕЧЕСТВО'),
	('04843', '80409', '00148', 'УЛ.ПРЕСВЕТА'),
	('04844', '80409', '00151', 'УЛ.СТАРА ЛИВАДА'),
	('04845', '80409', '00165', 'УЛ.ГЕРЕНА'),
	('04846', '80409', '00179', 'УЛ.ИЗВОР'),
	('04847', '80409', '00182', 'УЛ.НАДЕЖДА'),
	('04848', '80409', '00196', 'УЛ.ВОДЕНИЧАРСКА'),
	('04849', '80409', '00206', 'УЛ.ПАРТИЗАНИН'),
	('04850', '80409', '00223', 'УЛ.СВЕТЛИНА'),
	('04851', '80409', '00237', 'УЛ.ГОЛЯМА МОГИЛА'),
	('04852', '80409', '00240', 'УЛ.ИЗГРЕВ'),
	('04853', '80409', '00254', 'УЛ.ДОЛЕЦ'),
	('04854', '80409', '00268', 'УЛ.МАНАСТИРСКА'),
	('04855', '80409', '00271', 'УЛ.АНГЕЛ ИЛЧОВ-ГЕЛО'),
	('04856', '80409', '00285', 'УЛ.НЕЗАБРАВКА'),
	('04857', '80409', '00299', 'УЛ.КОКИЧЕ'),
	('04858', '80409', '00309', 'УЛ.СВЕЖЕСТ'),
	('04859', '80409', '00312', 'УЛ.РИДО'),
	('04860', '80409', '00326', 'УЛ.ЖЕЛЕЗНИЧАРСКА'),
	('04861', '80409', '00330', 'УЛ.ХРИЗАНТЕМА'),
	('04862', '80409', '00343', 'УЛ.ВЪЗРОЖДЕНСКА'),
	('04863', '80409', '00357', 'УЛ.СВЕТЛЬОВЦИ'),
	('04864', '80409', '00360', 'УЛ.ТОПОЛИТЕ'),
	('04865', '80409', '00374', 'УЛ.РЕКАТА'),
	('04866', '80409', '00388', 'УЛ.ГЕОРГИ НИКИФОРОВ'),
	('04867', '80409', '00391', 'УЛ.ГЕНАДИ НИКИФОРОВ'),
	('04868', '80409', '00401', 'УЛ.СТАРА ПЛАНИНА'),
	('04869', '80409', '00415', 'УЛ.ЧИТАЛИЩНА'),
	('04870', '80409', '00429', 'УЛ.ГРАДИНАРСКА'),
	('04871', '80409', '00432', 'УЛ.СТЕФАН НЕДЯЛКОВ'),
	('04872', '80409', '00446', 'УЛ.ПРОСТОР'),
	('04873', '80409', '00456', 'УЛ.БЪДЕЩЕ'),
	('04874', '80409', '00463', 'УЛ.СПОРТИСТ'),
	('04875', '80409', '00477', 'УЛ.ДОЛ'),
	('04876', '80409', '00480', 'УЛ.ОРФЕЙ'),
	('04877', '80409', '00504', 'УЛ.КООПЕРАТОР'),
	('04878', '80409', '00518', 'УЛ.ЛИПА'),
	('04879', '80409', '00535', 'УЛ.ЛЕСНОВСКА'),
	('04880', '80409', '00549', 'УЛ.КОМИТИН ПЕТРЕ'),
	('04881', '80409', '00552', 'УЛ.ДЗУКАТА'),
	('04882', '80409', '00566', 'УЛ.ОСВОБОДИТЕЛНА'),
	('04883', '80409', '00571', 'УЛ.МИНЕРАЛЕН ИЗВОР'),
	('04884', '80409', '27485', 'УЛ.ЧЕЛОПЕШКО ШОСЕ'),
	('04885', '80409', '29101', 'УЛ.ЧЕПИНСКО ШОСЕ'),
	('04886', '80409', '00583', 'УЛ.КОЙЛАТА'),
	('04887', '80409', '00597', 'УЛ.ЧУБРА'),
	('04888', '80409', '00607', 'УЛ.ТУНЕСВЕТ'),
	('04889', '80409', '00610', 'УЛ.РАКИТАТА'),
	('04890', '80409', '00624', 'УЛ.МАКАЗИЦА'),
	('04891', '80409', '00638', 'УЛ.СМИЛЬОВИЦА'),
	('04892', '80409', '60215', 'ПЛ.ГЕРГОВ КЛАДЕНЕЦ'),
	('04893', '80409', '00641', 'УЛ.МАКОВЕТЕ'),
	('04894', '87401', '00014', 'УЛ.ВАСИЛ ЛЕВСКИ'),
	('04895', '87401', '00028', 'УЛ.СВЕТА АНА'),
	('04896', '87401', '00031', 'УЛ.МИНЬОРСКА'),
	('04897', '87401', '00045', 'УЛ.НИКОЛА АТАНАСОВ'),
	('04898', '87401', '00059', 'УЛ.РАЙНА КНЯГИНЯ'),
	('04899', '87401', '00062', 'УЛ.ГОТЕН'),
	('04900', '87401', '00076', 'УЛ.МУРГАШ'),
	('04901', '87401', '00084', 'УЛ.ЮРИЙ ГАГАРИН'),
	('04902', '87401', '00103', 'УЛ.СТЕФАН СТАМБОЛОВ'),
	('04903', '87401', '00117', 'УЛ.ТЕМЕНУГА'),
	('04904', '87401', '00120', 'УЛ.БОРИС НИКОЛОВ'),
	('04905', '87401', '00148', 'УЛ.БОТЕВГРАДСКО ШОСЕ'),
	('04906', '87401', '00151', 'УЛ.ДИМИТЪР СТОИЧКОВ'),
	('04907', '87401', '00165', 'УЛ.ПЕНЬО ПЕНЕВ'),
	('04908', '87401', '00179', 'УЛ.ХРИСТО БОТЕВ'),
	('04909', '87401', '00182', 'УЛ.СТАРА ПЛАНИНА'),
	('04910', '87401', '00196', 'УЛ.СВЕТИ НИКОЛА'),
	('04911', '87401', '00237', 'УЛ.СИНЧЕЦ'),
	('04912', '87401', '00254', 'УЛ.ИГЛИКА'),
	('04913', '87401', '00268', 'УЛ.БЕЗИМЕННА'),
	('04914', '87401', '00271', 'УЛ.ЯНЕЩИЦА'),
	('04915', '87401', '00285', 'УЛ.ХУБАВА ЯНА'),
	('04916', '87401', '00299', 'УЛ.СТАРА ЧЕШМА'),
	('04917', '87401', '00312', 'УЛ.ПЪРВИ МАЙ'),
	('04918', '87401', '00326', 'УЛ.НИКОЛА ВАПЦАРОВ'),
	('04919', '87401', '00330', 'УЛ.ЯНКО ВЕЛЬОВ'),
	('04920', '87401', '00343', 'УЛ.КОКИЧЕ'),
	('04921', '87401', '00357', 'УЛ.СИМЕОН СТОЙКОВ'),
	('04922', '87401', '00360', 'УЛ.РОЗА'),
	('04923', '87401', '00388', 'УЛ.БУХОВСКО ШОСЕ'),
	('04924', '87401', '00391', 'УЛ.ХРИСТО СМИРНЕНСКИ'),
	('04925', '87401', '00432', 'УЛ.ИЗГРЕВ'),
	('04926', '68134', '10433', 'УЛ.МАЙОР ГЕОРГИ ВЕКИЛСКИ');
/*!40000 ALTER TABLE `wnuli` ENABLE KEYS */;

-- Дъмп структура за таблица votingregister.__efmigrationshistory
CREATE TABLE IF NOT EXISTS `__efmigrationshistory` (
  `MigrationId` varchar(95) COLLATE utf8_unicode_ci NOT NULL,
  `ProductVersion` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дъмп данни за таблица votingregister.__efmigrationshistory: ~9 rows (приблизително)
DELETE FROM `__efmigrationshistory`;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
	('20190613140427_Initial', '2.2.4-servicing-10062'),
	('20190614105815_FixedColumnTypes', '2.2.4-servicing-10062'),
	('20190614105943_FixedColumnLenght', '2.2.4-servicing-10062'),
	('20190619114832_AutoIncrementOnIds', '2.2.4-servicing-10062'),
	('20190621134329_RenamedSpeCToSpec', '2.2.4-servicing-10062'),
	('20190626080236_FixedColumnDataTypes', '2.2.4-servicing-10062'),
	('20190628133053_RenamedColumNames', '2.2.4-servicing-10062'),
	('20190702210041_AddedTipColumnToNomenklatures', '2.2.4-servicing-10062'),
	('20190704194213_AddedSysTables', '2.2.4-servicing-10062');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;

-- Дъмп структура за тригер votingregister.trg_aspnetusers_upd
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_aspnetusers_upd` AFTER UPDATE ON `aspnetusers` FOR EACH ROW BEGIN
        IF NEW.Administrative_Rajon <> OLD.Administrative_Rajon and NEW.Administrative_Rajon is not null
        THEN  
           UPDATE sys_usermain 
              SET VALUE = NEW.Administrative_Rajon 
              WHERE USER = new.id 
                AND NAME = 'TOA';
        END IF;
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
