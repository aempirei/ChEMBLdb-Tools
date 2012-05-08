class Activities
	include DataMapper::Resource
	storage_names[:default] = 'activities' 
	property :activity_id, Integer                     # NOT NULL,
	property :assay_id, Integer                        # DEFAULT NULL,
	property :doc_id, Integer                          # DEFAULT NULL,
	property :record_id, Integer                       # DEFAULT NULL,
	property :molregno, Integer                        # DEFAULT NULL,
	property :relation, String                         # DEFAULT NULL,
	property :published_value, Float                   # DEFAULT NULL,
	property :published_units, String                  # DEFAULT NULL,
	property :standard_value, Float                    # DEFAULT NULL,
	property :standard_units, String                   # DEFAULT NULL,
	property :standard_type, String                    # DEFAULT NULL,
	property :activity_comment, String                 # DEFAULT NULL,
	property :published_activity_type, String          # DEFAULT NULL,
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
	property :assay_id, Integer                        # NOT NULL,
	property :tid, Integer                             # NOT NULL,
	property :relationship_type, String                # DEFAULT NULL,
	property :complex, Integer                         # DEFAULT NULL,
	property :multi, Integer                           # DEFAULT NULL,
	property :confidence_score, Integer                # DEFAULT NULL,
	property :curated_by, String                       # DEFAULT NULL,
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
	property :assay_type, String                       # NOT NULL,
	property :assay_desc, String                       # DEFAULT NULL,
  	# PRIMARY KEY (`assay_type`)
end

class Assays
	include DataMapper::Resource
	storage_names[:default] = 'assays'
	property :assay_id, Integer                        # NOT NULL,
	property :assay_type, String                       # DEFAULT NULL,
	property :description, String                      #
	property :doc_id, Integer                          # DEFAULT NULL,
	property :src_id, Integer                          # DEFAULT NULL,
	property :src_assay_id, String                     # DEFAULT NULL,
	property :chembl_id, String                        # DEFAULT NULL,
	property :assay_category, String                   # DEFAULT NULL,
	property :assay_organism, String                   # DEFAULT NULL,
	property :assay_tax_id, Integer                    # DEFAULT NULL,
	property :assay_strain, String                     # DEFAULT NULL,
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
	property :who_name, String                         # DEFAULT NULL,
	property :level1, String                           # DEFAULT NULL,
	property :level2, String                           # DEFAULT NULL,
	property :level3, String                           # DEFAULT NULL,
	property :level4, String                           # DEFAULT NULL,
	property :level5, String                           # NOT NULL,
	property :who_id, String                           # DEFAULT NULL,
	property :level1_description, String               # DEFAULT NULL,
	property :level2_description, String               # DEFAULT NULL,
	property :level3_description, String               # DEFAULT NULL,
	property :level4_description, String               # DEFAULT NULL,
  	# PRIMARY KEY (`level5`)
end

class ChemblIdLookup
	include DataMapper::Resource
	storage_names[:default] = 'chembl_id_lookup'
	property :chembl_id, String                        # NOT NULL,
	property :entity_type, String                      # DEFAULT NULL,
	property :entity_id, Integer                       # DEFAULT NULL,
	property :status, String                           # DEFAULT NULL,
  	# PRIMARY KEY (`chembl_id`),
  	# UNIQUE KEY `chembl_id_lookup_uk` (`entity_id`,`entity_type`)
end

