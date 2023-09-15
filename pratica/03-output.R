library(shiny)
library(ggplot2)

# Família output*()
# Família render*()

ui <- fluidPage(
  plotOutput(outputId = "grafico1"),
  plotOutput(outputId = "grafico2")
)

server <- function(input, output, session) {

  output$grafico1 <- renderPlot({
    plot(1:10)
  })

  output$grafico2 <- renderPlot({
    mtcars |>
      ggplot(aes(x = wt, y = mpg)) +
      geom_point()
  })

}

shinyApp(ui, server)
