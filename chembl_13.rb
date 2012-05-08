class Activities
	include DataMapper::Resource
	storage_names[:default] = 'activities' 
	property :activity_id                    # int(11) NOT NULL,
	property :assay_id                       # int(11) DEFAULT NULL,
	property :doc_id                         # int(11) DEFAULT NULL,
	property :record_id                      # int(11) DEFAULT NULL,
	property :molregno                       # int(11) DEFAULT NULL,
	property :relation                       # varchar(50) DEFAULT NULL,
	property :published_value                # float DEFAULT NULL,
	property :published_units                # varchar(100) DEFAULT NULL,
	property :standard_value                 # float DEFAULT NULL,
	property :standard_units                 # varchar(100) DEFAULT NULL,
	property :standard_type                  # varchar(250) DEFAULT NULL,
	property :activity_comment               # varchar(255) DEFAULT NULL,
	property :published_activity_type        # varchar(250) DEFAULT NULL,
  	# PRIMARY KEY (`activity_id`),
  	# KEY `activities_idx_assay_id` (`assay_id`),
  	# KEY `activities_idx_doc_id` (`doc_id`),
  	# KEY `activities_idx_molregno` (`molregno`),
  	# KEY `activities_idx_record_id` (`record_id`),
  	belongs_to :assays, :child_key => [ :assay_id ], :parent_key => [ :assay_id ]
  	belongs_to :docs, :child_key => [ :doc_id ], :parent_key => [ :doc_id ]
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :compound_records, :child_key => [ :record_id ], :parent_key => [ :record_id ]
end

class Assay2target
	include DataMapper::Resource
	storage_names[:default] = 'assay2target'
	property :assay_id                       # int(11) NOT NULL,
	property :tid                            # int(11) NOT NULL,
	property :relationship_type              # char(1) DEFAULT NULL,
	property :complex                        # int(11) DEFAULT NULL,
	property :multi                          # int(11) DEFAULT NULL,
	property :confidence_score               # int(11) DEFAULT NULL,
	property :curated_by                     # varchar(32) DEFAULT NULL,
  	# PRIMARY KEY (`assay_id`,`tid`),
  	# KEY `assay2target_idx_assay_id` (`assay_id`),
  	# KEY `assay2target_idx_confidence_score` (`confidence_score`),
  	# KEY `assay2target_idx_relationship_type` (`relationship_type`),
  	# KEY `assay2target_idx_tid` (`tid`),
  	belongs_to :assays, :child_key => [ :assay_id ], :parent_key => [ :assay_id ]
  	belongs_to :confidence_score_lookup, :child_key => [ :confidence_score ], :parent_key => [ :confidence_score ]
  	belongs_to :relationship_type, :child_key => [ :relationship_type ], :parent_key => [ :relationship_type ]
  	belongs_to :target_dictionary, :child_key => [ :tid ], :parent_key => [ :tid ]
end

class AssayType
	include DataMapper::Resource
	storage_names[:default] = 'assay_type'
	property :assay_type                     # varchar(1) NOT NULL,
	property :assay_desc                     # varchar(250) DEFAULT NULL,
  	# PRIMARY KEY (`assay_type`)
end

class Assays
	include DataMapper::Resource
	storage_names[:default] = 'assays'
	property :assay_id                       # int(11) NOT NULL,
	property :assay_type                     # varchar(250) DEFAULT NULL,
	property :description                    # text,
	property :doc_id                         # int(11) DEFAULT NULL,
	property :src_id                         # int(11) DEFAULT NULL,
	property :src_assay_id                   # varchar(50) DEFAULT NULL,
	property :chembl_id                      # varchar(20) DEFAULT NULL,
	property :assay_category                 # varchar(20) DEFAULT NULL,
	property :assay_organism                 # varchar(250) DEFAULT NULL,
	property :assay_tax_id                   # int(11) DEFAULT NULL,
	property :assay_strain                   # varchar(200) DEFAULT NULL,
  	# PRIMARY KEY (`assay_id`),
  	# UNIQUE KEY `uk_assays_chembl_id` (`chembl_id`),
  	# KEY `assays_idx_assay_type` (`assay_type`),
  	# KEY `assays_idx_chembl_id` (`chembl_id`),
  	# KEY `assays_idx_doc_id` (`doc_id`),
  	# KEY `assays_idx_src_id` (`src_id`),
  	belongs_to :assay_type, :child_key => [ :assay_type ], :parent_key => [ :assay_type ]
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
  	belongs_to :docs, :child_key => [ :doc_id ], :parent_key => [ :doc_id ]
  	belongs_to :source, :child_key => [ :src_id ], :parent_key => [ :src_id ]
