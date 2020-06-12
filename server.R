
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(plyr)
theme_set(theme_bw())

shinyServer(function(input, output) {
  
  reac_data = reactive({
    #settings
    n = 1000
    num.breaks = input$bins
    paradox.scale = input$scale
    noise.factor = input$noise
    
    #generate some data
    set.seed(123)
    {x = rnorm(n)
    y = x + rnorm(n) * noise.factor}
    
    #dataframe
    d = data.frame(x, y)
    
    #cut into groups
    cut.vals = quantile(d$x, probs = seq(0, 1, length.out = num.breaks + 1))
    d = mutate(d, group = cut(x, breaks = cut.vals, include.lowest = T))
    levels(d$group) = LETTERS[1:num.breaks]
    
    #within groups
    d2 = ddply(d,
               "group",
               summarize,
               mean.x = mean(x),
               mean.y = mean(y),
               r = cor(x, y))
    #the values needed to flip the positions on the y-axis
    flip.vals = d2$mean.y * - paradox.scale
    
    #add constants to each level to create the 'paradox'
    for (row in 1:nrow(d)) {
      i = which(d[row, "group"] == LETTERS) #which number in alfabet?
      d[row, "y"] = d[row, "y"] + flip.vals[i] #add val
    }
    
    return(d)
  })

  output$plot <- renderPlot({
    d = reac_data()
    
    #plot
    ggplot(d, aes(x, y)) +
      geom_point(aes(color = group)) +
      geom_smooth(method = "lm", se = F, color = "black", linetype = "dashed") +
      geom_smooth(aes(group = group, color = group), method = "lm", se = F, linetype = "dashed", fullrange = T) +
      xlab("X") + ylab("Y")
    
  })

})
