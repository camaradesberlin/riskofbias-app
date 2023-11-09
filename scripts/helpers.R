# Libraries ---------------------------------------------------------------

library(shiny)
library(tidyverse)
library(shinydashboard)
library(shinyjs)
library(shinysurveys)
# library(semantic.dashboard)


# Helper functions --------------------------------------------------------

# display debugging messages in R (if local) 
# and in the console log (if running in shiny)
# debug_msg <- function(...) {
#   is_local <- Sys.getenv('SHINY_PORT') == ""
#   in_shiny <- !is.null(shiny::getDefaultReactiveDomain())
#   txt <- toString(list(...))
#   if (is_local) message(txt)
#   if (in_shiny) shinyjs::runjs(sprintf("console.debug(\"%s\")", txt))
# }
# 
# debug_sprintf <- function(fmt, ...) {
#   debug_msg(sprintf(fmt, ...))
# }


# Data for survey structure -----------------------------------------------

# Define questions in the format of a shinysurvey

metadata <- tibble(
  question = c("Study doi",
      "Study ID"),
  option = c("https://","Enter a unique identifier for the study e.g. "),
  input_type = "text",
  input_id = c("study_doi","study_id"),
  required = TRUE,
  page = 1) %>% 
  mutate(dependence = NA) %>% 
  mutate(dependence_value = NA)

instructions <- tibble(
  question = c("(This should be a heading) Sequence allocation",
               "Baseline characteristics",
               "Allocation concealment",
               "Random housing",
               "Blinded conduct of the experiment",
               "Random outcome assessment",
               "Blinded outcome assessment",
               "Incomplete outcome data",
               "Selective outcome reporting",
               "Inappropriate influence of funders",
               "Unit of analysis bias",
               "Addition of animals"),
  option = c(NA),
  input_type = c("instructions"),
  input_id = c("seqalloc_instruct",
               "basechars_instruct",
               "allocconceal_instruct",
               "housing_instruct",
               "expblinding_instruct",
               "randomoutcome_instruct",
               "blindoutcome_instruct",
               "incomplete_instruct",
               "selectreport_instruct",
               "funders_instruct",
               "uoa_instruct",
               "additions_instruct"),
  required = FALSE,
  page = c(1:length(question))) %>%
  mutate(page = page + 1) %>% 
  mutate(dependence = NA) %>%
  mutate(dependence_value = NA)

sequence_allocation <- tibble(
  question = rep(
    c("Did the authors compare two cohorts of the same model?",
      "Do the authors report random allocation to group?",
      "Did the authors describe a random component in the sequence generation process?",
      "Was the method chosen appropriate to achieve random sequence allocation?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("same_cohorts_tool","report_randomalloc_tool",
                   "describe_randomseqgen_tool","approp_random_alloc_tool"), each = 2),
  required = TRUE,
  page = 2) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "same_cohorts_tool", "report_randomalloc_tool", 
                            "describe_randomseqgen_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","Yes","Yes"), each = 2))


baseline_characteristics <- tibble(
  question = rep(
    c("Do they report the baseline characteristics age, sex AND weight in the methods, results or supplements?",
      "Are the groups similar at baseline with respect to age, sex AND weight?",
      "Did the authors adjust the statistical analyses for confouders?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("report_basechars_tool","similar_basechars_tool","adjust_confound_tool"), each = 2),
  required = TRUE,
  page = 3) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "report_basechars_tool", "similar_basechars_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No"), each = 2))

allocation_concealment <- tibble(
  question = rep(
    c("Was the allocation (randomization) procedure described in the methods?",
      "Was sequence generation conducted by someone not involved in the experiment?",
      "Was the allocation concealment appropriate?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("randomization_described_tool","seqgen_blind_tool","alloc_conceal_appropriate_tool"), each = 2),
  required = TRUE,
  page = 4) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "randomization_described_tool", "seqgen_blind_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No"), each = 2))

