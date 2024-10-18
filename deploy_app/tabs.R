
# Information section -----------------------------------------------------

about <- tabItem(
  tabName = "about",
  fluidPage(
    h1("Welcome"),
    br(),
    shiny::markdown(
      "
      ## CAMARADES Risk of Bias app
      
      Welcome! Here you will find information on the different types of bias present in preclinical experimental studies. 
      Our goal is to provide a comprehensive resource on how different types of bias present in the literature and what kind of questions 
      can be asked to evaluate risk of bias in preclinical studies. 
      
      Navigate through the different sections on the left-side panel to:
      
      - learn all about the different aspects of bias and how to assess risk of bias in preclinical studies
      
      - conduct a risk of bias assessment yourself on a study of your choice. 
      
      - export the results of your assessment and visualize them using 'traffic-light' plots.
      
      <br>
      
      <br>
      
      ## About the team
      
      The CAMARADES Collaborative Approach to Meta-Analysis and Review of Animal Data from Experimental Studies group 
      specialize in performing systematic review and meta-analysis of data from experimental studies. If you have questions about this resource, please email us at: xxx
      "
      ),
    br(),
    br(),
    br(),
    shiny::markdown(
      "
      ## Acknowledgements
      
      The assessment tool implemented in this app is based on the SYRCLE's risk of bias tool for animal studies (Hooijmans et al., 2014). 
      The visualizations are created using tools from the R package `robvis` (McGuinness and Higgins, 2020).
      
      <br>
      
      Hooijmans, C.R., Rovers, M.M., de Vries, R.B. et al. SYRCLE’s risk of bias tool for animal studies. BMC Med Res Methodol 14, 43 (2014). https://doi.org/10.1186/1471-2288-14-43
      
      McGuinness, LA, Higgins, JPT. Risk-of-bias VISualization (robvis): An R package and Shiny web app for visualizing risk-of-bias assessments. Res Syn Meth. 2020; 1- 7. https://doi.org/10.1002/jrsm.1411
      "
    )
  )
)

# Sequence allocation -----------------------------------------------------

# "Were experimental procedures such that random sequence allocation was possible?"
# "Did the authors report on any method of sequence allocation"
# "Did the authors explicitly state that sequence allocation was randomized?"
# "Did the authors describe a random component in the sequence generation process?"
# "Was the method chosen appropriate to achieve random sequence allocation?"

