library(shiny)

fluidPage(
  
  titlePanel("Mortality Rate by Cause and State"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("chapter", "Cause of Mortality:",
                  c("Certain infectious and parasitic diseases",
                    "Neoplasms",
                    "Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism",
                    "Endocrine, nutritional and metabolic diseases",
                    "Mental and behavioural disorders",
                    "Diseases of the nervous system",
                    "Diseases of the circulatory system",
                    "Diseases of the respiratory system",
                    "Diseases of the digestive system",
                    "Diseases of the skin and subcutaneous tissue",
                    "Diseases of the musculoskeletal system and connective tissue",
                    "Diseases of the genitourinary system",
                    "Pregnancy, childbirth and the puerperium",
                    "Certain conditions originating in the perinatal period",
                    "Congenital malformations, deformations and chromosomal abnormalities",
                    "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified",
                    "External causes of morbidity and mortality"))
    ),
    mainPanel(
      htmlOutput("gvisplot")
    )
  )
)