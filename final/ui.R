library(markdown)

navbarPage(
  theme = "yeti.css",
  "Track and Field Records Over Time",
  tabPanel(
    "About",
    fluidRow(
      column(6, includeMarkdown("about.md"))
    )
  ),
  tabPanel(
    "Static Information",
    fluidRow(
      column(6, includeMarkdown("about.md"))
    )
  ),
  tabPanel(
    "Interactive Information",
    fluidRow(
      column(6, includeMarkdown("about.md"))
    ),
    sidebarLayout(
      sidebarPanel(
        
        radioButtons(
          "plot2gender", "Gender", c("Male" = "male", "Female" = "female")
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
        plotOutput("plot2")
      )
    )
  )
)