sequence_allocation <- tabItem(
  tabName = step_ids[[1]],
  h1("1. Sequence allocation"),
  "Sequence allocation refers to the allocation of animals to the experimental and 
  control groups. This should be adequately generated, but also adequately applied, with 
  appropriate randomization. This item assesses whether the methodology used to generate
  the allocation sequence is described in sufficient detail to allow an assessment 
  whether it should produce comparable groups. The following signaling questions may be
  used to guide assessment of this domain.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were experimental procedures such that random sequence allocation was possible?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Examples of cases where random sequence allocation is not possible:"),
        p("- Comparison of different genetic models"),
        p("- Animals were obtained from different suppliers"),
        p("- Use of a historical control group"),
        p("- Experiments were performed across different institutes"),
        br(),
        p("E.g., in a study by Hintz et al, the authors aim to investigate the role of a specific pathway X-Y by blocking the Y receptor. 
          Therefore, the genetically modified X/Y +/- mouse model is established. Determined by the genetic modification, 
          randomly choosing which animals belongs to which group is no longer possible. Even though, it is not on purpose, 
          systematic differences in addition to the genetic modification are possible and cannot be distributed among groups 
          by using a randomization procedure anymore. The rater for the systematic review therefore rates here the bias in 
          the selection process as high risk of bias.")
        ),
      tabPanel(
        "Description",
        p("There are cases where randomizing the sequence allocation is not possible, due to the experimental
        design of the study. This would indicate a high risk of bias for sequence allocation.")
      )
    ),
    tabBox(
      title = ("Did the authors report on any method of sequence allocation"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("In the methods section of their article Kunz et al mention did not mention any selection procedure at all. 
          There was neither a statement that animals were selected based on some criteria nor whether any 
          randomization was used. It is therefore difficult for the rater to judge whether any risk of bias 
          is present in the selection process. Therefore, this item is judged with an unclear risk of bias.")
      ),
      tabPanel(
        "Description",
        p("If there is no description of how sequence allocation was performed, we cannot evaluate
          whether appropriate randomization methods were used.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Did the authors explicitly state that sequence allocation was randomized?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Example of an explicit statement on random allocation:"),
        p("-", a(href="https://pubmed.ncbi.nlm.nih.gov/30077000/", "Aliena-Valero et al. (2018)"),
          "'Male or female animals were randomly assigned to vehicle- or UA-treatment'"),
        p("Example of explicitly stating no randomization:"),
        p("In their study the authors Karate et al report that they did not randomize during 
          their selection process. Although, the selection process is transparently reported 
          it is not appropriate to reduce the risk of bias here. It is therefore rated with a high risk of bias.")
        ),
      tabPanel(
        "Description",
        p("Here, the question relates to a) the fact that randomization is described and 
          b) whether it was reported that randomization was done or not. 
          The question should be answered with ‘yes’, if the authors explicitly state that animals 
          were randomly allocated to a group and ‘no’ if the authors explicitly state that animals 
          were not randomized but allocated to some other set criteria.")
      )
    ),
    tabBox(
      title = ("Did the authors describe a random component in the sequence generation process?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("In the Study Design section of their manuscripts Hibiskus et al report that they 
          rolled a dice to determine in which group an animal was allocated. As there is a 
          random component in the randomization procedure, the rolling of a dice, the rater 
          can proceed to the next guiding question. If the method would not have been detailed 
          by Hibiskus et al, the rater would subsequently rate this item as ‘unclear’ risk of bias.")
      ),
      tabPanel(
        "Description",
        p("It is generally not sufficient to mention randomization alone, without describing
          the method used to achieve random sequence allocation.")
        )
      )
    ),
  fluidRow(
    tabBox(
      title = ("Was the method chosen appropriate to achieve random sequence allocation?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("-", 
          a(href="https://www.science.org/doi/10.1126/scitranslmed.aao6459", "Ali Alawieh et al. (2018)"),
          "'For all studies, before their initial acclimation on behavior tasks, animals were randomly assigned to treatment groups using a random number generator.'")
      ),
      tabPanel(
        "Description",
        p("Referring to a random number table or using a computer random number generator
        are adequate approaches to including a random component in the sequence generation
        process. Examples of a non-random approach may include: allocation by the investigator's
        preference/judgement, allocation based on the results of laboratory tests, allocation
        by availability of the intervention, sequence generated by some rule based on animal or
        cage number, and sequence generated by odd or even date of birth.")
        )
      )
    )
  )


# Baseline characteristics ------------------------------------------------

# "Were baseline characteristics (age, sex AND weight) described in the methods, results or supplements?",
# "Were baseline characteristics reported per group?",
# "Were the groups similar at baseline with respect to age, sex AND weight?",
# "Were the overall reported characteristics within reasonable range?",
# "Did the authors adjust the statistical analyses for confouders?"

baseline_characteristics <- tabItem(
  tabName = step_ids[[2]],
  h1("2. Baseline characteristics"),
  "This item refers to the distribution of relevant baseline characteristics for the different
  treatment groups. Depending on whether this distribution is balanced or unequal, 
  different actions are recommended to investigators in order to avoid bias.
  It is important to note that the number and type of baseline characteristics 
  are dependent on the review question. Before starting their risk of bias assessment, 
  reviewers need to discuss which baseline characteristics need to be comparable between the groups.
  A description of baseline characteristics and/or confounders usually contains: (1) the sex, age and 
  weight of the animals, and (2) baseline values of the outcomes which are of interest in the study.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were baseline characteristics (age, sex and weight) described in the methods, results or supplements?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Description",
        p("If any of the predefined baseline characteristics are not described anywhere in 
        the study, the risk of bias remains unclear. This holds even if the authors state 
        that groups did not differ at baseline.")
      )
    )
    ,tabBox(
      title = ("Were baseline characteristics reported per group?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Were the groups similar at baseline with respect to age, sex and weight?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Observed differences in baseline characteristics between groups might point to
          high risk of bias if not properly accounted for in the analysis.")
      )
    ),
    tabBox(
      title = ("Were the overall reported characteristics within reasonable range?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("-",
          a(href="https://www.ahajournals.org/doi/10.1161/ATVBAHA.123.320339", "Hagemann et al. (2024)"),
          "'Male C57Bl/6j mice (25–30 g body weight, 10–12 weeks; Envigo, Horst, the Netherlands)'")
      ),
      tabPanel(
        "Description",
        p("If the relevant baseline characteristics were not reported per group, it is important to evaluate
          whether the overall numbers reported are at least within reasonable range")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Did the authors adjust the statistical analyses for confounders?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("In the case of unequal distribution of baseline characteristics between groups, the
        risk of bias is declared low if the investigators adjust for it in the statistical
        analyses, and high if not.")
      )
    )
  )
)



# Allocation concealment --------------------------------------------------

# "Were experimental procedures such that allocation concealment was possible?",
# "Did the authors mention allocation concealment (blinding)?",
# "Did the authors explicitly state that allocation was not blinded?",
# "Was the allocation procedure described in the methods?",
# "Was the allocation concealment appropriate?"

allocation_concealment <- tabItem(
  tabName = step_ids[[3]],
  h1("3. Allocation concealment"),
  "Allocation concealment refers to the blinding of participants and personnel, which 
  can be a source of performance bias. In the case of animal studies, this refers predominantly 
  to the personnel involved in the experiments. This includes both researchers, as well as animal
  caregivers, as the handling of animals during the study while knowing the treatment condition
  could cause behavioral changes influencing the study results.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were experimental procedures such that allocation concealment was possible?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Examples of cases where random sequence allocation is not possible:"),
        p("- Comparison of different genetic models"),
        p("- Animals were obtained from different suppliers"),
        p("- Use of a historical control group"),
        p("- Experiments were performed across different institutes")
      ),
      tabPanel(
        "Description",
        p("There are cases where concealment (blinding) of sequence allocation is not possible, due to the experimental
        design of the study. This would indicate a high risk of bias.")
      )
    )
    ,tabBox(
      title = ("Did the authors mention allocation concealment (blinding)?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Did the authors explicitly state that allocation was not blinded?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Such a statement would indicate a high risk of bias.")
      )
    ),
    tabBox(
      title = ("Was the allocation procedure described in the methods?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Lack of information on how the procedure of sequence allocation occurred is indicative
          of unclear risk of bias in this domain.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Was the allocation concealment appropriate?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("-",
          a(href = "https://www.science.org/doi/10.1126/scitranslmed.adg8656", "Lyden et al. (2023)"),
          "'The CC managed the acquisition, packaging, masking, and distribution of all the test interventions; 
          the CC designed and implemented a feasible, scalable method of distributing multiple different treatment 
          interventions in a masked manner'")
      ),
      tabPanel(
        "Description",
        p("In cases where sequence allocation is done by third-parties not involved in the
          experimental study, concealment is deemed appropriate and indicates a low risk of  bias. 
          In addition to third-party group allocation, another example of appropriate concealment
          includes the use of properly safeguarded envelopes e.g. sequentially numbered
          opaque, sealed envelopes. On the other hand, inadequare approaches to concealment include: 
          open randomization schedule, envelopes without proper safeguard, alternation or rotation,
          allocation based on date of birth or animal number, or any other explicitly unconcealed
          procedure of a non-random approach.")
      )
    )
  )
)


