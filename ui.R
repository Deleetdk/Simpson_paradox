
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Simpson's paradox"),

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
      HTML("<p>Simpson's paradox is when a relationship is reversed at a higher level of data aggregation compared with the lower level. It can happen <a HREF='https://en.wikipedia.org/wiki/Simpson%27s_paradox#Examples'>in real life</a> and <a HREF='http://journal.frontiersin.org/article/10.3389/fpsyg.2013.00513/abstract'>seems to be difficult for many people to understand, including students and researchers</a>.</p>",
           "<p>In the figure below you see five groups within each there is a positive relationship between X and Y as shown by the colored regression lines. However, you also see that if one aggregates the data the combined regression line (black) is negative.</p>",
           "<p>Try playing around with the sliders and observe the effects. When you are done, see also the visiualization of paradox found <a HREF='http://vudlab.com/simpsons/'>here</a>"),
      plotOutput("plot"),
      HTML("Made by <a href='http://emilkirkegaard.dk'>Emil O. W. Kirkegaard</a> using <a href='http://shiny.rstudio.com/'/>Shiny</a> for <a href='http://en.wikipedia.org/wiki/R_%28programming_language%29'>R</a>. Source code available <a href='https://github.com/Deleetdk/Simpson_paradox'>on Github</a>.")
    )
  )
))
