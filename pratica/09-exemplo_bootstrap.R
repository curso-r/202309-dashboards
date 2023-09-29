library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Exemplo usando linhas e colunas do boostrap"),
  hr(),
  fluidRow(
    column(
      width = 2,
      selectInput(
        inputId = "variavel_x",
        label = "Selecione a variável do eixo X",
        choices = names(mtcars),
        width = "100%"
      )
    ),
    column(
      width = 8,
      offset = 2,
      plotOutput("grafico")
    )
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[[input$variavel_x]], y = mpg)) +
      geom_point()
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
