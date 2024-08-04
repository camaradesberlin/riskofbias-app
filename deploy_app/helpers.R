# Libraries ---------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyalert)
library(shinyWidgets)
library(shinyvalidate)
library(shinyFeedback)
library(bslib)
library(data.table)
library(dplyr)
library(htmltools)
library(sass)
library(magrittr)
library(rvest)
library(markdown)
library(tidyr)
library(stringr)
library(shinysurveys)
library(robvis)
library(ggplot2)

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
    # "10.2 Unit of analysis bias",
    "10.2 Addition of animals"
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

# add question type "comments" in survey df
add_comments <- function(df) {
  df <- df %>% 
    group_by(input_id) %>% 
    group_modify(~ add_row(
      option = "",
      input_type = "text", 
      required = FALSE,
      question = "Justification",
      .x)) %>% 
    fill(input_id, page, dependence, dependence_value, order, .direction = "downup") %>% 
    mutate(input_id = ifelse(question == "Justification", 
                             gsub("_tool", "_comments_tool", input_id), input_id)) %>% 
    ungroup()
}


# Custom theme ------------------------------------------------------------

mystyle <- sass::sass(
  list(
    list(
      color = "#60ab9b"
      ),
    readLines(
      "www/style.scss"
      )
    )
  )


# Validation --------------------------------------------------------------

source("questions.R")

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
                             # page %in% "12" ~ step_ids[[11]],
                             page %in% "12" ~ step_ids[[11]])) %>% 
  mutate(item_iv = paste0(input_id, "_iv")) %>% 
  mutate(section_iv = paste0(section, "_iv")) %>% 
  mutate(item_class = paste0(input_id, "-question"))


# Clean responses ---------------------------------------------------------

outcomes <- fread("data/outcomes_v2.csv", header = T, na.strings = c("")) %>%
  select(bias_type, response, outcome)

# tidy survey responses
tidy_responses <- function(dat){

  study_id <- dat %>% filter(question_id %in% "study_id") %>% pull(response)
  study_doi <- dat %>% filter(question_id %in% "study_doi") %>% pull(response)
  
  dat <- dat %>%
    mutate_all(na_if,"") %>%
    mutate(study_id = study_id) %>%
    mutate(study_doi = study_doi) %>% 
    rename(response_id = response) %>% 
    mutate(response = interaction(question_id, response_id)) %>%
    filter(!question_id %in% c("study_id","study_doi")) %>% 
    left_join(outcomes, by="response") %>% 
    mutate(outcome = ifelse(str_detect(question_id, "comment"), "comment", outcome)) %>% 
    filter(!response_id %in% "HIDDEN-QUESTION") %>%
    unite("value", c("response_id", "outcome")) %>%
    mutate(item = ifelse(str_detect(question_id, "comments"),
                         str_remove(question_id, "_comments_tool"),
                         str_remove(question_id, "_tool"))) %>%
    mutate(type = ifelse(str_detect(question_id, "comments"), "comment", "response")) %>%
    select(-c(question_id, response, subject_id, question_type)) %>% 
    group_by(item) %>%
    fill(bias_type) %>% 
    pivot_wider(names_from = type, values_from = value) %>%
    ungroup() %>%
    mutate(comment = str_extract(comment, "[^_]+")) %>%
    rename(question_id = item) %>%
    group_by(bias_type) %>%
    filter(!str_detect(response, "NA")) %>%
    slice(1) %>%
    ungroup() %>%
    separate(response, into=c("response_id", "outcome")) %>%
    mutate_all(na_if, "NA") %>%
    select(study_id, study_doi, question_id, bias_type, response_id, outcome, comment)
  return(dat)
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
  
