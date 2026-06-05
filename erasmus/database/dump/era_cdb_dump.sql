-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: era_cdb
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `correspondents`
--

DROP TABLE IF EXISTS `correspondents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `correspondents` (
  `correspondents_id` varchar(200) NOT NULL COMMENT 'This column carries the primary key for the table',
  `type` varchar(45) DEFAULT NULL COMMENT 'This column classifies the correspondent by the following taxonomy: (1) individual (2) corporate body (3) group.',
  `gender` varchar(45) DEFAULT NULL COMMENT 'This column classifies the gender of the correspondent if applicable. For corporate bodies and groups, this column contains the value ‘not applicable’.',
  `viaf_id` varchar(45) DEFAULT NULL COMMENT 'This column carries the numeric identifier provided by VIAF. For corporate bodies and groups, this column contains the value ‘not applicable’.',
  `wikidata_id` varchar(45) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by Wikidata.',
  `gnd_id` varchar(45) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by GND.',
  `cerl_id` varchar(45) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by CERL Thesaurus.',
  `emlo_person_id` varchar(100) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by EMLO.',
  `name_in_edition` varchar(900) DEFAULT NULL COMMENT 'This column carries the name of the correspondent as it appears in the edition that has been used to capture the dataset of the individual corpus of correspondence. If multiple entries in this column are necessary because multiple editions have been used ',
  `known_name_variations` varchar(500) DEFAULT NULL COMMENT 'This column carries name variations that are provided by biographic handbooks such as ‘Contemporaries of Erasmus’ as well as in authority file records such as the ‘Gemeinsame Normdatei’ (GND), which in turn are accessible via the VIAF ID.',
  `known_name_variations_ref` varchar(200) DEFAULT NULL COMMENT 'This column carries a reference to the source of the information contained in known_name_variations. For printed sources, this follows the schema [Name of Work], [Page or Page Range]. For authority file records, only the abbreviation of the authority',
  `pob_loc_id` varchar(90) DEFAULT NULL COMMENT 'This column carries the primary key of the locations table as a foreign key for the place of birth of the individual correspondent. ',
  `pob_loc_annotation` varchar(90) DEFAULT NULL COMMENT 'This column carries the name of the place of birth as it appears in the source of this information.',
  `pob_loc_annotation_ref` varchar(200) DEFAULT NULL COMMENT 'This column carries a reference to the source of the information contained in pob_loc_annotation. For printed sources, this follows the schema [Name of Work],[Page or Page Range]. For authority file records, only the abbreviation of the authority is',
  `dob_year1` varchar(4) DEFAULT NULL COMMENT 'This column carries the year of birth of the individual correspondent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `dob_month1` varchar(2) DEFAULT NULL COMMENT 'This column carries the month of birth of the individual correspondent in the two-digit format (MM) according to the ISO 8601 specification.',
  `dob_day1` varchar(2) DEFAULT NULL COMMENT 'This column carries the day of birth of the individual correspondent in the two-digit format (DD) according to the ISO 8601 specification.',
  `dob_computable1` date DEFAULT NULL COMMENT 'This column carries the date of birth of the individual correspondent in the YYYY-MM-DD format according to the ISO 8601 specification.',
  `dob_has_range` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the date of birth of the individual correspondent has a date range, i.e. if the date of birth is/can be narrowed down to a specific day or not.',
  `dob_year2` varchar(4) DEFAULT NULL COMMENT 'This column carries the year of birth of the individual correspondent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `dob_month2` varchar(2) DEFAULT NULL COMMENT 'This column carries the month of birth of the individual correspondent in the two-digit format (MM) according to the ISO 8601 specification.',
  `dob_day2` varchar(2) DEFAULT NULL COMMENT 'This column carries the day of birth of the individual correspondent in the two-digit format (DD) according to the ISO 8601 specification.',
  `dob_computable2` date DEFAULT NULL COMMENT 'This column carries the date of birth of the individual correspondent in the YYYY-MM-DD format according to the ISO 8601 specification.',
  `dob_annotation` varchar(200) DEFAULT NULL COMMENT 'This column carries the date of birth as it appears in the source of this information.',
  `dob_annotation_ref` varchar(200) DEFAULT NULL COMMENT 'This column carries a reference to the source of the information contained in dob_annotation.',
  `pod_loc_id` varchar(90) DEFAULT NULL COMMENT 'This column carries the primary key of the locations table as a foreign key for the place of birth of the individual correspondent.',
  `pod_loc_annotation` varchar(200) DEFAULT NULL COMMENT 'This column carries the place of death as it appears in the source of this information.',
  `pod_loc_annotation_ref` varchar(200) DEFAULT NULL COMMENT 'This column carries a reference to the source of the information contained in pod_loc_annotation.',
  `dod_year1` varchar(4) DEFAULT NULL COMMENT 'This column carries the year of death of the individual correspondent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `dod_month1` varchar(2) DEFAULT NULL COMMENT 'This column carries the month of death of the individual correspondent in the two-digit format (MM) according to the ISO 8601 specification.',
  `dod_day1` varchar(2) DEFAULT NULL COMMENT 'This column carries the day of death of the individual correspondent in the two-digit format (DD) according to the ISO 8601 specification.',
  `dod_computable1` date DEFAULT NULL COMMENT 'This column carries the date of death of the individual correspondent in the YYYY-MM-DD format according to the ISO 8601 specification.',
  `dod_has_range` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the date of death of the individual correspondent has a date range, i.e. if the date of birth is/can be narrowed down to a specific day or not.',
  `dod_year2` varchar(4) DEFAULT NULL COMMENT 'This column carries the year of death of the individual correspondent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `dod_month2` varchar(2) DEFAULT NULL COMMENT 'This column carries the month of death of the individual correspondent in the two-digit format (MM) according to the ISO 8601 specification.',
  `dod_day2` varchar(2) DEFAULT NULL COMMENT 'This column carries the day of death of the individual correspondent in the two-digit format (DD) according to the ISO 8601 specification.',
  `dod_computable2` date DEFAULT NULL COMMENT 'This column carries the date of death of the individual correspondent in the YYYY-MM-DD format according to the ISO 8601 specification.',
  `dod_annotation` varchar(90) DEFAULT NULL COMMENT 'This column carries a reference to the source of the information contained in dod_annotation.',
  `dod_annotation_ref` varchar(200) DEFAULT NULL COMMENT 'This Column holds the bibliographic reference for the text in dod_annotation',
  `further_annotation` varchar(900) DEFAULT NULL COMMENT 'This column carries additional notes that are relevant to the capturing of data on this correspondent.',
  PRIMARY KEY (`correspondents_id`),
  KEY `fk_persons_groups_bodies_locations1_idx` (`pob_loc_id`),
  KEY `fk_persons_groups_bodies_locations2_idx` (`pod_loc_id`),
  CONSTRAINT `fk_persons_groups_bodies_locations1` FOREIGN KEY (`pob_loc_id`) REFERENCES `locations` (`locations_id`),
  CONSTRAINT `fk_persons_groups_bodies_locations2` FOREIGN KEY (`pod_loc_id`) REFERENCES `locations` (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correspondents`
