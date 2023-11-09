# Load data ---------------------------------------------------------------

source(here::here("scripts","helpers.R"))
source(here::here("scripts","tabs.R"))


header <- dashboardHeader(title = "CAMARADES Risk of Bias Assessment Tool",
                          titleWidth = 450)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      "About", tabName = "about"
      ),
    menuItem(
      "Types of bias", tabName = "tob",
      menuSubItem(
        "Selection Bias", tabName = "select_bias"
        ),
      menuSubItem(
        "Performance Bias", tabName = "perform_bias"
        ),
      menuSubItem(
        "Detection Bias", tabName = "detect_bias"
        ),
      menuSubItem(
        "Attrition Bias", tabName = "attr_bias"
        ),
      menuSubItem(
        "Reporting Bias", tabName = "report_bias"
        ),
      menuSubItem(
        "Other Sources of Bias", tabName = "other_bias"
        )
      ),
    menuItem(
      "Assessment tool", tabName = "tool"
    ),
    menuItem(
      "Visualize data", tabName = "data_viz"
    )
  )
)

body <- dashboardBody(
  useShinyjs(),
  tabItems(
    about,
    types,
    selection_bias,
    performance_bias,
    detection_bias, 
    attrition_bias, 
    reporting_bias,
    other_bias,
    tool
    )
  )


ui <- dashboardPage(header, sidebar, body)

server <- function(input, output, session) {
  
  shinysurveys::renderSurvey()
  
  # aggregate responses to one df
  response_data <- eventReactive(input$submit, {
    shinysurveys::getSurveyData() 
    # tidy up this function for desired output
  })
  
  # get study id for output filename
  study_id <- reactive({
    response_data() %>% 
      filter(question_id %in% "study_id") %>% 
      select(response)
  })
  
  # when responses are submitted show Download button and reset input values
  observeEvent(input$submit, {
    shinyjs::show("downloadResponses")
    # shinyjs::reset("tool") # does not work?
  })
  
  # download responses (csv file)
  output$downloadResponses <- downloadHandler(
        filename = function() {
          paste0(study_id(), "_RoB_", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(response_data(), file)
        }
      )
}

shinyApp(ui, server)


