
# Information section -----------------------------------------------------

about <- tabItem(
  tabName = "about",
  h1("Welcome!"),
  lorem::ipsum(paragraphs = 1),
  h2("How to use this app"),
  lorem::ipsum(paragraphs = 2)
)



# Sequence allocation -----------------------------------------------------

sequence_allocation <- tabItem(
  tabName = "sequence_allocation",
  h1("Sequence allocation"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Did the authors compare two cohorts of the same genetic model?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Do the authors report random allocation to group?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Did the authors describe a random component in the sequence generation process?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Was the method chosen appropriate to achieve random sequence allocation?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
        )
      )
    )
  )


# Baseline characteristics ------------------------------------------------

baseline_characteristics <- tabItem(
  tabName = "baseline_characteristics",
  h1("Baseline characteristics"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Do the authors report the baseline characteristics age, sex AND weight in the methods, results or supplements?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Are the groups similar at baseline with respect to age, sex and weight?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Did the authors adjust the statistical analyses for confounders?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)



# Allocation concealment --------------------------------------------------

allocation_concealment <- tabItem(
  tabName = "allocation_concealment",
  h1("Allocation concealment"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Was the allocation (randomization) procedure described in the methods?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Was sequence generation conducted by someone not involved in the experiment?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Was the allocation concealment appropriate?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)


# Random housing ----------------------------------------------------------

random_housing <- tabItem(
  tabName = "random_housing",
  h1("Random housing"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Was housing described in the methods?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were cages placed randomly within the housing facility?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)



# Blinding ----------------------------------------------------------------

blinded_conduct <- tabItem(
  tabName = "blinded_conduct",
  h1("Blinded conduct of the experiment"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Is blinding mentioned?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Is the method of blinding described appropriate?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)


# Random outcome assessment -----------------------------------------------

random_outcome <- tabItem(
  tabName = "random_outcome",
  h1("Random outcome assessment"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Is randomization mentioned?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Is the method of randomization described appropriate?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)


# Blinded outcome assessment ----------------------------------------------

blind_outcome <- tabItem(
  tabName = "blind_outcome",
  h1("Blinded outcome assessment"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Is blinding mentioned?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Is the method of blinding described appropriate?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)

# Attrition ---------------------------------------------------------------

incomplete_outcome <- tabItem(
  tabName = "incomplete_outcome",
  h1("Incomplete outcome data"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Is there a section specifically describing drop-outs or mortality?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Do the numbers of animals that started the experiment and were analysed match?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Are the number and the reason for drop-out/death specified and equally distributed per group?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were missing data imputed using appropriate statistical methods?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)


# Selective outcome reporting ---------------------------------------------

selective_reporting <- tabItem(
  tabName = "selective_reporting",
  h1("Selective outcome reporting"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Was the study protocol available and published prior to the study results?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were results reported for all experiments outlined in the methods section and is the study is free of explicitly unpublished results?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Do all the outcomes in the protocol and in the final report match or were deviations reported?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were all pre-specified outcomes conducted and reported as planned or were deviations explained?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)


# Other bias --------------------------------------------------------------

funder_influence <- tabItem(
  tabName = "funder_influence",
  h1("Inappropriate influence of funders"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Were sources of funding reported?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Did the authors report a conflict of interest?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)

analysis_unit <- tabItem(
  tabName = "analysis_unit",
  h1("Unit of analysis bias"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Were treatments given dissolved in either food or drinking water?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were animals housed individually?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    ),
    tabBox(
      title = "Were cages (not individual animals) compared statistically as the unit of analysis?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
)
animal_addition <- tabItem(
  tabName = "animal_addition",
  h1("Addition of animals"),
  lorem::ipsum(paragraph = 1),
  br(),
  fluidRow(
    tabBox(
      title = "Was it explicitly stated that animals were added to any cohort to replace missing ones?",
      width = 4,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        lorem::ipsum(sentences = 2)
      ),
      tabPanel(
        "Description",
        lorem::ipsum(paragraphs = 1)
      )
    )
  )
) 

# Assessment tool ---------------------------------------------------------


tool <- tabItem(
  tabName = "tool",
  h1("Risk of bias assessment"),
  shiny::fluidPage(
    shinysurveys::surveyOutput(df),
    shinyjs::hidden(
      downloadButton(
        "downloadResponses","Download responses"
        )
      ),
    shinyjs::hidden(
      actionButton(
        "resetResponses","Reset responses"
        )
      )
    )
  )


# Data visualization ------------------------------------------------------

plots <- tabItem(
  tabName = "plots",
  h1("Risk of bias plots"),
  fluidRow(
    column(
      width = 6,
      box(
        title = "Upload data",
        selectInput(
          inputId = "dataformat",
          label = "Select data format",
          choices = list("app","SyRF"),
          selected = character(0)
          ),
        fileInput(
          inputId = "uploadfile", 
          label = "Upload csv file",
          accept = c(".csv")
        ),
        selectInput(
          inputId = "plotformat",
          label = "Select type of plot",
          choices = list("Traffic light plot", "Summary plot"),
          selected = character(0)
        ),
        actionButton(
          inputId = "generateplot",
          label = "Generate plot"
        ),
        shinyjs::hidden(
          selectInput(
            inputId = "plotOutputFormat",
            label = "Select format of plot output",
            choices = list(".png",".jpg",".tiff")
          )
        ),
        shinyjs::hidden(
          downloadButton(
            "downloadPlot","Download plot"
          )
        )
      )
    ),
    column(
      width = 6,
      plotOutput("robplot")
      # plotOutput("trafficlightplot"),
      # plotOutput("robsummaryplot")
      )
    )
  )

