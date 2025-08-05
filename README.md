# Variation in soldier investment is linked to the evolution of termite soldier defense strategies


## Description of the data and file structure

> This dataset contains genus-level information on soldier proportion, defense strategy (strong-point vs. counter-attack), nesting strategy (foraging vs. non-foraging), soldier morphology, and colony sampling details for termites. The data were compiled from published literature and used for phylogenetically controlled comparative analyses to explore the evolutionary association between defense strategies and investment in soldier caste. Data values include both continuous variables (e.g., proportion of soldiers) and categorical traits (e.g., defense strategy).

### Data files and variables

#### File: Species-level_data.xlsx

#### **Description:** Data on defense strategy, nesting strategy, foraging strategy, and proportion of soldiers in the colony for each termite species

##### Sheets

* all_data:                               main data
* entire_colony:                     data for robust dataset
* exclude_ambiguous:         dataset excluding all genera with ambiguous classification

##### Row names

* Family:                                          Termite family name
* Sub.Family:                                  Subfamily or Family name
* Genus:                                          Termite genus name
* Species:                                        Species name
* Subspecies                                  Subspecies name (if available)
* Nesting:                                       Nesting strategy (OP: One-piece, MP: Multiple-piece, CP: Central-piece)
* Soldier_tactics_Tuma2020:      Classification of soldier defense tactics (see Tuma et al. 2020)
* Soldier_strategy_Tuma2020:   Counter-attack (0) or Strong-point (1) 
* Soldier_prop:                              Representative proportion of soldiers
* min:                                              minimum proportion of soldiers
* max:                                             maximum proportion of soldiers
* sol_prop_ref.:                              references for soldier ratio data
* sol_morph*_*ref.:                          references for soldiers' head morphology
* sol_str_ref.:                                 references for soldiers' defensive behavior
* note:                                            notes for classification
* collection:                                   Colony collection methods (ec: entire colony, fg: foraging group, lc: laboratory colony, sc: sample taken from a mound, pg: peripheral gallery, and ?: unknown)

#### File: Genus-level_data.xlsx

**Description:** Genus-level summary dataset including average soldier proportion, defense strategy (counter-attack or strong-point), foraging strategy (forager or non-forager), nesting type. This dataset was used for phylogenetically controlled comparative analyses in the study.

##### Sheets

* all_data:                               main data
* entire_colony:                     data for robust dataset
* exclude_ambiguous:         dataset excluding all genera with ambiguous classification

##### Variables

* Family:                        Termite family name
* Sub.Family:                Subfamily or family name
* Genus:                        Termite genus name
* Nesting:                      Nesting strategy (OP: One-piece, MP: Multiple-piece, CP: Central-piece)
* Forager:                      Non-forager (0) or Forager (1)
* Forager_string:          Foraging strategy in character type (for analysis)
* Soldier_str:                 Counter-attack (0) or Strong-point (1)
* Soldier_str_string:     Defense strategy in character type (for analysis)
* Soldier_prop:              Representative proportion of soldiers for each genus


#### R project files

prop_of_termite_soldier.Rproj:       R project file

######  scripts

                              Analysis.R:               Codes for main and supplemental analyses

                              Plot.R:                      Codes for figure output

                              Processing.R:         Codes for preprocessing data sets

                              Sources.R:              Codes for packages
