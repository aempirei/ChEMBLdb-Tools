-- MySQL dump 10.13  Distrib 5.1.62, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: chembl_13
-- ------------------------------------------------------
-- Server version	5.1.62-0ubuntu0.11.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activities`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `activity_id` int(11) NOT NULL,
  `assay_id` int(11) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `molregno` int(11) DEFAULT NULL,
  `relation` varchar(50) DEFAULT NULL,
  `published_value` float DEFAULT NULL,
  `published_units` varchar(100) DEFAULT NULL,
  `standard_value` float DEFAULT NULL,
  `standard_units` varchar(100) DEFAULT NULL,
  `standard_type` varchar(250) DEFAULT NULL,
  `activity_comment` varchar(255) DEFAULT NULL,
  `published_activity_type` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `activities_idx_assay_id` (`assay_id`),
  KEY `activities_idx_doc_id` (`doc_id`),
  KEY `activities_idx_molregno` (`molregno`),
  KEY `activities_idx_record_id` (`record_id`),
  CONSTRAINT `activities_fk_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `assays` (`assay_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activities_fk_doc_id` FOREIGN KEY (`doc_id`) REFERENCES `docs` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activities_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activities_fk_record_id` FOREIGN KEY (`record_id`) REFERENCES `compound_records` (`record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assay2target`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assay2target` (
  `assay_id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `relationship_type` char(1) DEFAULT NULL,
  `complex` int(11) DEFAULT NULL,
  `multi` int(11) DEFAULT NULL,
  `confidence_score` int(11) DEFAULT NULL,
  `curated_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`assay_id`,`tid`),
  KEY `assay2target_idx_assay_id` (`assay_id`),
  KEY `assay2target_idx_confidence_score` (`confidence_score`),
  KEY `assay2target_idx_relationship_type` (`relationship_type`),
  KEY `assay2target_idx_tid` (`tid`),
  CONSTRAINT `assay2target_fk_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `assays` (`assay_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assay2target_fk_confidence_score` FOREIGN KEY (`confidence_score`) REFERENCES `confidence_score_lookup` (`confidence_score`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assay2target_fk_relationship_type` FOREIGN KEY (`relationship_type`) REFERENCES `relationship_type` (`relationship_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assay2target_fk_tid` FOREIGN KEY (`tid`) REFERENCES `target_dictionary` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assay_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assay_type` (
  `assay_type` varchar(1) NOT NULL,
  `assay_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`assay_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assays`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assays` (
  `assay_id` int(11) NOT NULL,
  `assay_type` varchar(250) DEFAULT NULL,
  `description` text,
  `doc_id` int(11) DEFAULT NULL,
  `src_id` int(11) DEFAULT NULL,
  `src_assay_id` varchar(50) DEFAULT NULL,
  `chembl_id` varchar(20) DEFAULT NULL,
  `assay_category` varchar(20) DEFAULT NULL,
  `assay_organism` varchar(250) DEFAULT NULL,
  `assay_tax_id` int(11) DEFAULT NULL,
  `assay_strain` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`assay_id`),
  UNIQUE KEY `uk_assays_chembl_id` (`chembl_id`),
  KEY `assays_idx_assay_type` (`assay_type`),
  KEY `assays_idx_chembl_id` (`chembl_id`),
  KEY `assays_idx_doc_id` (`doc_id`),
  KEY `assays_idx_src_id` (`src_id`),
  CONSTRAINT `assays_fk_assay_type` FOREIGN KEY (`assay_type`) REFERENCES `assay_type` (`assay_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assays_fk_chembl_id` FOREIGN KEY (`chembl_id`) REFERENCES `chembl_id_lookup` (`chembl_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assays_fk_doc_id` FOREIGN KEY (`doc_id`) REFERENCES `docs` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assays_fk_src_id` FOREIGN KEY (`src_id`) REFERENCES `source` (`src_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atc_classification`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atc_classification` (
  `who_name` varchar(150) DEFAULT NULL,
  `level1` varchar(10) DEFAULT NULL,
  `level2` varchar(10) DEFAULT NULL,
  `level3` varchar(10) DEFAULT NULL,
  `level4` varchar(10) DEFAULT NULL,
  `level5` varchar(10) NOT NULL,
  `who_id` varchar(15) DEFAULT NULL,
  `level1_description` varchar(150) DEFAULT NULL,
  `level2_description` varchar(150) DEFAULT NULL,
  `level3_description` varchar(150) DEFAULT NULL,
  `level4_description` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`level5`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chembl_id_lookup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chembl_id_lookup` (
  `chembl_id` varchar(20) NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`chembl_id`),
  UNIQUE KEY `chembl_id_lookup_uk` (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compound_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compound_properties` (
  `molregno` int(11) NOT NULL,
  `mw_freebase` float DEFAULT NULL,
  `alogp` float DEFAULT NULL,
  `hba` int(11) DEFAULT NULL,
  `hbd` int(11) DEFAULT NULL,
  `psa` float DEFAULT NULL,
  `rtb` int(11) DEFAULT NULL,
  `ro3_pass` varchar(3) DEFAULT NULL,
  `num_ro5_violations` int(11) DEFAULT NULL,
  `med_chem_friendly` varchar(3) DEFAULT NULL,
  `acd_most_apka` float DEFAULT NULL,
  `acd_most_bpka` float DEFAULT NULL,
  `acd_logp` float DEFAULT NULL,
  `acd_logd` float DEFAULT NULL,
  `molecular_species` varchar(50) DEFAULT NULL,
  `full_mwt` float DEFAULT NULL,
  PRIMARY KEY (`molregno`),
  KEY `compound_properties_idx_molregno` (`molregno`),
  CONSTRAINT `compound_properties_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compound_records`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compound_records` (
  `record_id` int(11) NOT NULL,
  `molregno` int(11) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `compound_key` varchar(250) DEFAULT NULL,
  `compound_name` text,
  `src_id` int(11) DEFAULT NULL,
  `src_compound_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `compound_records_idx_doc_id` (`doc_id`),
  KEY `compound_records_idx_molregno` (`molregno`),
  KEY `compound_records_idx_src_id` (`src_id`),
  CONSTRAINT `compound_records_fk_doc_id` FOREIGN KEY (`doc_id`) REFERENCES `docs` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compound_records_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compound_records_fk_src_id` FOREIGN KEY (`src_id`) REFERENCES `source` (`src_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compound_structures`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compound_structures` (
  `molregno` int(11) NOT NULL,
  `molfile` longtext,
  `standard_inchi` text,
  `standard_inchi_key` varchar(50) DEFAULT NULL,
  `canonical_smiles` text,
  `molformula` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`molregno`),
  KEY `compound_structures_idx_molregno` (`molregno`),
  CONSTRAINT `compound_structures_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confidence_score_lookup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confidence_score_lookup` (
  `confidence_score` int(11) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `target_mapping` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`confidence_score`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curation_lookup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curation_lookup` (
  `curated_by` varchar(20) NOT NULL,
  `decription` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`curated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `defined_daily_dose`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `defined_daily_dose` (
  `atc_code` varchar(20) NOT NULL,
  `ddd_value` float DEFAULT NULL,
  `ddd_units` varchar(20) DEFAULT NULL,
  `ddd_admr` varchar(20) DEFAULT NULL,
  `ddd_comment` text,
  `ddd_id` bigint(126) NOT NULL,
  PRIMARY KEY (`ddd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docs` (
  `doc_id` int(11) NOT NULL,
  `journal` varchar(50) DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  `volume` varchar(50) DEFAULT NULL,
  `issue` varchar(50) DEFAULT NULL,
  `first_page` varchar(50) DEFAULT NULL,
  `last_page` varchar(50) DEFAULT NULL,
  `pubmed_id` int(11) DEFAULT NULL,
  `doi` varchar(50) DEFAULT NULL,
  `chembl_id` varchar(20) DEFAULT NULL,
  `title` text,
  `doc_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  UNIQUE KEY `uk_docs_chembl_id` (`chembl_id`),
  KEY `docs_idx_chembl_id` (`chembl_id`),
  CONSTRAINT `docs_fk_chembl_id` FOREIGN KEY (`chembl_id`) REFERENCES `chembl_id_lookup` (`chembl_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formulations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formulations` (
  `product_id` varchar(30) NOT NULL,
  `ingredient` varchar(200) NOT NULL,
  `strength` varchar(200) DEFAULT NULL,
  `molregno` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`ingredient`),
  KEY `formulations_idx_molregno` (`molregno`),
  KEY `formulations_idx_product_id` (`product_id`),
  CONSTRAINT `formulations_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `formulations_fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ligand_eff`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligand_eff` (
  `activity_id` int(11) NOT NULL,
  `bei` float DEFAULT NULL,
  `sei` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `molecule_dictionary`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `molecule_dictionary` (
  `molregno` int(11) NOT NULL,
  `pref_name` varchar(255) DEFAULT NULL,
  `chembl_id` varchar(20) DEFAULT NULL,
  `max_phase` int(11) DEFAULT NULL,
  `therapeutic_flag` int(11) DEFAULT NULL,
  `dosed_ingredient` int(11) DEFAULT NULL,
  `structure_type` varchar(10) DEFAULT NULL,
  `chebi_id` int(11) DEFAULT NULL,
  `chebi_par_id` int(11) DEFAULT NULL,
  `molecule_type` varchar(30) DEFAULT NULL,
  `first_approval` int(11) DEFAULT NULL,
  `oral` int(11) DEFAULT NULL,
  `parenteral` int(11) DEFAULT NULL,
  `topical` int(11) DEFAULT NULL,
  `black_box_warning` int(11) DEFAULT NULL,
  `natural_product` int(11) DEFAULT NULL,
  `prodrug` int(11) DEFAULT NULL,
  PRIMARY KEY (`molregno`),
  UNIQUE KEY `uk_moldict_chembl_id` (`chembl_id`),
  KEY `molecule_dictionary_idx_chembl_id` (`chembl_id`),
  CONSTRAINT `molecule_dictionary_fk_chembl_id` FOREIGN KEY (`chembl_id`) REFERENCES `chembl_id_lookup` (`chembl_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `molecule_hierarchy`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `molecule_hierarchy` (
  `molregno` int(11) NOT NULL,
  `parent_molregno` int(11) DEFAULT NULL,
  `active_molregno` int(11) DEFAULT NULL,
  PRIMARY KEY (`molregno`),
  KEY `molecule_hierarchy_idx_molregno` (`molregno`),
  KEY `molecule_hierarchy_idx_parent_molregno` (`parent_molregno`),
  CONSTRAINT `molecule_hierarchy_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `molecule_hierarchy_fk_parent_molregno` FOREIGN KEY (`parent_molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `molecule_synonyms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `molecule_synonyms` (
  `molregno` int(11) NOT NULL,
  `synonyms` varchar(200) NOT NULL,
  `syn_type` varchar(50) NOT NULL,
  `research_stem` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`molregno`,`synonyms`,`syn_type`),
  KEY `molecule_synonyms_idx_molregno` (`molregno`),
  CONSTRAINT `molecule_synonyms_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organism_class`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organism_class` (
  `oc_id` int(11) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `l1` varchar(200) DEFAULT NULL,
  `l2` varchar(200) DEFAULT NULL,
  `l3` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`oc_id`),
  UNIQUE KEY `uk_orgclass_tax_id` (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `dosage_form` varchar(200) DEFAULT NULL,
  `route` varchar(200) DEFAULT NULL,
  `trade_name` varchar(200) DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  `ad_type` varchar(5) DEFAULT NULL,
  `oral` int(11) DEFAULT NULL,
  `topical` int(11) DEFAULT NULL,
  `parenteral` int(11) DEFAULT NULL,
  `information_source` varchar(100) DEFAULT NULL,
  `black_box_warning` int(11) DEFAULT NULL,
  `applicant_full_name` varchar(200) DEFAULT NULL,
  `innovator_company` int(11) DEFAULT NULL,
  `product_id` varchar(30) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protein_therapeutics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protein_therapeutics` (
  `molregno` int(11) NOT NULL,
  `protein_description` text,
  `protein_sequence` longtext,
  `protein_species` varchar(100) DEFAULT NULL,
  `protein_sequence_length` int(11) DEFAULT NULL,
  `mature_peptide_sequence` text,
  PRIMARY KEY (`molregno`),
  KEY `protein_therapeutics_idx_molregno` (`molregno`),
  CONSTRAINT `protein_therapeutics_fk_molregno` FOREIGN KEY (`molregno`) REFERENCES `molecule_dictionary` (`molregno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type` char(1) NOT NULL,
  `relationship_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`relationship_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `research_codes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `research_codes` (
  `stem` varchar(20) NOT NULL,
  `company` varchar(100) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `previous_company` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`stem`,`company`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `source`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source` (
  `src_id` int(11) NOT NULL,
  `src_description` text,
  PRIMARY KEY (`src_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_class`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_class` (
  `tc_id` int(11) NOT NULL,
  `tid` int(11) DEFAULT NULL,
  `l1` varchar(100) DEFAULT NULL,
  `l2` varchar(100) DEFAULT NULL,
  `l3` varchar(100) DEFAULT NULL,
  `l4` varchar(100) DEFAULT NULL,
  `l5` varchar(100) DEFAULT NULL,
  `l6` varchar(100) DEFAULT NULL,
  `l7` varchar(100) DEFAULT NULL,
  `l8` varchar(100) DEFAULT NULL,
  `target_classification` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`tc_id`),
  KEY `target_class_idx_tid` (`tid`),
  CONSTRAINT `target_class_fk_tid` FOREIGN KEY (`tid`) REFERENCES `target_dictionary` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_dictionary`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_dictionary` (
  `tid` int(11) NOT NULL,
  `target_type` varchar(25) DEFAULT NULL,
  `db_source` varchar(25) DEFAULT NULL,
  `description` text,
  `gene_names` text,
  `pref_name` varchar(200) DEFAULT NULL,
  `synonyms` text,
  `keywords` text,
  `protein_sequence` longtext,
  `protein_md5sum` varchar(32) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `organism` varchar(150) DEFAULT NULL,
  `tissue` varchar(50) DEFAULT NULL,
  `strain` varchar(25) DEFAULT NULL,
  `db_version` varchar(25) DEFAULT NULL,
  `cell_line` varchar(50) DEFAULT NULL,
  `protein_accession` varchar(25) DEFAULT NULL,
  `ec_number` varchar(50) DEFAULT NULL,
  `chembl_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tid`),
  UNIQUE KEY `uk_targdict_chembl_id` (`chembl_id`),
  UNIQUE KEY `uk_targdict_protacc` (`protein_accession`),
  KEY `target_dictionary_idx_chembl_id` (`chembl_id`),
  KEY `target_dictionary_idx_target_type` (`target_type`),
  CONSTRAINT `target_dictionary_fk_chembl_id` FOREIGN KEY (`chembl_id`) REFERENCES `chembl_id_lookup` (`chembl_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `target_dictionary_fk_target_type` FOREIGN KEY (`target_type`) REFERENCES `target_type` (`target_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_type` (
  `target_type` varchar(25) NOT NULL,
  `target_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `name` varchar(20) NOT NULL,
  `creation_date` date DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-08  7:21:08