--

LOCK TABLES `correspondents` WRITE;
/*!40000 ALTER TABLE `correspondents` DISABLE KEYS */;
/*!40000 ALTER TABLE `correspondents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `letters`
--

DROP TABLE IF EXISTS `letters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `letters` (
  `letters_id` varchar(45) NOT NULL COMMENT 'This column carries the primary key for the table.',
  `letter_no_in_edition` varchar(200) DEFAULT NULL COMMENT 'This column carries the sequential alphanumerical identifier(s) of a letter in the edition(s) followed by an abbreviation of the edition the identifiers refers to.',
  `sender_id` varchar(200) DEFAULT NULL COMMENT 'This column carries the primary key of the ‘correspondents’ table as a foreign key for the sender of the letter. This does not only enable the identification of correspondents independently of the spelling in/between edition(s) but also allows for que',
  `sender_as_marked` varchar(500) DEFAULT NULL COMMENT 'This column carries the name of the letter’s sender as it has been marked in the edition that has been the source for the capturing of the metadata for the individual letter. ',
  `sender_inferred` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the sender of a letter has been inferred by the editors of the source that has been used to capture the metadata on the individual letter.',
  `sender_uncertain` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the editors of the source material have indicated that there is a degree of uncertainty with regard to the sender of the letter.',
  `recipient_id` varchar(200) DEFAULT NULL COMMENT 'This column carries the primary key of the ‘correspondents’ table as a foreign key for the recipient of the letter',
  `recipient_as_marked` varchar(500) DEFAULT NULL COMMENT 'This column carries the name of the letter’s recipient as it has been marked in the edition that has been the source for the capturing of the metadata for the individual letter.',
  `recipient_inferred` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the recipient of a letter has been inferred by the editors of the source that has been used to capture the metadata on the individual letter.',
  `recipient_uncertain` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the editors of the source material have indicated that there is a degree of uncertainty with regard to the recipient of the letter.',
  `label` varchar(500) DEFAULT NULL COMMENT 'This column carries the individual row of a letter as it appears in the list of letters that many editions provide. In cases where such lists are not available, this column carries the ‘header’ of the individual letter as it appears in the edition tha',
  `send_date_year1` varchar(4) DEFAULT NULL COMMENT 'This column carries the year the individual letter has been sent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `send_date_month1` varchar(2) DEFAULT NULL COMMENT 'This column carries the month the individual letter has been sent in the two-digit format (MM) according to the ISO 8601 specification.',
  `send_date_day1` varchar(2) DEFAULT NULL COMMENT 'This column carries the day the individual letter has been sent in the two-digit format (DD) according to the ISO 8601 specification',
  `send_date_computable1` date DEFAULT NULL COMMENT 'This column carries the date of dispatch of the individual letter in the YYYY-MM-DD format according to the ISO 8601 specification.',
  `send_date_has_range` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the individual letter has a date range, i.e. if it’s dating is/can be narrowed down to a specific day or not.',
  `send_date_year2` varchar(4) DEFAULT NULL COMMENT 'This column carries the year the individual letter has been sent in the four-digit format (YYYY) according to the ISO 8601 specification.',
  `send_date_month2` varchar(2) DEFAULT NULL COMMENT 'This column carries the month the individual letter has been sent in the two-digit format (MM) according to the ISO 8601 specification.',
  `send_date_day2` varchar(2) DEFAULT NULL COMMENT 'This column carries the month the individual letter has been sent in the two-digit format (DD) according to the ISO 8601 specification.',
  `send_date_computable2` date DEFAULT NULL COMMENT 'This column carries the date of dispatch of the individual letter in the YYYY-MM-DD format according to the ISO 8601 specification (cf. send_date_computable1).',
  `send_date_as_marked` varchar(200) DEFAULT NULL COMMENT 'This column carries the date specification of the individual letter as it appears in the list of letters that many editions provide. In cases where such lists are not available, this column carries the date specification as it appears in the ‘header’ ',
  `send_date_inferred` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the date of dispatch of a letter has been inferred by the editors of the source that has been used to capture the metadata on the individual letter. ',
  `send_date_approx` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the date of dispatch of a letter has been marked by the editors of the source material as an approximation.',
  `send_date_uncertain` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the date of dispatch of a letter has been marked by the editors of the source material as uncertain.',
  `source_loc_id` varchar(90) DEFAULT NULL COMMENT 'This column carries the primary key of the ‘locations’ table as a foreign key for the location from where the letter has been dispatched.',
  `source_loc_as_marked` varchar(200) DEFAULT NULL COMMENT 'This column carries the location from where the individual letter has been dispatched as it appears in the list of letters that many editions provide. ',
  `source_loc_inferred` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the location of dispatch of a letter has been inferred by the editors of the source that has been used to capture the metadata on the individual letter. ',
  `source_loc_uncertain` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the editors of the source material have indicated that there is a degree of uncertainty with regard to the location of dispatch of the letter.',
  `target_loc_id` varchar(90) DEFAULT NULL COMMENT 'This column carries the primary key of the ‘locations’ table as a foreign key for the location to which the letter has been dispatched to.',
  `target_loc_as_marked` varchar(200) DEFAULT NULL COMMENT 'This column carries the location to which the individual letter has been dispatched to (cf. source_loc_as_marked).',
  `target_loc_inferred` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the location to which a letter has been dispatched to has been inferred by the editors of the source that has been used to capture the metadata on the individual letter .',
  `target_loc_uncertain` tinyint(1) DEFAULT NULL COMMENT 'This column carries a Boolean operator (1 or 0) that indicates if the editors of the source material have indicated that there is a degree of uncertainty with regard to the location of dispatch of the letter.',
  `letter_language` varchar(45) DEFAULT NULL COMMENT 'This column carries the language(s) the individual letter has been written in. If a letter contains multiple languages in equal parts, the language denominations are separated by a “//” as delimiter.',
  `letter_type_genus` varchar(45) DEFAULT NULL COMMENT 'This column carries a classification of the letter according to the following taxonomy: (1) familiar letter (2) dedicatory letter (3) prefatory letter. If a letter matches multiple criteria, the classifications are separated by a “//” as delimiter.',
  `letter_type_x_to_x` varchar(45) DEFAULT NULL COMMENT 'This column carries information of the type of epistolary exchange. ‘letter_1_to_1’ denotes an exchange between two individuals, whereas ‘letter_1_to_n’ and its inverse signify letters with multiple recipients or senders. ‘letter_n_to_n’ denot',
  `further_annotation` varchar(800) DEFAULT NULL COMMENT 'This column can be used to store notes that are relevant to capturing of the individual letter, e.g. a reference to an article in which the letter has been published (for those cases where a letter hasn’t been published also in an edition).',
  PRIMARY KEY (`letters_id`),
  KEY `fk_letters_correspondents1_idx` (`sender_id`),
  KEY `fk_letters_correspondents2_idx` (`recipient_id`),
  KEY `fk_letters_locations1_idx` (`source_loc_id`),
  KEY `fk_letters_locations2_idx` (`target_loc_id`),
  CONSTRAINT `fk_letters_correspondents1` FOREIGN KEY (`sender_id`) REFERENCES `correspondents` (`correspondents_id`),
  CONSTRAINT `fk_letters_correspondents2` FOREIGN KEY (`recipient_id`) REFERENCES `correspondents` (`correspondents_id`),
  CONSTRAINT `fk_letters_locations1` FOREIGN KEY (`source_loc_id`) REFERENCES `locations` (`locations_id`),
  CONSTRAINT `fk_letters_locations2` FOREIGN KEY (`target_loc_id`) REFERENCES `locations` (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `letters`
--

LOCK TABLES `letters` WRITE;
/*!40000 ALTER TABLE `letters` DISABLE KEYS */;
/*!40000 ALTER TABLE `letters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `locations_id` varchar(90) NOT NULL COMMENT 'This column carries the primary key for the table that is also being used as a foreign key for ‘source_loc_id’ and target_loc_id’ in the ‘letters’ table as well as ‘pob_loc_id’ and ‘pod_loc_id’ in the ‘correspondents’ table. ',
  `geonames_id` varchar(90) DEFAULT NULL COMMENT 'This column carries the numeric Geonames ID. For locations for which no Geonames ID is available, the value should be set to “unknown”.',
  `wikidata_id` varchar(45) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by Wikidata.',
  `emlo_location_id` varchar(100) DEFAULT NULL COMMENT 'This column carries the alphanumeric identifier provided by EMLO.',
  `locations_name_modern` varchar(90) DEFAULT NULL COMMENT 'This column carries the toponym of the location as specified by Geonames.',
  `locations_name_in_edition` varchar(90) DEFAULT NULL COMMENT 'This column carries the name of the location as it appears in the source used for the capturing of the letter’s metadata.',
  `locations_modern_state` varchar(90) DEFAULT NULL COMMENT 'This column carries the name of the modern state the location is situated in as provided by Geonames.',
  `locations_modern_province` varchar(90) DEFAULT NULL COMMENT 'This column carries the name of the modern province of the state the location is situated in as provided by Geonames.',
  `locations_lat` double DEFAULT NULL COMMENT 'This column carries the latitude element of the geographic coordinates of the location as provided by Geonames.',
  `locations_lng` double DEFAULT NULL COMMENT 'This column carries the longitude element of the geographic coordinates of the location as provided by Geonames.',
  `locations_ll_combined` varchar(90) DEFAULT NULL COMMENT 'This column carries the geographic coordinates of the location according to WGS 84 specifications as provided by Geonames.',
  `locations_further_annotation` varchar(200) DEFAULT NULL COMMENT 'This column can carry information on the identification of the place in Geonames and similar information.',
  PRIMARY KEY (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-05 12:07:45
