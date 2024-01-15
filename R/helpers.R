# Libraries ---------------------------------------------------------------

pkgs <- function(...) {
  libs <- unlist(list(...))
  req <- unlist(lapply(libs, require, character.only = TRUE))
  need <- libs[req == FALSE]
  if(length(need) > 0) { 
    install.packages(need)
    lapply(need, require, character.only = TRUE)
  }
}

pkgs(c("shiny",
       "shinydashboard",
       "shinyjs",
       "shinysurveys",
       "shinyWidgets",
       "shinyvalidate",
       "shinyFeedback",
       "bslib",
       "tidyverse",
       "data.table",
       "htmltools",
       "sass",
       "robvis",
       "magrittr",
       "rvest"))


# Helper functions --------------------------------------------------------

# display tab box titles after tabs

tab_title <- function(string) {
  HTML(paste("", string, sep = "<br/>"))
}

# add space after tab title
space_after <- function(string) {
  HTML(paste(string, "&emsp;", sep = "<br/>"))
}

# define steps of assessment

tool_steps <-
  c(
    "1. Sequence allocation",
    "2. Baseline characteristics",
    "3. Allocation concealment",
    "4. Random housing",
    "5. Blinded conduct of the experiment",
    "6. Random outcome assessment",
    "7. Blinded outcome assessment",
    "8. Incomplete outcome reporting",
    "9. Selective outcome reporting",
    "10.1 Inappropriate influence of funders",
    "10.2 Unit of analysis bias",
    "10.3 Addition of animals"
  )

# create item (box in a row) to track progress during the rob assessment

make_row <- function(step) {
  
  step_id <- step %>% 
    {gsub("[[:digit:]]+", "", .)} %>% 
    {gsub("\\. ", "", .)} %>% 
    {gsub(" ", "_", .)} %>% 
    {tolower(.)}
  
  box_id <- paste0(step_id, "_step")
  title_id <- paste0(step_id, "_title")
  check_id <- paste0(step_id, "_check")
  outcome_id <- paste0(step_id, "_outcome_sign")
  # 
  # fluidRow(
  #   div(
  #     id = box_id,
  #     box(
  #       title = actionLink(
  #         title_id,
  #         span(icon("exclamation", style = "color: #333"), step)
  #         ),
  #       width = "100%"
  #       )
  #     )
  #   )
  
  fluidRow(
    column(
      width = 1,
      div(
        id = check_id
      )
    ),
    column(
      width = 9,
      div(
        id = box_id,
        box(
          title = actionLink(title_id, step),
          width = "100%"
        )
      )
    ),
    column(
      width = 2,
      shinyjs::hidden(
        div(
        id = outcome_id
        # HTML('<i class="fa-solid fa-circle"></i>')
        )
      )
    )
  )

}

# move above and take out of previous function?
step_ids <- tool_steps %>% 
  {gsub("[[:digit:]]+", "", .)} %>% 
  {gsub("\\. ", "", .)} %>% 
  {gsub(" ", "_", .)} %>% 
  {tolower(.)}

title_ids <- paste0(step_ids, "_title")
check_ids <- paste0(step_ids, "title")


# Custom theme ------------------------------------------------------------

mystyle <- sass::sass(
  list(
    list(
      color = "#60ab9b"
      ),
    readLines(
      here::here(
        "www","style.scss")
      )
    )
  )


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
  question = c(
  "### Sequence allocation
  Describe the methods used, if any, to generate the allocation sequence in sufficient detail 
  to allow an assessment whether it should produce comparable groups.",
  "### Baseline characteristics
  Describe all the possible prognostic factors or animal characteristics, if any, that are 
  compared in order to judge whether or not intervention and control groups were similar 
  at the start of the experiment.",
  "### Allocation concealment",
  "### Random housing",
  "### Blinded conduct of the experiment",
  "### Random outcome assessment",
  "### Blinded outcome assessment",
  "### Incomplete outcome data",
  "### Selective outcome reporting",
  "### Inappropriate influence of funders",
  "### Unit of analysis bias",
  "### Addition of animals"
  ),
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
    c("Did the authors compare two cohorts of the same genetic model?",
      "Do the authors report random allocation to group?",
      "Did the authors describe a random component in the sequence generation process?",
      "Was the method chosen appropriate to achieve random sequence allocation?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("same_model_tool","report_random_allocation_tool",
                   "describe_random_component_tool","appropriate_randomization_tool"), each = 2),
  required = TRUE,
  page = 2) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "same_model_tool", "report_random_allocation_tool",
                            "describe_random_component_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","Yes","Yes"), each = 2))

