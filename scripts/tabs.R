
# Information section -----------------------------------------------------

about <- tabItem(
  tabName = "about",
  h1("Welcome!"),
  lorem::ipsum(paragraphs = 1),
  h2("How to use this app"),
  lorem::ipsum(paragraphs = 2)
)


# Selection bias ----------------------------------------------------------


types <- tabItem(
  tabName = "tob",
  h1("Types of bias"),
  "There are several types of bias."
)

# testBox <- semantic.dashboard::tabItem(
#   tabName = "data_viz",
#   h1("Test box"),
#   br(),
#   semantic.dashboard::tabBox(
#     title = "test tab box",
#     ribbon = TRUE,
#     color = "blue",
#     tabs = list(
#       list(menu = "First Tab", content = "This is first tab"),
#       list(menu = "Second Tab", content = "This is second tab")
#       )
#     )
#   )

selection_bias <- tabItem(
  tabName = "select_bias",
  h1("Selection bias"),
  br(),
  tabBox(
    title = "Sequence allocation",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Baseline characteristics",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Allocation concealment",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
    )
  )



# Performance bias --------------------------------------------------------


performance_bias <- tabItem(
  tabName = "perform_bias",
  h1("Performance bias"),
  br(),
  tabBox(
    title = "Random housing",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Blinding",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  )
)


# Detection bias ----------------------------------------------------------

detection_bias <- tabItem(
  tabName = "detect_bias",
  h1("Detection bias"),
  br(),
  tabBox(
    title = "Blinded experiment conduct",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Random outcome assessment",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  )
)


# Attrition bias ----------------------------------------------------------

attrition_bias <- tabItem(
  tabName = "attr_bias",
  h1("Attrition bias"),
  br(),
  tabBox(
    title = "Incomplete outcome data",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  )
)


# Reporting bias ----------------------------------------------------------

reporting_bias <- tabItem(
  tabName = "report_bias",
  h1("Reporting bias"),
  br(),
  tabBox(
    title = "Selective outcome reporting",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  )
)

# Other sources of bias ---------------------------------------------------

other_bias <- tabItem(
  tabName = "other_bias",
  h1("Other sources of bias"),
  br(),
  tabBox(
    title = "Inappropriate influence of funders",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Unit of analysis bias",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
    )
  ),
  tabBox(
    title = "Addition of animals",
    side = "right",
    selected = "Description",
    tabPanel(
      "Examples",
      lorem::ipsum(sentences = 2)
    ),
    tabPanel(
      "Questions",
      lorem::ipsum(sentences = 1),
      br(),
      lorem::ipsum(sentences = 1)
    ),
    tabPanel(
      "Description",
      lorem::ipsum(paragraphs = 2)
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
      )
    )
  )