class CompoundProperties
	include DataMapper::Resource
	storage_names[:default] = 'compound_properties'
	property :molregno, Integer                        # NOT NULL,
	property :mw_freebase, Float                       # DEFAULT NULL,
	property :alogp, Float                             # DEFAULT NULL,
	property :hba, Integer                             # DEFAULT NULL,
	property :hbd, Integer                             # DEFAULT NULL,
	property :psa, Float                               # DEFAULT NULL,
	property :rtb, Integer                             # DEFAULT NULL,
	property :ro3_pass, String                         # DEFAULT NULL,
	property :num_ro5_violations, Integer              # DEFAULT NULL,
	property :med_chem_friendly, String                # DEFAULT NULL,
	property :acd_most_apka, Float                     # DEFAULT NULL,
	property :acd_most_bpka, Float                     # DEFAULT NULL,
	property :acd_logp, Float                          # DEFAULT NULL,
	property :acd_logd, Float                          # DEFAULT NULL,
	property :molecular_species, String                # DEFAULT NULL,
	property :full_mwt, Float                          # DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `compound_properties_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class CompoundRecords
	include DataMapper::Resource
	storage_names[:default] = 'compound_records'
	property :record_id, Integer                       # NOT NULL,
	property :molregno, Integer                        # DEFAULT NULL,
	property :doc_id, Integer                          # DEFAULT NULL,
	property :compound_key, String                     # DEFAULT NULL,
	property :compound_name, String                    #
	property :src_id, Integer                          # DEFAULT NULL,
	property :src_compound_id, String                  # DEFAULT NULL,
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
	property :molregno, Integer                        # NOT NULL,
	property :molfile, String                          #
	property :standard_inchi, String                   #
	property :standard_inchi_key, String               # DEFAULT NULL,
	property :canonical_smiles, String                 #
	property :molformula, String                       # DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `compound_structures_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class ConfidenceScoreLookup
	include DataMapper::Resource
	storage_names[:default] = 'confidence_score_lookup'
	property :confidence_score, Integer                # NOT NULL,
	property :description, String                      # DEFAULT NULL,
	property :target_mapping, String                   # DEFAULT NULL,
  	# PRIMARY KEY (`confidence_score`)
end

class CurationLookup
	include DataMapper::Resource
	storage_names[:default] = 'curation_lookup'
	property :curated_by, String                       # NOT NULL,
	property :decription, String                       # DEFAULT NULL,
  	# PRIMARY KEY (`curated_by`)
end

class DefinedDailyDose
	include DataMapper::Resource
	storage_names[:default] = 'defined_daily_dose'
	property :atc_code, String                         # NOT NULL,
	property :ddd_value, Float                         # DEFAULT NULL,
	property :ddd_units, String                        # DEFAULT NULL,
	property :ddd_admr, String                         # DEFAULT NULL,
	property :ddd_comment, String                      #
	property :ddd_id, Integer                          # NOT NULL,
  	# PRIMARY KEY (`ddd_id`)
end

class Docs
	include DataMapper::Resource
	storage_names[:default] = 'docs'
	property :doc_id, Integer                          # NOT NULL,
	property :journal, String                          # DEFAULT NULL,
	property :year, String                             # DEFAULT NULL,
	property :volume, String                           # DEFAULT NULL,
	property :issue, String                            # DEFAULT NULL,
	property :first_page, String                       # DEFAULT NULL,
	property :last_page, String                        # DEFAULT NULL,
	property :pubmed_id, Integer                       # DEFAULT NULL,
	property :doi, String                              # DEFAULT NULL,
	property :chembl_id, String                        # DEFAULT NULL,
	property :title, String                            #
	property :doc_type, String                         # DEFAULT NULL,
  	# PRIMARY KEY (`doc_id`),
  	# UNIQUE KEY `uk_docs_chembl_id` (`chembl_id`),
  	# KEY `docs_idx_chembl_id` (`chembl_id`),
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
end

class Formulations
	include DataMapper::Resource
	storage_names[:default] = 'formulations'
	property :product_id, String                       # NOT NULL,
	property :ingredient, String                       # NOT NULL,
	property :strength, String                         # DEFAULT NULL,
	property :molregno, Integer                        # DEFAULT NULL,
  	# PRIMARY KEY (`product_id`,`ingredient`),
  	# KEY `formulations_idx_molregno` (`molregno`),
  	# KEY `formulations_idx_product_id` (`product_id`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :products, :child_key => [ :product_id ], :parent_key => [ :product_id ]
end