# Random housing ----------------------------------------------------------

# "Was placement of animals and/or cages described?",
# "Were animals single housed?",
# "Were cages placed randomly within the cage facility?",
# "Were animals from different groups housed together?",
# "Were animals placed randomly within cages?"

random_housing <- tabItem(
  tabName = step_ids[[4]],
  h1("4. Random housing"),
  "This item refers to the housing conditions of animals during the experiment. As housing conditions 
  (such as lighting, humidity,  temperature, etc.) are known to 
  influence study outcomes (such as certain biochemical parameters and behavior), 
  it is important that the housing of these animals is randomized or, in other words, 
  comparable between the experimental groups in order to reduce the risk of performance bias.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Was placement of animals and/or cages described?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples"
      ),
      tabPanel(
        "Description",
        p("Lack of information on the housing conditions of animals during the
          study signals an unclear risk of bias, as it remains difficult to ascertain
          if these were handled appropriately.")
      )
    ),
    tabBox(
      title = ("Were animals single housed?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If animals were single-housed, then it is the random placement of cages (and not animals), that would indicate a low risk of bias.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Were cages placed randomly within the housing facility?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("When each animal is housed in a single cage, it is important that the placement of cages on shelves or rooms in the facility
        is random. For instance, the animals on the 
        top shelf experience a higher room temperature than animals on the lowest shelf, 
        and the temperature of the room may influence the toxicity of pharmacological 
        agents. Moreover, when cages are not placed randomly, it might be possible for the investigator to predict 
        the allocation of the animals to the various groups based on their housing conditions, which would indicate 
        performance bias.")
      )
    ),
    tabBox(
      title = ("Were animals from different groups housed together?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If animals from different groups were housed in the same cage, then it is the random placement of animals (and not cages)
          in the housing facility that would indicate a low risk of performance bias.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Were animals placed randomly within cages?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If animals from different experimental groups are housed in one cage, there is generally a low risk of bias in this domain.")
      )
    )
  )
)



