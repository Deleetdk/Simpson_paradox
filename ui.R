
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of subgroups:",
                  min = 1,
                  max = 10,
                  value = 5),
      sliderInput("scale",
                  "The paradox scale:",
                  min = -5,
                  max = 10,
                  value = 2),
      sliderInput("noise",
                  "Noise factor:",
                  min = 0,
                  max = 10,
                  value = .1,
                  step = .1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
))
