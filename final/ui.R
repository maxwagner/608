library(markdown)

# main nav
navbarPage(
  
  # a nice theme from "shinythemes"
  # https://rstudio.github.io/shinythemes/
  theme = "yeti.css",
  "Track and Field: Records and Doping",
  
  # tab 1
  tabPanel(
    "About",
    fluidRow(
      column(8, includeMarkdown("markdowns/about.md"))
    )
  ),
  
  # tab 2
  tabPanel(
    "Static Graphics",
    
    # row 1
    fluidRow(
      column(6, includeMarkdown("markdowns/static.md"))
    ),
    
    # row 2
    fluidRow(
      column(
        8,
        tags$h2("How Record Progression is Expected to Look"),
        tags$p(includeMarkdown("markdowns/s1.md")),
        plotOutput("s1"),
        tags$p(includeMarkdown("markdowns/hr.md")),
        
        tags$h2("A More Even Example"),
        tags$p(includeMarkdown("markdowns/s2.md")),
        plotOutput("s2"),
        tags$p(includeMarkdown("markdowns/hr.md")),
        
        tags$h2("Where Records Become Problematic"),
        tags$p(includeMarkdown("markdowns/s3.md")),
        plotOutput("s3"),
        tags$p(includeMarkdown("markdowns/hr.md")),
        tags$h2("Nationality Distribution"),
        tags$p(includeMarkdown("markdowns/s3_2.md")),
        tableOutput("s3tab")
      )
    )
  ),
  
  # tab 3
  tabPanel(
    "Interactive Graphics",
    
    # row 1
    fluidRow(
      column(6, includeMarkdown("markdowns/inter.md"))
    ),
    
    # row 2
    fluidRow(
      column(
        10,
        sidebarLayout(
          sidebarPanel(
            
            radioButtons(
              "plot2gender", "Sex", c("Male" = "male", "Female" = "female")
            ),
            
            selectInput("event", "Pick an Event:", c("100m","200m", "400m", 
                                                     "800m", "1500m","5000m", "10000m", 
                                                     "4x100m", "4x400m", 
                                                     "marathon", 
                                                     "100mh","110mh", "400mh", 
                                                     "long-jump", "high-jump", "triple-jump", 
                                                     "pole-vault", 
                                                     "javelin", "discus", "hammer","shot-put"))),
          mainPanel(
            plotOutput("plot2"),
            tags$p(includeMarkdown("markdowns/hr.md")),
            tags$h4("Nationality Distribution"),
            tableOutput("tablei1")
          )
        )
      )
    )
  )
)