end

class AtcClassification
	include DataMapper::Resource
	storage_names[:default] = 'atc_classification'
	property :who_name                       # varchar(150) DEFAULT NULL,
	property :level1                         # varchar(10) DEFAULT NULL,
	property :level2                         # varchar(10) DEFAULT NULL,
	property :level3                         # varchar(10) DEFAULT NULL,
	property :level4                         # varchar(10) DEFAULT NULL,
	property :level5                         # varchar(10) NOT NULL,
	property :who_id                         # varchar(15) DEFAULT NULL,
	property :level1_description             # varchar(150) DEFAULT NULL,
	property :level2_description             # varchar(150) DEFAULT NULL,
	property :level3_description             # varchar(150) DEFAULT NULL,
	property :level4_description             # varchar(150) DEFAULT NULL,
  	# PRIMARY KEY (`level5`)
end

class ChemblIdLookup
	include DataMapper::Resource
	storage_names[:default] = 'chembl_id_lookup'
	property :chembl_id                      # varchar(20) NOT NULL,
	property :entity_type                    # varchar(50) DEFAULT NULL,
	property :entity_id                      # int(11) DEFAULT NULL,
	property :status                         # varchar(50) DEFAULT NULL,
  	# PRIMARY KEY (`chembl_id`),
  	# UNIQUE KEY `chembl_id_lookup_uk` (`entity_id`,`entity_type`)
end

class CompoundProperties
	include DataMapper::Resource
	storage_names[:default] = 'compound_properties'
	property :molregno                       # int(11) NOT NULL,
	property :mw_freebase                    # float DEFAULT NULL,
	property :alogp                          # float DEFAULT NULL,
	property :hba                            # int(11) DEFAULT NULL,
	property :hbd                            # int(11) DEFAULT NULL,
	property :psa                            # float DEFAULT NULL,
	property :rtb                            # int(11) DEFAULT NULL,
	property :ro3_pass                       # varchar(3) DEFAULT NULL,
	property :num_ro5_violations             # int(11) DEFAULT NULL,
	property :med_chem_friendly              # varchar(3) DEFAULT NULL,
	property :acd_most_apka                  # float DEFAULT NULL,
	property :acd_most_bpka                  # float DEFAULT NULL,
	property :acd_logp                       # float DEFAULT NULL,
	property :acd_logd                       # float DEFAULT NULL,
	property :molecular_species              # varchar(50) DEFAULT NULL,
	property :full_mwt                       # float DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `compound_properties_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class CompoundRecords
	include DataMapper::Resource
	storage_names[:default] = 'compound_records'
	property :record_id                      # int(11) NOT NULL,
	property :molregno                       # int(11) DEFAULT NULL,
	property :doc_id                         # int(11) DEFAULT NULL,
	property :compound_key                   # varchar(250) DEFAULT NULL,
	property :compound_name                  # text,
	property :src_id                         # int(11) DEFAULT NULL,
	property :src_compound_id                # varchar(100) DEFAULT NULL,
  	# PRIMARY KEY (`record_id`),
  	# KEY `compound_records_idx_doc_id` (`doc_id`),
  	# KEY `compound_records_idx_molregno` (`molregno`),
  	# KEY `compound_records_idx_src_id` (`src_id`),
  	belongs_to :docs, :child_key => [ :doc_id ], :parent_key => [ :doc_id ]
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :source, :child_key => [ :src_id ], :parent_key => [ :src_id ]
end