random_housing <- tibble(
  question = rep(
    c("Was housing described in the methods?",
      "Were cages placed randomly within the housing facility?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("housing_described_tool","cages_random_tool"), each = 2),
  required = TRUE,
  page = 5) %>%
  mutate(dependence = rep(c(NA, "housing_described_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes"), each = 2))

blinded_conduct <- tibble(
  question = rep(
    c("Is blinding mentioned?",
      "Is blinding of the investigators mentioned as a general statement regarding all procedures?",
      "Was blinding of caregivers and/or investigators explicitly stated?",
      "Is the method of blinding described and appropriate?",
      "Is the method of blinding described appropriate?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("blinding_mentioned_tool","blinding_general_tool",
                   "blinding_explicit_tool","blinding_general_appropr_tool",
                   "blinding_explicit_appropr_tool"), each = 2),
  required = TRUE,
  page = 6) %>%
  mutate(dependence = rep(c(NA, "blinding_mentioned_tool", "blinding_general_tool", 
                            "blinding_general_tool","blinding_explicit_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No","Yes","Yes"), each = 2))

random_outcome_assessment <- tibble(
  question = rep(
    c("Is randomization mentioned in the paper?",
      "Are randomization procedures mentioned as a general statement regarding all components of the experiment?",
      "Is a random selection process for outcome assessment described?",
      "Is the method of randomization described and appropriate?",
      "Is the method of randomization described and appropriate?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("randomiz_mentioned_tool","randomiz_general_tool",
                   "random_process_outcome_selection_desccribed_tool",
                   "random_method_general_described_appropriate_tool",
                   "random_method_described_appropriate_tool"), each = 2),
  required = TRUE,
  page = 7) %>%
  mutate(dependence = rep(c(NA, "randomiz_mentioned_tool", "randomiz_general_tool", 
                            "randomiz_general_tool","random_process_outcome_selection_desccribed_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No","Yes","Yes"), each = 2))


blinded_outcome_assessment <- tibble(
  question = rep(
    c("Is blinding mentioned?",
      "Is blinding mentioned as a general statement regarding all procedures?",
      "Was blinding of outcome assessors explicitly stated?",
      "Is the method of blinding described and appropriate?",
      "Is the described method of blinding appropriate?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("blind_outcome_mentioned_tool","blind_outcome_general_tool",
                   "blind_assessors_explicit_tool",
                   "blind_method_outcome_general_described_appropriate_tool",
                   "blind_method_outcome_appropriate_tool"), each = 2),
  required = TRUE,
  page = 8) %>%
  mutate(dependence = rep(c(NA, "blind_outcome_mentioned_tool", "blind_outcome_general_tool", 
                            "blind_outcome_general_tool","blind_assessors_explicit_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No","Yes","Yes"), each = 2))




incomplete_outcome_data <- tibble(
  question = rep(
    c("Is there a section specifically describing drop-outs or mortality?",
      "Is the number of animals that started the experiment (assigned to groups) explicitly reported?",
      "Is the number of animals that were analyzed (mentioned in the results text, tables or figure legends) explicitly reported?",
      "Do the numbers of animals that started the experiment and were analyzed match?",
      "Are there any drop-outs or mortality?",
      "Are the number AND the reason for drop-out/death specified PER GROUP?",
      "Are the number AND the reason for drop-out equally distributed across groups?",
      "Were missing data imputed using appropriate statistical methods?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("dropout_described_tool",
                   "num_started_report_tool",
                   "num_analyzed_report_tool",
                   "start_analyzed_match_tool",
                   "dropout_exists_tool",
                   "number_reason_dropout_tool",
                   "number_reason_equal_tool",
                   "imputation_tool"), each = 2),
  required = TRUE,
  page = 9) %>%
  mutate(dependence = rep(c(NA, 
                            "dropout_described_tool", 
                            "num_started_report_tool", 
                            "num_analyzed_report_tool",
                            "dropout_described_tool",
                            "dropout_exists_tool",
                            "number_reason_dropout_tool",
                            "number_reason_equal_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, 
                                  "No",
                                  "Yes",
                                  "Yes",
                                  "Yes",
                                  "Yes",
                                  "Yes",
                                  "No"), each = 2))

selective_outcome_reporting <- tibble(
  question = rep(
    c("Was the study protocol available and published prior to the study results?",
      "Were results reported for all experiments outlines in the methods section AND is the study free from explicitly unpublished results (e.g. data not shown)?",
      "Was a primary endpoint defined in the initial protocol?",
      "Do all the outcomes in the protocol and in the final report match or were deviations reported?",
      "Is the pre-specified primary outcome equivalent to the reported main finding?",
      "Were all pre-specified outcomes conducted and reported as planned or were deviations explained?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("preregistration_tool",
                   "all_results_published_tool",
                   "endpoint_defined_tool",
                   "outcome_protocol_match_tool",
                   "endpoint_study_match_tool",
                   "prereg_conducted_tool"), each = 2),
  required = TRUE,
  page = 10) %>%
  mutate(dependence = rep(c(NA, 
                            "preregistration_tool", 
                            "preregistration_tool", 
                            "endpoint_defined_tool",
                            "endpoint_defined_tool",
                            "endpoint_study_match_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, 
                                  "No",
                                  "Yes",
                                  "No",
                                  "Yes",
                                  "Yes"), each = 2))

funder_influence <- tibble(
  question = rep(
    c("Were sources of funding and conflict of interests reported?",
      "Did the authors report a conflict of interest?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("coi_statement_tool","coi_reported_tool"), each = 2),
  required = TRUE,
  page = 11) %>%
  mutate(dependence = rep(c(NA, "coi_statement_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes"), each = 2))

unit_of_analysis <- tibble(
  question = rep(
    c("Were treatments given dissolved in either food or drinking water?",
      "Were animals housed individually?",
      "Were cages (not individual animals) compared statistically as the unit of analysis?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("treatm_dissolved_tool","indiv_housing_tool","cages_unit_tool"), each = 2),
  required = TRUE,
  page = 12) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "treatm_dissolved_tool", "indiv_housing_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No"), each = 2))

animal_addition <- tibble(
  question = rep(
    c("Was it explicitly stated that animals were added to any cohort to replace missing ones?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("added_animals_tool"), each = 2),
  required = TRUE,
  page = 13) %>%
  mutate(dependence = rep(c(NA), each = 2)) %>%
  mutate(dependence_value = rep(c(NA), each = 2))

df <- rbind(metadata,
            instructions,
            sequence_allocation, 
            baseline_characteristics,
            allocation_concealment,
            random_housing,
            blinded_conduct,
            random_outcome_assessment,
            blinded_outcome_assessment,
            incomplete_outcome_data,
            selective_outcome_reporting,
            funder_influence,
            unit_of_analysis,
            animal_addition) %>% 
  arrange(page)


# test juniper access