class LigandEff
	include DataMapper::Resource
	storage_names[:default] = 'ligand_eff'
	property :activity_id, Integer                     # NOT NULL,
	property :bei, Float                               # DEFAULT NULL,
	property :sei, Float                               # DEFAULT NULL
end

class MoleculeDictionary
	include DataMapper::Resource
	storage_names[:default] = 'molecule_dictionary'
	property :molregno, Integer                        # NOT NULL,
	property :pref_name, String                        # DEFAULT NULL,
	property :chembl_id, String                        # DEFAULT NULL,
	property :max_phase, Integer                       # DEFAULT NULL,
	property :therapeutic_flag, Integer                # DEFAULT NULL,
	property :dosed_ingredient, Integer                # DEFAULT NULL,
	property :structure_type, String                   # DEFAULT NULL,
	property :chebi_id, Integer                        # DEFAULT NULL,
	property :chebi_par_id, Integer                    # DEFAULT NULL,
	property :molecule_type, String                    # DEFAULT NULL,
	property :first_approval, Integer                  # DEFAULT NULL,
	property :oral, Integer                            # DEFAULT NULL,
	property :parenteral, Integer                      # DEFAULT NULL,
	property :topical, Integer                         # DEFAULT NULL,
	property :black_box_warning, Integer               # DEFAULT NULL,
	property :natural_product, Integer                 # DEFAULT NULL,
	property :prodrug, Integer                         # DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# UNIQUE KEY `uk_moldict_chembl_id` (`chembl_id`),
  	# KEY `molecule_dictionary_idx_chembl_id` (`chembl_id`),
  	belongs_to :chembl_id_lookup, :child_key => [ :chembl_id ], :parent_key => [ :chembl_id ]
end

class MoleculeHierarchy
	include DataMapper::Resource
	storage_names[:default] = 'molecule_hierarchy'
	property :molregno, Integer                        # NOT NULL,
	property :parent_molregno, Integer                 # DEFAULT NULL,
	property :active_molregno, Integer                 # DEFAULT NULL,
  	# PRIMARY KEY (`molregno`),
  	# KEY `molecule_hierarchy_idx_molregno` (`molregno`),
  	# KEY `molecule_hierarchy_idx_parent_molregno` (`parent_molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
  	belongs_to :molecule_dictionary, :child_key => [ :parent_molregno ], :parent_key => [ :molregno ]
end

class MoleculeSynonyms
	include DataMapper::Resource
	storage_names[:default] = 'molecule_synonyms'
	property :molregno, Integer                        # NOT NULL,
	property :synonyms, String                         # NOT NULL,
	property :syn_type, String                         # NOT NULL,
	property :research_stem, String                    # DEFAULT NULL,
  	# PRIMARY KEY (`molregno`,`synonyms`,`syn_type`),
  	# KEY `molecule_synonyms_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class OrganismClass
	include DataMapper::Resource
	storage_names[:default] = 'organism_class'
	property :oc_id, Integer                           # NOT NULL,
	property :tax_id, Integer                          # DEFAULT NULL,
	property :l1, String                               # DEFAULT NULL,
	property :l2, String                               # DEFAULT NULL,
	property :l3, String                               # DEFAULT NULL,
  	# PRIMARY KEY (`oc_id`),
  	# UNIQUE KEY `uk_orgclass_tax_id` (`tax_id`)
end

class Products
	include DataMapper::Resource
	storage_names[:default] = 'products'
	property :dosage_form, String                      # DEFAULT NULL,
	property :route, String                            # DEFAULT NULL,
	property :trade_name, String                       # DEFAULT NULL,
	property :approval_date, Date                      # DEFAULT NULL,
	property :ad_type, String                          # DEFAULT NULL,
	property :oral, Integer                            # DEFAULT NULL,
	property :topical, Integer                         # DEFAULT NULL,
	property :parenteral, Integer                      # DEFAULT NULL,
	property :information_source, String               # DEFAULT NULL,
	property :black_box_warning, Integer               # DEFAULT NULL,
	property :applicant_full_name, String              # DEFAULT NULL,
	property :innovator_company, Integer               # DEFAULT NULL,
	property :product_id, String                       # NOT NULL,
  	# PRIMARY KEY (`product_id`)