# Blinding ----------------------------------------------------------------

# "Were experimental procedures such that blinding during the experiment was possible?",
# "Was blinding mentioned in the study?",
# "Was blinding of investigators and caregivers mentioned as a general statement regarding all procedures?",
# "Was the method of blinding described?",
# "Was the described method of blinding appropriate?",
# "Was blinding of investigators and caregivers explicitly stated?",
# "Was the method of blinding described?",
# "Was the described method of blinding appropriate?"

blinded_conduct <- tabItem(
  tabName = step_ids[[5]],
  h1("5. Blinded conduct of the experiment"),
  "This item evaluates whether the personnel (caregivers and/or investigators) were 
  blinded from knowledge on which intervention each animal received during the experiment.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were experimental procedures such that blinding during the experiment was possible?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Examples of cases where random sequence allocation is not possible:"),
        p("- Comparison of different genetic models"),
        p("- Animals were obtained from different suppliers"),
        p("- Use of a historical control group"),
        p("- Experiments were performed across different institutes")
      ),
      tabPanel(
        "Description",
        p("There are cases where blinding of experimental procedures is not possible, due to the
        design of the study. This would indicate a high risk of bias.")
      )
    ),
    tabBox(
      title = ("Was blinding mentioned in the study?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Lack of explicit statements on blinding of investigators and/or caregivers could 
        indicate an unclear risk of bias, given that insufficient information is available
          to evaluate the procedure.")
      )
    )
  ),
  # fluidRow(
  #   tabBox(
  #     title = ("Was blinding of investigators and caregivers mentioned as a general statement regarding all procedures?"),
  #     width = 6,
  #     side = "right",
  #     selected = "Description",
  #     tabPanel(
  #       "Examples",
  #       lorem::ipsum(sentences = 2)
  #     ),
  #     tabPanel(
  #       "Description",
  #       p("")
  #     )
  #   ),
  #   tabBox(
  #     title = ("Was blinding of investigators and caregivers explicitly stated?"),
  #     width = 6,
  #     side = "right",
  #     selected = "Description",
  #     tabPanel(
  #       "Examples",
  #       lorem::ipsum(sentences = 2)
  #     ),
  #     tabPanel(
  #       "Description",
  #       p("")
  #     )
  #   )
  # ),
  fluidRow(
    tabBox(
      title = ("Was the method of blinding described?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("A sufficient methodological description is needed to assess the risk of bias in this domain.")
      )
    ),
    tabBox(
      title = ("Was the described method of blinding appropriate?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Examples of appropriate blinding methods in this context include: using ID cards of 
        individual animals or cage/animal labels that are coded and identical in appearance, using 
        sequentially numbered drug containers are identical in appearance, specifying similar circumstances 
        during the intervention in both groups, and randomizing housing conditions of the animals during 
        the experiment (see section Random Housing). Inappropriate blinding procedures could include: differently
        colored cage labels per group, expected differences in visible effects between control and experimental 
        groups, non-randomized housing conditions and having the same individual(s) prepare, conduct and analyse
        the experiment. Inappropriate blinding could be in play when the intervention circumstances are not similar
        betwen groups, such as different timing of placebo/drug administration or using different instruments to
        carry out the same experimental procedures in the two groups.")
      )
    )
  )
)


