library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Exemplo da amostra"),
  hr(),
  numericInput(
    inputId = "tamanho_amostra",
    label = "Selecione o tamanho da amostra",
    value = 100,
    min = 1,
    max = 1000
  ),
  plotOutput(outputId = "grafico"),
  textOutput(outputId = "texto")
)

server <- function(input, output, session) {

  amostra <- reactive({
    sample(x = 1:10, size = input$tamanho_amostra, replace = TRUE)
  })

  output$grafico <- renderPlot({
    tibble::tibble(
      valores = amostra()
    ) |>
      ggplot() +
      geom_bar(aes(x = valores)) +
      theme_minimal() +
      scale_x_continuous(breaks = 1:10)

  })

  output$texto <- renderText({
    num_mais_sorteado <- tibble::tibble(
      valores = amostra()
    ) |>
      dplyr::count(valores, sort = TRUE) |>
      dplyr::slice(1) |>
      dplyr::pull(valores)

    glue::glue(
      "O número mais sorteado foi {num_mais_sorteado}."
    )
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
