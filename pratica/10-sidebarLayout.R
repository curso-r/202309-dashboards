library(shiny)

ui <- fluidPage(
  titlePanel("Exemplo usando linhas e colunas do boostrap"),
  hr(),
  sidebarLayout(
    # position = "right",
    sidebarPanel = sidebarPanel(
      width = 3,
      titlePanel("Filtros da aplicação"),
      selectInput(
        inputId = "variavel_x",
        label = "Selecione a variável do eixo X",
        choices = names(mtcars),
        width = "100%"
      ),
      selectInput(
        inputId = "variavel_x2",
        label = "Selecione a variável do eixo X",
        choices = names(mtcars),
        width = "100%"
      )
    ),
    mainPanel = mainPanel(
      width = 9,
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