# Random outcome assessment -----------------------------------------------

# "Were experimental procedures such that randomized outcome assessment during the experiment was possible?",
# "Was randomization described in the paper?",
# "Did the authors explicitly state that outcome assessment was not randomized?",
# "Were randomization procedures mentioned as a general statement regarding all components of the experiment?",
# "Was a random selection process for outcome assessment explicitly stated?",
# "Was the method of randomization described?",
# "Was the described method of randomization appropriate?"


random_outcome <- tabItem(
  tabName = step_ids[[6]],
  h1("6. Random outcome assessment"),
  "This item refers to determining whether or not animals were selected at random 
  for outcome assessment, regardless of the allocation to the experimental or control group. 
  For instance, when animals are sacrificed per group at various time points during the day, 
  the scientist concerned might interpret the results of the groups differently because she 
  or he can foresee or predict the allocation. Another reason to select animals at random for outcome 
  assessment is the presence of circadian rhythms in many biological processes. Not selecting the animals 
  for outcome assessment at random might influence the direction and magnitude of the effect.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were experimental procedures such that randomized outcome assessment during the experiment was possible?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Examples of cases where random sequence allocation is not possible:"),
        p("- Comparison of different genetic models"),
        p("- Animals were obtained from different suppliers"),
        p("- Use of a historical control group"),
        p("- Experiments were performed across different institutes")
      ),
      tabPanel(
        "Description",
        p("There are cases where random outcome assessment is not possible, due to the
        experimental design of the study. This would indicate a high risk of bias.")
      )
    )
    ,tabBox(
      title = ("Was randomization described in the paper?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Did the authors explicitly state that outcome assessment was not randomized?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Such statements would be a clear indication of a high risk of bias in this domain.")
      )
    ),
    tabBox(
      title = ("Were randomization procedures mentioned as a general statement regarding all components of the experiment?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("It is possible that authors provide a general statement in the beginning of the Methods section 
        stating that all procedures were conducted in a random manner. In this case, this general statement can be considered 
        to include specific outcome assessments. Neverthtless, the methods used to determine random outcome assessment
        still need to be described in order to achieve a low risk of bias in this domain.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Was a random selection process for outcome assessment explicitly stated?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("The authors need to explicitly described whether a random process was followed when assessing a specific outcome
          in order to be able to evaluate the risk of bias.")
      )
    ),
    tabBox(
      title = ("Was the method of randomization described?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If the exact method is not described, this would lead to an unclear risk of bias.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Was the described method of randomization appropriate?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Examples of appropriate (i.e. random) sequence generation methods include referring to a 
          random number table or using a computer random number generator. On the other hand, examples of
          inappropriate (non-random) sequence generation methods could be allocation by investigator's judgement or
          preference, allocation based on a series of tests or availability of intervention, or determining the sequence
          based on other arbitrary rules such as odd/even date of birth or cage number.")
      )
    )
  )
)


# Blinded outcome assessment ----------------------------------------------

# "Were experimental procedures such that blinded outcome assessment during the experiment was possible?",
# "Was blinding described in the paper?",
# "Did the authors explicitly state that outcome assessment was not blinded?",
# "Were blinding procedures mentioned as a general statement regarding all components of the experiment?",
# "Was blinding of outcome assessors explicitly stated?",
# "Was the method of blinding described?",
# "Was the described method of blinding appropriate?"