class CompoundStructures
	include DataMapper::Resource
	storage_names[:default] = 'compound_structures'
	property :molregno                       # int(11) NOT NULL,
	property :molfile                        # longtext,
	property :standard_inchi                 # text,
	property :standard_inchi_key             # varchar(50) DEFAULT NULL,
	property :canonical_smiles               # text,
	property :molformula                     # varchar(100) DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `compound_structures_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class ConfidenceScoreLookup
	include DataMapper::Resource
	storage_names[:default] = 'confidence_score_lookup'
	property :confidence_score               # int(11) NOT NULL,
	property :description                    # varchar(250) DEFAULT NULL,
	property :target_mapping                 # varchar(30) DEFAULT NULL,
  	# PRIMARY KEY (`confidence_score`)
end

class CurationLookup
	include DataMapper::Resource
	storage_names[:default] = 'curation_lookup'
	property :curated_by                     # varchar(20) NOT NULL,
	property :decription                     # varchar(100) DEFAULT NULL,
  	# PRIMARY KEY (`curated_by`)
end

class DefinedDailyDose
	include DataMapper::Resource
	storage_names[:default] = 'defined_daily_dose'
	property :atc_code                       # varchar(20) NOT NULL,
	property :ddd_value                      # float DEFAULT NULL,
	property :ddd_units                      # varchar(20) DEFAULT NULL,
	property :ddd_admr                       # varchar(20) DEFAULT NULL,
	property :ddd_comment                    # text,
	property :ddd_id                         # bigint(126) NOT NULL,
  	# PRIMARY KEY (`ddd_id`)
end

class Docs
	include DataMapper::Resource
	storage_names[:default] = 'docs'
	property :doc_id                         # int(11) NOT NULL,
	property :journal                        # varchar(50) DEFAULT NULL,
	property :year                           # varchar(50) DEFAULT NULL,
	property :volume                         # varchar(50) DEFAULT NULL,
	property :issue                          # varchar(50) DEFAULT NULL,
	property :first_page                     # varchar(50) DEFAULT NULL,
	property :last_page                      # varchar(50) DEFAULT NULL,
	property :pubmed_id                      # int(11) DEFAULT NULL,
	property :doi                            # varchar(50) DEFAULT NULL,
	property :chembl_id                      # varchar(20) DEFAULT NULL,
	property :title                          # text,
	property :doc_type                       # varchar(50) DEFAULT NULL,
  	# PRIMARY KEY (`doc_id`),
  	# UNIQUE KEY `uk_docs_chembl_id` (`chembl_id`),
  	# KEY `docs_idx_chembl_id` (`chembl_id`),
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
end

class Formulations
	include DataMapper::Resource
	storage_names[:default] = 'formulations'
	property :product_id                     # varchar(30) NOT NULL,
	property :ingredient                     # varchar(200) NOT NULL,
	property :strength                       # varchar(200) DEFAULT NULL,
	property :molregno                       # int(11) DEFAULT NULL,
  	# PRIMARY KEY (`product_id`,`ingredient`),
  	# KEY `formulations_idx_molregno` (`molregno`),
  	# KEY `formulations_idx_product_id` (`product_id`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :products, :child_key => [ :product_id ], :parent_key => [ :product_id ]
end

class LigandEff
	include DataMapper::Resource
	storage_names[:default] = 'ligand_eff'
	property :activity_id                    # int(11) NOT NULL,
	property :bei                            # float DEFAULT NULL,
	property :sei                            # float DEFAULT NULL
end

