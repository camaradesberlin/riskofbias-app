# Load packages
library(shiny)
library(shinysurveys)
library(tidyverse)
library(shinydashboard)

source(here::here("R","helpers.R"))
source(here::here("R","tabs.R"))


# Define shiny UI

ui <- fluidPage(
  surveyOutput(df,
               
               survey_title = "Hello, World!"
               )
)

header <- dashboardHeader(title = "CAMARADES Risk of Bias Assessment Tool",
                          titleWidth = 450)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      "Welcome", tabName = "welcome"
    ),
    menuItem(
      "RoB Assessment", tabName = "rob"
    )
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "welcome",
      h1("Welcome!"),
      lorem::ipsum(paragraphs = 2)
    ),
      tabItem(
        tabName = "rob",
        fluidPage(
          shinysurveys::surveyOutput(df, survey_title = "Risk of Bias Assessment")
        )
      ),
    tool
    )
  )


ui <- dashboardPage(header, sidebar, body)

# Define shiny server
server <- function(input, output, session) {
  renderSurvey()

  observeEvent(input$submit, {
    response_data <- getSurveyData()
    showModal(modalDialog(
      title = "Congrats, you completed your first risk of bias evaluation!"
    ))
  })
}

# Run the shiny application
shinyApp(ui, server)









# test --------------------------------------------------------------------
# 
# library(shiny)
# # remotes::install_github("jdtrat/shinysurveys")
# library(shinysurveys)
# library(tidyverse)
# 
# instructions_df <- data.frame(question = c("This is an instructions block! It now supports markdown syntax. For example:
#                                            To **bold**, you can use double asterisks (\\*\\*). *Italicize* with single asterisks (\\*).", 
#                                            "# Use a \\# for titles
#                                            #### \\#\\#\\#\\# for smaller titles
#                                            Here's some `inline code` because we can!
#                                            ",
#                                            "Do you like this new formatting feature?"),
#                               option = c(NA, NA, "Yes!"),
#                               input_type = c("instructions", "instructions", "text"),
#                               input_id = c("markdown_instructions", "markdown_instructions2", "like_new_feature"),
#                               dependence = NA,
#                               dependence_value = NA,
#                               required = F) %>%
#   mutate_all(as.character)
# 
# ui <- fluidPage(
#   surveyOutput(instructions_df, 
#                survey_title = "Markdown Support for 'Instructions' Blocks")
# )
# 
# server <- function(input, output, session) {
#   renderSurvey()
# }
# 
# shinyApp(ui, server)