blind_outcome <- tabItem(
  tabName = step_ids[[7]],
  h1("7. Blinded outcome assessment"),
  "This refers to evaluating the methods used for outcome assessment in both the experimental and
  control groups, with regard to adequate blinding. This item should be assessed separately
  for each main outcome.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Were experimental procedures such that blinded outcome assessment during the experiment was possible?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("Examples of cases where random sequence allocation is not possible:"),
        p("- Comparison of different genetic models"),
        p("- Animals were obtained from different suppliers"),
        p("- Use of a historical control group"),
        p("- Experiments were performed across different institutes")
      ),
      tabPanel(
        "Description",
        p("There are cases where blinded outcome assessment is not possible, due to the
        experimental design of the study. This would indicate a high risk of bias.")
      )
    ),
    tabBox(
      title = ("Was blinding described in the paper?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Similar to random outcome assessment, the goal of this signaling question is to
          assess whether sufficient information is provided on adequately blinding outcome
          assessors.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Did the authors explicitly state that outcome assessment was not blinded?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    ),
    tabBox(
      title = ("Were blinding procedures mentioned as a general statement regarding all components of the experiment?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Was blinding of outcome assessors explicitly stated?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    ),
    tabBox(
      title = ("Was the method of blinding described?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = ("Was the described method of blinding appropriate?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("As with blinding of experiment conduct, appropriate concealment methods include
          the use of equipment such as ID cards, labels or drug containers that are coded and identical in 
          appearance between groups, as well as randomizing housing conditions. Respectively,
          inappropriate approaches to assessor blinding could include visibly different labels 
          (e.g. colored) per group, non-randomized housing conditions, or differences in the 
          circumstances under which intervention is administered (see also Item 5).")
      )
    )
  )
)

# Attrition ---------------------------------------------------------------

# "Was there a section specifically describing drop-outs or mortality?",
# "Was the number of animals that started the experiment (assigned to groups) explicitly reported?",
# "Was the number of animals that were analyzed (mentioned in the results text, tables or figure legends) explicitly reported?",
# "Did the numbers of animals that started the experiment and were analyzed match?",
# "Were there any drop-outs or mortality?",
# "Were the number AND the reason for drop-out/death specified PER GROUP?",
# "Were the number AND the reason for drop-out equally distributed across groups?",
# "Were missing data imputed using appropriate statistical methods?"

incomplete_outcome <- tabItem(
  tabName = step_ids[[8]],
  h1("8. Incomplete outcome data"),
  "This item evaluates whether incomplete outcome data were adequately addressed and the
  risk of bias associated with that.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = space_after("Was there a section specifically describing drop-outs or mortality?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("In order to be able to assess risk of bias in this domain, explicit description 
        of attrition in the study, such as mentioning drop-out and mortality should be
          provided.")
      )
    ),
    tabBox(
      title = ("Did the numbers of animals that started the experiment and were analyzed match?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If these numbers match, no drop-out may be assumed, which is in turn indicative of a
          low risk of bias. In case these numbers differ, unexplained drop-out rates would
          suggest a high risk of bias.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Were the number AND the reason for drop-out equally distributed across groups?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("In the presence of missing data, it is important that the authors clearly state
          the numbers related to drop-out across groups, as well as the reasons, so potential
          group differences may be determined.")
      )
    ),
    tabBox(
      title = space_after("Were missing data imputed using appropriate statistical methods?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("In case missing data are present and the numbers/reasons are not balanced
          across groups, the use of appropriate statistical methods for imputation should
          be considered. Failure to address these imbalances could lead to a high risk of bias.")
      )
    )
  )
)


# Selective outcome reporting ---------------------------------------------

# "Was the study protocol available and published prior to the study results?",
# "Were results provided for all experiments described in the Methods section AND was the study free from explicitly unpublished results (e.g. data not shown)?",
# "Were methods described for all results presented in the Results section?",
# "Were outcomes defined in the initial protocol?",
# "Did all the outcomes in the protocol and in the final report match?",
# "Were deviations justified?",
# "Were the pre-specified outcomes equivalent to the reported main findings?",
# "Were all pre-specified outcomes conducted and reported as planned?",
# "Were deviations justified?"

selective_reporting <- tabItem(
  tabName = step_ids[[9]],
  h1("9. Selective outcome reporting"),
  "This item evaluates reporting bias in a study.",
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = ("Was the study protocol available and published prior to the study results?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("While registration of animal intervention protocols might not be standard practice 
          for all yet, this is becoming increasingly more important, and a critical element
          of bias assessments in preclinical studies.")
      )
    ),
    tabBox(
      title = "Were results reported for all experiments described in the Methods section and was 
      the study free of explicitly unpublished results (e.g., data not shown)?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If there is indication of explicitly unpublished results (e.g.'data not shown'),
          there is a significant risk of reporting bias. Even in the case of reporting results
          from all experiments described in the methods, the risk of reporting bias could remain
          unclear, given that it is difficult to judge the planned analysis without a
          preregistered protocol.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Were methods described for all results presented in the Results section?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    ),
    tabBox(
      title = "Were outcomes defined in the initial protocol?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = "Did all the outcomes in the protocol and in the final report match and were deviations justified?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("If no primary endpoint was defined in the protocol, a match between study reporting and all pre-specified 
          outcomes is expected. If this is not the case, and no explicit deviations were reported,
          a high risk of bias is present.")
      )
    ),
    tabBox(
      title = "Were all pre-specified outcomes conducted and reported as planned, and were deviations justified?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Even when the primary endpoint in the protocol matches the main finding of the final
          report, any deviations from the protocol should be clearly stated to avoid a high risk 
          of bias. Similarly, a high risk of bias is present if one or more of the outcomes reported 
          in the final study were not pre-specified. This is subject to evaluation if clear 
          justification may be provided (e.g. unexpected adverse effects).")
      )
    )
  )
)