class MoleculeDictionary
	include DataMapper::Resource
	storage_names[:default] = 'molecule_dictionary'
	property :molregno                       # int(11) NOT NULL,
	property :pref_name                      # varchar(255) DEFAULT NULL,
	property :chembl_id                      # varchar(20) DEFAULT NULL,
	property :max_phase                      # int(11) DEFAULT NULL,
	property :therapeutic_flag               # int(11) DEFAULT NULL,
	property :dosed_ingredient               # int(11) DEFAULT NULL,
	property :structure_type                 # varchar(10) DEFAULT NULL,
	property :chebi_id                       # int(11) DEFAULT NULL,
	property :chebi_par_id                   # int(11) DEFAULT NULL,
	property :molecule_type                  # varchar(30) DEFAULT NULL,
	property :first_approval                 # int(11) DEFAULT NULL,
	property :oral                           # int(11) DEFAULT NULL,
	property :parenteral                     # int(11) DEFAULT NULL,
	property :topical                        # int(11) DEFAULT NULL,
	property :black_box_warning              # int(11) DEFAULT NULL,
	property :natural_product                # int(11) DEFAULT NULL,
	property :prodrug                        # int(11) DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# UNIQUE KEY `uk_moldict_chembl_id` (`chembl_id`),
  	# KEY `molecule_dictionary_idx_chembl_id` (`chembl_id`),
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
end

class MoleculeHierarchy
	include DataMapper::Resource
	storage_names[:default] = 'molecule_hierarchy'
	property :molregno                       # int(11) NOT NULL,
	property :parent_molregno                # int(11) DEFAULT NULL,
	property :active_molregno                # int(11) DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `molecule_hierarchy_idx_molregno` (`molregno`),
  	# KEY `molecule_hierarchy_idx_parent_molregno` (`parent_molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :molecule_dictionary, :child_key => [ :parent_molregno ], :parent_key => [ :molregno ]
end

class MoleculeSynonyms
	include DataMapper::Resource
	storage_names[:default] = 'molecule_synonyms'
	property :molregno                       # int(11) NOT NULL,
	property :synonyms                       # varchar(200) NOT NULL,
	property :syn_type                       # varchar(50) NOT NULL,
	property :research_stem                  # varchar(20) DEFAULT NULL,
  	# PRIMARY KEY (`molregno`,`synonyms`,`syn_type`),
  	# KEY `molecule_synonyms_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class OrganismClass
	include DataMapper::Resource
	storage_names[:default] = 'organism_class'
	property :oc_id                          # int(11) NOT NULL,
	property :tax_id                         # int(11) DEFAULT NULL,
	property :l1                             # varchar(200) DEFAULT NULL,
	property :l2                             # varchar(200) DEFAULT NULL,
	property :l3                             # varchar(200) DEFAULT NULL,
  	# PRIMARY KEY (`oc_id`),
  	# UNIQUE KEY `uk_orgclass_tax_id` (`tax_id`)
end

class Products
	include DataMapper::Resource
	storage_names[:default] = 'products'
	property :dosage_form                    # varchar(200) DEFAULT NULL,
	property :route                          # varchar(200) DEFAULT NULL,
	property :trade_name                     # varchar(200) DEFAULT NULL,
	property :approval_date                  # date DEFAULT NULL,
	property :ad_type                        # varchar(5) DEFAULT NULL,
	property :oral                           # int(11) DEFAULT NULL,
	property :topical                        # int(11) DEFAULT NULL,
	property :parenteral                     # int(11) DEFAULT NULL,
	property :information_source             # varchar(100) DEFAULT NULL,
	property :black_box_warning              # int(11) DEFAULT NULL,
	property :applicant_full_name            # varchar(200) DEFAULT NULL,
	property :innovator_company              # int(11) DEFAULT NULL,
	property :product_id                     # varchar(30) NOT NULL,
  	# PRIMARY KEY (`product_id`)
end

class ProteinTherapeutics
	include DataMapper::Resource
	storage_names[:default] = 'protein_therapeutics'
	property :molregno                       # int(11) NOT NULL,
	property :protein_description            # text,
	property :protein_sequence               # longtext,
	property :protein_species                # varchar(100) DEFAULT NULL,
	property :protein_sequence_length        # int(11) DEFAULT NULL,
	property :mature_peptide_sequence        # text,
  	# PRIMARY KEY (`molregno`),
  	# KEY `protein_therapeutics_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class RelationshipType
	include DataMapper::Resource
	storage_names[:default] = 'relationship_type'
	property :relationship_type              # char(1) NOT NULL,
	property :relationship_desc              # varchar(250) DEFAULT NULL,
  	# PRIMARY KEY (`relationship_type`)