end

class ProteinTherapeutics
	include DataMapper::Resource
	storage_names[:default] = 'protein_therapeutics'
	property :molregno, Integer                        # NOT NULL,
	property :protein_description, String              #
	property :protein_sequence, String                 #
	property :protein_species, String                  # DEFAULT NULL,
	property :protein_sequence_length, Integer         # DEFAULT NULL,
	property :mature_peptide_sequence, String          #
  	# PRIMARY KEY (`molregno`),
  	# KEY `protein_therapeutics_idx_molregno` (`molregno`),
  	belongs_to :molecule_dictionary, :child_key => [ :molregno ], :parent_key => [ :molregno ]
end

class RelationshipType
	include DataMapper::Resource
	storage_names[:default] = 'relationship_type'
	property :relationship_type, String                # NOT NULL,
	property :relationship_desc, String                # DEFAULT NULL,
  	# PRIMARY KEY (`relationship_type`)
end

class ResearchCodes
	include DataMapper::Resource
	storage_names[:default] = 'research_codes'
	property :stem, String                             # NOT NULL,
	property :company, String                          # NOT NULL,
	property :country, String                          # DEFAULT NULL,
	property :previous_company, String                 # DEFAULT NULL,
  	# PRIMARY KEY (`stem`,`company`)
end

class Source
	include DataMapper::Resource
	storage_names[:default] = 'source'
	property :src_id, Integer                          # NOT NULL,
	property :src_description, String                  #
  	# PRIMARY KEY (`src_id`)
end

class TargetClass
	include DataMapper::Resource
	storage_names[:default] = 'target_class'
	property :tc_id, Integer                           # NOT NULL,
	property :tid, Integer                             # DEFAULT NULL,
	property :l1, String                               # DEFAULT NULL,
	property :l2, String                               # DEFAULT NULL,
	property :l3, String                               # DEFAULT NULL,
	property :l4, String                               # DEFAULT NULL,
	property :l5, String                               # DEFAULT NULL,
	property :l6, String                               # DEFAULT NULL,
	property :l7, String                               # DEFAULT NULL,
	property :l8, String                               # DEFAULT NULL,
	property :target_classification, String            # DEFAULT NULL,
  	# PRIMARY KEY (`tc_id`),
  	# KEY `target_class_idx_tid` (`tid`),
  	belongs_to :target_dictionary, :child_key => [ :tid ], :parent_key => [ :tid ]
end

class TargetDictionary
	include DataMapper::Resource
	storage_names[:default] = 'target_dictionary'
	property :tid, Integer                             # NOT NULL,
	property :target_type, String                      # DEFAULT NULL,
	property :db_source, String                        # DEFAULT NULL,
	property :description, String                      #
	property :gene_names, String                       #
	property :pref_name, String                        # DEFAULT NULL,
	property :synonyms, String                         #
	property :keywords, String                         #
	property :protein_sequence, String                 #
	property :protein_md5sum, String                   # DEFAULT NULL,
	property :tax_id, Integer                          # DEFAULT NULL,
	property :organism, String                         # DEFAULT NULL,
	property :tissue, String                           # DEFAULT NULL,
	property :strain, String                           # DEFAULT NULL,
	property :db_version, String                       # DEFAULT NULL,
	property :cell_line, String                        # DEFAULT NULL,
	property :protein_accession, String                # DEFAULT NULL,
	property :ec_number, String                        # DEFAULT NULL,
	property :chembl_id, String                        # DEFAULT NULL,
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
	property :target_type, String                      # NOT NULL,
	property :target_desc, String                      # DEFAULT NULL,
  	# PRIMARY KEY (`target_type`)
end

class Version
	include DataMapper::Resource
	storage_names[:default] = 'version'
	property :name, String                             # NOT NULL,
	property :creation_date, Date                      # DEFAULT NULL,
	property :comments, String                         #
  	# PRIMARY KEY (`name`)
end

