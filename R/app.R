# Source scripts ----------------------------------------------------------

source(here::here("R","helpers.R"))
source(here::here("R","tabs.R"))
source(here::here("R","validation.R"))


# UI ----------------------------------------------------------------------

header <- dashboardHeader(title = "CAMARADES Risk of Bias Assessment Tool",
                          titleWidth = 450)

sidebar <- dashboardSidebar(
  width = 280,
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
        "Selection bias",
        tabName = "selection_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[1]],
          tabName = step_ids[[1]]
          ),
        menuSubItem(
          icon = NULL,
          tool_steps[[2]],
          tabName = step_ids[[2]]
          ),
        menuSubItem(
          icon = NULL,
          tool_steps[[3]],
          tabName = step_ids[[3]]
          )
        ),
      menuItem(
        "Performance bias",
        tabName = "performance_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[4]],
          tabName = step_ids[[4]]
          ),
        menuSubItem(
          icon = NULL,
          tool_steps[[5]],
          tabName = step_ids[[5]]
          )
        ),
      menuItem(
        "Detection bias",
        tabName = "detection_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[6]],
          tabName = step_ids[[6]]
        ),
        menuSubItem(
          icon = NULL,
          tool_steps[[7]],
          tabName = step_ids[[7]]
        )
      ),
      menuItem(
        "Attrition bias",
        tabName = "attrition_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[8]],
          tabName = step_ids[[8]]
        )
      ),
      menuItem(
        "Reporting bias",
        tabName = "reporting_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[9]],
          tabName = step_ids[[9]]
        )
      ),
      menuItem(
        "Other sources of bias",
        tabName = "other_bias",
        menuSubItem(
          icon = NULL,
          tool_steps[[10]],
          tabName = step_ids[[10]]
        ),
        menuSubItem(
          icon = NULL,
          tool_steps[[11]],
          tabName = step_ids[[11]]
        ),
        menuSubItem(
          icon = NULL,
          tool_steps[[12]],
          tabName = step_ids[[12]]
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
    ),
    menuItem(
      "Test your skills",
      tabName = "practice"
    )
  )
)


body <- dashboardBody(
  useShinyjs(),
  tags$style(shiny::HTML(mystyle)),
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
    plots,
    practice
    )
  )


ui <- dashboardPage(header, sidebar, body)


# Server ------------------------------------------------------------------


server <- function(input, output, session) {
  

# Gather and clean responses ----------------------------------------------

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
  

# Download responses ------------------------------------------------------

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
  

# Read input file ---------------------------------------------------------

  # read in uploaded data
  userdata <- reactive({ 
    req(input$uploadfile) #  require that the input is available
    
    inFile <- input$uploadfile 
    
    df <- read.csv(inFile$datapath, sep = ",")
    
    return(df)
  })
  
  

# Plotting ----------------------------------------------------------------

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
  

# Download plots ----------------------------------------------------------

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
  

# Cross-ref tabs ----------------------------------------------------------
  
  lapply(
    step_ids,
    function(i){
      observeEvent(input[[paste0(i, "_title")]], {
        updateTabItems(session, inputId = "sidebarmenu", selected = i)
        
      })
    }
  )
  


# Validation --------------------------------------------------------------
  
  # get ids of hidden questions
  observe({
    runjs("
       hiddenDivs = $('.dependence');
       var hiddenInputIds = [];
       var i;
       for (i = 0; i < hiddenDivs.length; i++) {
       hiddenInputIds[i] = $(hiddenDivs[i]).attr('id');
       }
       Shiny.setInputValue('shinysurveysHiddenInputs', hiddenInputIds);
    ")
  })

  
  # define sections based on visible (required) questions
  required_df <- reactive({
    df_sections %>% 
      filter(!input_id %in% input$shinysurveysHiddenInputs)
  })
  
  # test if code is working
  # observeEvent(input$testvalidation, {
  #   print(required_df())
  # })
  
  sections <- unique(df_sections$section)

  observe({
    
  
    for(i in sections) {
      itemname <- paste0(i, "_items")
      assign(itemname, (required_df()[required_df()$section == i, "input_id"])$input_id)
      
    
      is_complete <- all(
        sapply(
          eval(parse(text = itemname)), function(x){
            isTruthy(input[[x]])
            }
          )
      )
    
      if(!is_complete) {

        shinyjs::addClass(
          id = gsub("items","check", itemname),
          class = "fa-solid fa-exclamation"
        )
      } else if(is_complete) {
        shinyjs::removeClass(
          id = gsub("items","check", itemname),
          class = "fa-solid fa-exclamation"
          )
        shinyjs::addClass(
          id = gsub("items","check", itemname),
          class = "fa-solid fa-check"
          )
      }

    }
    
  })

# Reset responses ---------------------------------------------------------

  # start over 
  observeEvent(input$startover, {
    
    shinyalert::shinyalert(
      title = "",
      "This will refresh the page and all previous responses will be deleted. Are you sure you want to continue?",
      animation = FALSE,
      showCancelButton = TRUE,
      confirmButtonText = "Start over"
      )
    
    observeEvent(input$shinyalert, {
      
      if (input$shinyalert) {
        session$reload()
        # and move to tool tab
        
      }
    })
    
  })
  
  # reload session to reset responses
  observeEvent(input$resetResponses, {
    session$reload()
  })
  
}

shinyApp(ui, server)