# Other bias --------------------------------------------------------------

# "Was there a conflict of interest statement?",
# "Did the authors report a conflict of interest?",
# "Was it explicitly stated that measures were in place to avoid bias?"

funder_influence <- tabItem(
  tabName = step_ids[[10]],
  h1("10.1 Inappropriate influence of funders"),
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = tab_title("Was there a conflict of interest statement?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("This information can appear in the manuscript under various sections:"),
        p("- Conflict of interest"),
        p("- Competing interests"),
        p("- Disclosure")
      ),
      tabPanel(
        "Description",
        p("Inappropriate influence of funders is a possibility. If no information
          on the matter is available, the risk of bias status remains unclear.")
      )
    ),
    tabBox(
      title = tab_title("Did the authors report a conflict of interest?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("-",
          a(href = "https://pubmed.ncbi.nlm.nih.gov/34942319/", "Zhang et al. (2022)"),
          "'The authors declare that they have no known competing financial
          interests or personal relationships that could have appeared to influence
          the work reported in this paper.'"),
        p("-",
          a(href = "https://onlinelibrary.wiley.com/doi/10.1111/acel.13371", "Wu et al. (2021)"),
          "'Y.W.S., Y.Q.W., G.X.Z., and Z.J.Z. are share owners of Guangzhou Magpie Pharmaceuticals, LTD., Corp., 
          who holds the patent covering the compound MN-08. The other authors declare that no competing interests exist.'"),
        p("-",
          a(href = "https://pubmed.ncbi.nlm.nih.gov/24598771/", "Zhang et al. (2014)"),
          "'There are no conflicts of interest.'")
      ),
      tabPanel(
        "Description",
        p("Author-reported conflicts of interest could represent significant sources
          of bias in a study.")
      )
    )
  ),
  fluidRow(
    tabBox(
      title = tab_title("Was it explicitly stated that measures were in place to avoid bias?"),
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("It is possible that a conflict of interest is present, e.g., a pharmaceutical company 
        funds the a study investigating the effectiveness of one of their drugs on a specific condition.
        If it is explicitly stated that the funder was not involved in study design or any experimental procedures,
        this would not be considered an inappropriate influence, and thus, would indicate a low risk of bias.")
      )
    )
  )
)

# analysis_unit <- tabItem(
#   tabName = step_ids[[11]],
#   h1("10.2 Unit of analysis bias"),
#   lorem::ipsum(paragraph = 1),
#   br(),
#   br(),
#   br(),
#   fluidRow(
#     tabBox(
#       title = ("Were treatments given dissolved in either food or drinking water?"),
#       width = 6,
#       side = "right",
#       selected = "Description",
#       tabPanel(
#         "Examples",
#         lorem::ipsum(sentences = 2)
#       ),
#       tabPanel(
#         "Description",
#         p("")
#       )
#     ),
#     tabBox(
#       title = tab_title("Were animals housed individually?"),
#       width = 6,
#       side = "right",
#       selected = "Description",
#       tabPanel(
#         "Examples",
#         lorem::ipsum(sentences = 2)
#       ),
#       tabPanel(
#         "Description",
#         p("")
#       )
#     )
#   ),
#   fluidRow(
#     tabBox(
#       title = "Were cages (not individual animals) compared statistically as the unit of analysis?",
#       width = 6,
#       side = "right",
#       selected = "Description",
#       tabPanel(
#         "Examples",
#         lorem::ipsum(sentences = 2)
#       ),
#       tabPanel(
#         "Description",
#         p("Unit-of-analysis errors might be present in animal studies, which could lead to
#           inaccurate calculation of statistical measures. For example, if all mice in a cage
#           are given a treatment in their diet, the experimental unit is the cage and not the
#           individual animal.")
#       )
#     )
#   )
# )

# "Was it explicitly stated that animals were added to any cohort to replace missing ones?"

animal_addition <- tabItem(
  tabName = step_ids[[11]],
  h1("10.2 Addition of animals"),
  br(),
  br(),
  br(),
  fluidRow(
    tabBox(
      title = "Was it explicitly stated that animals were added to any cohort to replace missing ones?",
      width = 6,
      side = "right",
      selected = "Description",
      tabPanel(
        "Examples",
        p("")
      ),
      tabPanel(
        "Description",
        p("Addition of animals to the control or experimental groups to replace drop-outs from
          the original sample is indicative of high risk of bias.")
      )
    )
  )
) 

# Assessment tool ---------------------------------------------------------


tool <- tabItem(
  tabName = "tool",
  h2("Risk of bias assessment"),
  br(),
  shiny::fluidPage(
    column(
      width = 5,
      br(),
      br(),
      lapply(tool_steps, make_row),
      br(),
      br(),
      actionLink("startover", "Start over")
    ),
    column(
      width = 7,
      shinysurveys::surveyOutput(df, 
                                 theme = NULL),
      br(),
      shinyjs::hidden(
        downloadButton(
          "downloadResponses","Download responses"
          )
        )
      )
    )
  )


# Data visualization ------------------------------------------------------

plots <- tabItem(
  tabName = "plots",
  h1("Risk of bias plots"),
  br(),
  column(
    width = 4,
    box(
      width = 12,
      # title = "Upload data",
      selectInput(
        inputId = "dataformat",
        label = "Select data format",
        choices = list("app"),
        # choices = list("app","SyRF"),
        selected = character(0)
      ),
      fileInput(
        inputId = "uploadfile", 
        label = "Upload csv file",
        accept = c(".csv"),
        multiple = TRUE
      ),
      uiOutput(
          "datamessage"
          ),
      br(),
      selectInput(
        inputId = "showPlotType",
        label = "Select type of plot",
        choices = list("Traffic light plot", "Summary plot"),
        selected = character(0)
      ),
      checkboxInput(
        inputId = "showColorBlind",
        label = "Color blind friendly"
      ),
      actionButton(
        inputId = "generateplot",
        label = "Generate plot"
      ),
      br(),
      br(),
      dropdown(
        right = FALSE,
        animate = FALSE,
        selectInput(
          inputId = "savePlotType",
          label = "Select type of plot output",
          choices = c("Traffic light", "Summary"),
          multiple = FALSE,
          selected = "Traffic light",
          width = "auto"
        ),
        selectInput(
          inputId = "formatplot",
          label = "Select format of plot output",
          choices = list("png","pdf","tiff"),
          multiple = FALSE,
          selected = ".png",
          width = "auto"
        ),
        checkboxInput(
          inputId = "saveColorBlind",
          label = "Color blind friendly"
        ),
        br(),
        br(),
        downloadButton('downloadPlot','Save'),
        # icon = icon("file-alt"),
        up = FALSE,
        label = "Save plot",
        size = "default",
        inputId = "saveplot"
      ),
      br(),
      actionButton(
        inputId = "helpUpload",
        label = "Help",
        icon = icon("info-circle")
      )
    )
  ),
  column(
    width = 6,
    plotOutput("robplot")
    )
  )



# training feature --------------------------------------------------------

practice <- tabItem(
  tabName = "practice",
  h1(
    "Test your skills (coming soon)"
    )
  )


           
         
         