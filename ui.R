ui <- bootstrapPage(
 sidebarLayout(
    sidebarPanel(
      textInput('name', 'gene name', "T"),
  #    sliderInput("ylims",
   #               "y axis limits",
   #               min = input$min,
   #               max = input$max,
   #               value = c(input$min, input$max))
    ),

    mainPanel(
     plotOutput('plot')
))
)