end

class ResearchCodes
	include DataMapper::Resource
	storage_names[:default] = 'research_codes'
	property :stem                           # varchar(20) NOT NULL,
	property :company                        # varchar(100) NOT NULL,
	property :country                        # varchar(50) DEFAULT NULL,
	property :previous_company               # varchar(100) DEFAULT NULL,
  	# PRIMARY KEY (`stem`,`company`)
end

class Source
	include DataMapper::Resource
	storage_names[:default] = 'source'
	property :src_id                         # int(11) NOT NULL,
	property :src_description                # text,
  	# PRIMARY KEY (`src_id`)
end

class TargetClass
	include DataMapper::Resource
	storage_names[:default] = 'target_class'
	property :tc_id                          # int(11) NOT NULL,
	property :tid                            # int(11) DEFAULT NULL,
	property :l1                             # varchar(100) DEFAULT NULL,
	property :l2                             # varchar(100) DEFAULT NULL,
	property :l3                             # varchar(100) DEFAULT NULL,
	property :l4                             # varchar(100) DEFAULT NULL,
	property :l5                             # varchar(100) DEFAULT NULL,
	property :l6                             # varchar(100) DEFAULT NULL,
	property :l7                             # varchar(100) DEFAULT NULL,
	property :l8                             # varchar(100) DEFAULT NULL,
	property :target_classification          # varchar(250) DEFAULT NULL,
  	# PRIMARY KEY (`tc_id`),
  	# KEY `target_class_idx_tid` (`tid`),
  	belongs_to :target_dictionary, :child_key => [ :tid ], :parent_key => [ :tid ]
end

class TargetDictionary
	include DataMapper::Resource
	storage_names[:default] = 'target_dictionary'
	property :tid                            # int(11) NOT NULL,
	property :target_type                    # varchar(25) DEFAULT NULL,
	property :db_source                      # varchar(25) DEFAULT NULL,
	property :description                    # text,
	property :gene_names                     # text,
	property :pref_name                      # varchar(200) DEFAULT NULL,
	property :synonyms                       # text,
	property :keywords                       # text,
	property :protein_sequence               # longtext,
	property :protein_md5sum                 # varchar(32) DEFAULT NULL,
	property :tax_id                         # int(11) DEFAULT NULL,
	property :organism                       # varchar(150) DEFAULT NULL,
	property :tissue                         # varchar(50) DEFAULT NULL,
	property :strain                         # varchar(25) DEFAULT NULL,
	property :db_version                     # varchar(25) DEFAULT NULL,
	property :cell_line                      # varchar(50) DEFAULT NULL,
	property :protein_accession              # varchar(25) DEFAULT NULL,
	property :ec_number                      # varchar(50) DEFAULT NULL,
	property :chembl_id                      # varchar(20) DEFAULT NULL,
  	# PRIMARY KEY (`tid`),
  	# UNIQUE KEY `uk_targdict_chembl_id` (`chembl_id`),
  	# UNIQUE KEY `uk_targdict_protacc` (`protein_accession`),
  	# KEY `target_dictionary_idx_chembl_id` (`chembl_id`),
  	# KEY `target_dictionary_idx_target_type` (`target_type`),
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
  	belongs_to :target_type, :child_key => [ :target_type ], :parent_key => [ :target_type ]
end

class TargetType
	include DataMapper::Resource
	storage_names[:default] = 'target_type'
	property :target_type                    # varchar(25) NOT NULL,
	property :target_desc                    # varchar(250) DEFAULT NULL,
  	# PRIMARY KEY (`target_type`)
end

class Version
	include DataMapper::Resource
	storage_names[:default] = 'version'
	property :name                           # varchar(20) NOT NULL,
	property :creation_date                  # date DEFAULT NULL,
	property :comments                       # text,
  	# PRIMARY KEY (`name`)
end

