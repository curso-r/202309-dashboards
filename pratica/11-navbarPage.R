library(shiny)

ui <- navbarPage(
  title = "Exemplo navbarPage",
  tabPanel(
    title = "Página 1",
    selectInput(
      inputId = "var1",
      label = "Selecione a variável",
      choices = names(mtcars)
    ),
    plotOutput("grafico1")
  ),
  tabPanel(
    title = "Página 2",
    fluidRow(
      column(
        width = 4,
        selectInput(
          inputId = "var2",
          label = "Selecione a variável",
          choices = names(mtcars)
        )
      ),
      column(
        width = 8,
        plotOutput("grafico2")
      )
    )
  ),
  tabPanel(
    title = "Página 3",
    sidebarLayout(
      # position = "right",
      sidebarPanel = sidebarPanel(
        width = 3,
        titlePanel("Filtros da aplicação"),
        selectInput(
          inputId = "var3",
          label = "Selecione a variável do eixo X",
          choices = names(mtcars),
          width = "100%"
        )
      ),
      mainPanel = mainPanel(
        width = 9,
        plotOutput("grafico3")
      )
    )
  )
)

server <- function(input, output, session) {

  output$grafico1 <- renderPlot({
    plot(mtcars[[input$var1]], mtcars$mpg)
  })

  output$grafico2 <- renderPlot({
    plot(mtcars[[input$var2]], mtcars$mpg)
  })

  output$grafico3 <- renderPlot({
    plot(mtcars[[input$var3]], mtcars$mpg)
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
