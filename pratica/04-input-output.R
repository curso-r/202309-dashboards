library(shiny)
library(ggplot2)

ui <- fluidPage(
  selectInput(
    inputId = "col_mtcars",
    label = "Selecione a variável do eixo X",
    choices = names(mtcars),
    selected = "wt"
  ),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[[input$col_mtcars]], y = mpg)) +
      geom_point()
  })

}

shinyApp(ui, server)
