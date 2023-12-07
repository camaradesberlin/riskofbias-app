# Load data ---------------------------------------------------------------

source(here::here("scripts","helpers.R"))
source(here::here("scripts","tabs.R"))


header <- dashboardHeader(title = "CAMARADES Risk of Bias Assessment Tool",
                          titleWidth = 450)

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebarmenu",
    menuItem(
      "About",
      tabName = "about"
      ),
    menuItem(
      "Types of bias",
      tabName = "types",
      menuItem(
        "Selection bias", startExpanded = TRUE,
        tabName = "selection_bias",
        menuSubItem(
          "1. Sequence allocation",
          tabName = "sequence_allocation"
          ),
        menuSubItem(
          "2. Baseline characteristics",
          tabName = "baseline_characteristics"
          ),
        menuSubItem(
          "3. Allocation concealment",
          tabName = "allocation_concealment"
          )
        ),
      menuItem(
        "Performance bias",
        tabName = "performance_bias",
        menuSubItem(
          "4. Random housing",
          tabName = "random_housing"
          ),
        menuSubItem(
          "5. Blinded conduct of the experiment",
          tabName = "blinded_conduct"
          )
        ),
      menuItem(
        "Detection bias",
        tabName = "detection_bias",
        menuSubItem(
          "6. Random outcome assessment",
          tabName = "random_outcome"
        ),
        menuSubItem(
          "7. Blinded outcome assessment",
          tabName = "blind_outcome"
        )
      ),
      menuItem(
        "Attrition bias",
        tabName = "attrition_bias",
        menuSubItem(
          "8. Incomplete outcome data",
          tabName = "incomplete_outcome"
        )
      ),
      menuItem(
        "Reporting bias",
        tabName = "reporting_bias",
        menuSubItem(
          "9. Selective outcome reporting",
          tabName = "selective_reporting"
        )
      ),
      menuItem(
        "Other sources of bias",
        tabName = "other_bias",
        menuSubItem(
          "10.1 Inappropriate influence of funders",
          tabName = "funder_influence"
        ),
        menuSubItem(
          "10.2 Unit of analysis bias",
          tabName = "analysis_unit"
        ),
        menuSubItem(
          "10.3 Addition of animals",
          tabName = "animal_addition"
        )
      )
    ),
    menuItem(
      "Assessment tool",
      tabName = "tool"
    ),
    menuItem(
      "Plots",
      tabName = "plots"
    )
  )
)


body <- dashboardBody(
  useShinyjs(),
  tabItems(
    about,
    sequence_allocation,
    baseline_characteristics,
    allocation_concealment,
    random_housing,
    blinded_conduct,
    random_outcome,
    blind_outcome,
    incomplete_outcome,
    selective_reporting,
    funder_influence,
    analysis_unit,
    animal_addition,
    tool,
    plots
    )
  )


ui <- dashboardPage(header, sidebar, body)

server <- function(input, output, session) {
  
  shinysurveys::renderSurvey()
  
  # aggregate responses to one df
  response_data <- eventReactive(input$submit, {
    shinysurveys::getSurveyData()
    
  })
  
  # tidy up df for desired output
  data_tidy <- reactive({
    response_data() %>% 
      tidy_responses()
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
    shinyjs::show("resetResponses")
  })
  
  # download responses (csv file)
  output$downloadResponses <- downloadHandler(
        filename = function() {
          paste0(study_id(), "_RoB_", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(data_tidy(), file)
        }
      )
  

  # read in uploaded data
  userdata <- reactive({ 
    req(input$uploadfile) #  require that the input is available
    
    inFile <- input$uploadfile 
    
    df <- read.csv(inFile$datapath, sep = ",")
    
    return(df)
  })
  
  
  # prepare responses for plotting
  data_plot <- reactive({
    userdata() %>% 
      prepare_robvis()
  })
  
  
  # generate plot
  observeEvent(input$generateplot, {
    output$robplot <- renderPlot({
      if (input$showPlotType == "Traffic light plot"){
        robvis::rob_traffic_light(data_plot(), tool = "Generic")
      }
      else if (input$showPlotType == "Summary plot"){
        robvis::rob_summary(data_plot(), tool = "Generic")
      } 
    })
  })
  
  plot.format <- reactive({
    switch(
      input$formatplot,
      "png" = "png",
      "pdf" =	"pdf",
      "tiff" =	"tiff"
    )
  })
    
  plot.type <- reactive({
    switch(
      input$savePlotType,
      "Traffic light" = "trafficLightPlot",
      "Summary" =	"summaryPlot"
      )
    })
  
  
  output$downloadPlot <- downloadHandler(
    filename = function() { 
      in_filename <- tools::file_path_sans_ext(input$uploadfile)
      paste0(in_filename, "_RoB_", plot.type(), ".", plot.format())
      },
    content = function(file) {
      if (input$savePlotType == "Traffic light") {
        p_traffic <- robvis::rob_traffic_light(data_plot(), tool = "Generic")
        ggsave(file, plot = p_traffic, device = plot.format())
      }
      
      else if (input$savePlotType == "Summary") {
        p_summary <- robvis::rob_summary(data_plot(), tool = "Generic")
        ggsave(file, plot = p_summary, device = plot.format())
        
      }
    }
  )
  
  # reload session to reset responses
  observeEvent(input$resetResponses, {
    session$reload()
  })
  
}

shinyApp(ui, server)


