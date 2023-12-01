# Load data ---------------------------------------------------------------

source(here::here("scripts","helpers.R"))
source(here::here("scripts","tabs.R"))


header <- dashboardHeader(title = "CAMARADES Risk of Bias Assessment Tool",
                          titleWidth = 450)


sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "tabs",
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
      "Plots", tabName = "plots"
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
  
  # get plot format
  plotformat <- reactive({
    switch(input$plotformat,
           `Traffic light plot` = "rob_traffic_light",
           `Summary plot` = "rob_summary"
    )
  })
  
  # generate plot
  observeEvent(input$generateplot, {
    output$robplot <- renderPlot({
      
      # if(plotformat() %in% "rob_traffic_light") {
      #   robvis::rob_traffic_light(data_plot(), tool = "Generic")
      # }
      # if(plotformat() %in% "rob_summary") {
      #   robvis::rob_summary(data_plot(), tool = "Generic")
      # }
      robvis::rob_traffic_light(data_plot(), tool = "Generic")
    })
  })
  
  # traffic light plots
  # output$trafficlightplot <- renderPlot({
  #   robvis::rob_traffic_light(data_plot(), tool = "Generic")
  # })
  # 
  # output$robsummaryplot <- renderPlot({
  #   robvis::rob_summary(data_plot(), tool = "Generic")
  # })
  
  # reset responses
  observeEvent(input$resetResponses, {
    session$reload()
  })
  
}

shinyApp(ui, server)