# sequence_allocation <- tibble(
#   question = rep(
#     c("Did the authors compare two cohorts of the same genetic model?",
#       "Do the authors report random allocation to group?",
#       "Did the authors describe a random component in the sequence generation process?",
#       "Was the method chosen appropriate to achieve random sequence allocation?"),
#     each = 3),
#   option = rep(c("Yes","No", NA), length(question)/3),
#   input_type = rep(c("y/n","y/n","text"), length(question)/3),
#   input_id = rep(c("same_model_tool","report_random_allocation_tool",
#                    "describe_random_component_tool","appropriate_randomization_tool"), each = 3),
#   required = TRUE,
#   page = 2) %>%
#   # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
#   mutate(required = ifelse(input_type == "y/n", TRUE, FALSE)) %>%
#   mutate(input_id = ifelse(input_type == "text", paste0(input_id, "_text"), input_id)) %>%
#   mutate(question = ifelse(input_type == "text", "Justification", question)) %>% 
#   mutate(dependence = rep(c(NA, "same_model_tool", "report_random_allocation_tool",
#                             "describe_random_component_tool"), each = 3)) %>%
#   mutate(dependence_value = rep(c(NA, "Yes","Yes","Yes"), each = 3))


baseline_characteristics <- tibble(
  question = rep(
    c("Do they report the baseline characteristics age, sex AND weight in the methods, results or supplements?",
      "Are the groups similar at baseline with respect to age, sex AND weight?",
      "Did the authors adjust the statistical analyses for confouders?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("report_base_chars_tool","similar_base_chars_tool","adjust_confound_tool"), each = 2),
  required = TRUE,
  page = 3) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "report_base_chars_tool", "similar_base_chars_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No"), each = 2))

allocation_concealment <- tibble(
  question = rep(
    c("Was the allocation (randomization) procedure described in the methods?",
      "Was sequence generation conducted by someone not involved in the experiment?",
      "Was the allocation concealment appropriate?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("describe_allocation_tool","seqgen_blind_tool","appropriate_conceal_tool"), each = 2),
  required = TRUE,
  page = 4) %>%
  # mutate(input_id = gsub('\\b(\\pL)\\pL{3,}|.','\\U\\1', question, perl = TRUE)) %>%
  mutate(dependence = rep(c(NA, "describe_allocation_tool", "seqgen_blind_tool"), each = 2)) %>%
  mutate(dependence_value = rep(c(NA, "Yes","No"), each = 2))

random_housing <- tibble(
  question = rep(
    c("Was housing described in the methods?",
      "Were cages placed randomly within the housing facility?"),
    each = 2),
  option = rep(c("Yes","No"), length(question)/2),
  input_type = rep("y/n", length(question)),
  input_id = rep(c("describe_housing_tool","cages_random_tool"), each = 2),
  required = TRUE,
  page = 5) %>%
  mutate(dependence = rep(c(NA, "describe_housing_tool"), each = 2)) %>%
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
  input_id = rep(c("mention_blinding_tool","blinding_general_tool",
                   "blinding_explicit_tool","blinding_general_appropriate_tool",
                   "blinding_explicit_appropriate_tool"), each = 2),
  required = TRUE,
  page = 6) %>%
  mutate(dependence = rep(c(NA, "mention_blinding_tool", "blinding_general_tool", 
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
  input_id = rep(c("mention_random_tool","mention_random_general_tool",
                   "describe_random_outcome_selection_tool",
                   "random_general_appropriate_tool",
                   "random_explicit_appropriate_tool"), each = 2),
  required = TRUE,
  page = 7) %>%
  mutate(dependence = rep(c(NA, "mention_random_tool", "mention_random_general_tool", 
                            "mention_random_general_tool","describe_random_outcome_selection_tool"), each = 2)) %>%
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
  input_id = rep(c("mention_blinding_outcome_tool",
                   "blinding_outcome_general_tool",
                   "blinding_assessors_explicit_tool",
                   "blinding_outcome_general_appropriate_tool",
                   "blinding_outcome_explicit_appropriate_tool"), each = 2),
  required = TRUE,
  page = 8) %>%
  mutate(dependence = rep(c(NA, "mention_blinding_outcome_tool", "blinding_outcome_general_tool", 
                            "blinding_outcome_general_tool","blinding_assessors_explicit_tool"), each = 2)) %>%
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
  input_id = rep(c("describe_dropout_tool",
                   "report_num_started_tool",
                   "report_num_analyzed_tool",
                   "start_analyzed_match_tool",
                   "dropout_exists_tool",
                   "number_reason_dropout_tool",
                   "number_reason_equal_tool",
                   "imputation_tool"), each = 2),
  required = TRUE,
  page = 9) %>%
  mutate(dependence = rep(c(NA, 
                            "describe_dropout_tool", 
                            "report_num_started_tool", 
                            "report_num_analyzed_tool",
                            "describe_dropout_tool",
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
  input_id = rep(c("coi_statement_tool",
                   "coi_reported_tool"), each = 2),
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
  input_id = rep(c("treatm_dissolved_tool",
                   "indiv_housing_tool",
                   "cages_unit_tool"), each = 2),
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
  arrange(page) %>%
  mutate_all(as.character)

# Validation --------------------------------------------------------------

# get required questions from survey df
df_sections <- df %>% 
  filter(required %in% TRUE) %>% 
  select(input_id, page) %>% 
  unique() %>% 
  mutate(section = case_when(page %in% "1" ~ "metadata",
                             page %in% "2" ~ step_ids[[1]],
                             page %in% "3" ~ step_ids[[2]],
                             page %in% "4" ~ step_ids[[3]],
                             page %in% "5" ~ step_ids[[4]],
                             page %in% "6" ~ step_ids[[5]],
                             page %in% "7" ~ step_ids[[6]],
                             page %in% "8" ~ step_ids[[7]],
                             page %in% "9" ~ step_ids[[8]],
                             page %in% "10" ~ step_ids[[9]],
                             page %in% "11" ~ step_ids[[10]],
                             page %in% "12" ~ step_ids[[11]],
                             page %in% "13" ~ step_ids[[12]])) %>% 
  mutate(item_iv = paste0(input_id, "_iv")) %>% 
  mutate(section_iv = paste0(section, "_iv")) %>% 
  mutate(item_class = paste0(input_id, "-question"))


# Clean responses ---------------------------------------------------------

outcomes <- fread(here::here("data","outcomes.csv"), header = T, na.strings = c("")) %>%
  select(bias_type, response, outcome)

# tidy survey responses
tidy_responses <- function(responses){
  responses <- responses %>%
    mutate(study_id = responses %>% filter(question_id %in% "study_id") %>% pull(response)) %>%
    mutate(study_doi = (responses %>% filter(question_id %in% "study_doi") %>% pull(response))) %>% 
    rename(response_id = response) %>% 
    mutate(response = interaction(question_id, response_id)) %>%
    filter(!question_id %in% c("study_id","study_doi")) %>% 
    left_join(outcomes, by="response")
    # filter(!is.na(outcome)) %>% 
    # select(study_id, study_doi, question_id, bias_type, response_id, outcome)
  return(responses)
}

# reformat input files for robvis plots
prepare_robvis <- function(dat){
  dat <- dat %>% 
    select(study_id, bias_type, outcome) %>% 
    group_by(study_id) %>% 
    pivot_wider(names_from = bias_type, values_from = outcome) %>% 
    rename_with(~gsub("_"," ", .) %>% str_to_title(.), -1)
  return(dat)
}


# Show outcomes in app ----------------------------------------------------

outcomes_app <- outcomes %>% 
  separate(response, into = c("input_id", "response"), sep = "\\.") %>% 
  left_join(
    (df_sections %>% 
      select(input_id, section)
    ), by = "input_id"
  ) %>% 
  mutate(input_response = interaction(input_id, response)) %>% 
  select(-c(bias_type, input_id, response))
  
  