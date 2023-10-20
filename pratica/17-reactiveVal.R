library(shiny)

dados <- mtcars[1:10, ]

ui <- fluidPage(
  titlePanel("Adicionando e removendo linhas"),
  sidebarLayout(
    sidebarPanel(
      h3("Remover uma linha"),
      numericInput(
        "linha_remover",
        label = "Escolha uma linha para remover",
        value = 1
      ),
      actionButton(
        "remover",
        label = "Remover linha"
      ),
      hr(),
      h3("Adicionar uma linha"),
      numericInput(
        "linha_adicionar",
        label = "Escolha uma linha para adicionar",
        value = 1
      ),
      actionButton(
        "adicionar",
        label = "Adicionar linha"
      )
    ),
    mainPanel(
      tableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {

  # tab <- eventReactive(input$remover, ignoreNULL = FALSE, {
  #   if(input$remover == 0) {
  #     dados
  #   } else {
  #     tab() |>
  #       dplyr::slice(-input$linha_remover)
  #   }
  # })

  tabela_atual <- reactiveVal(dados)

  observeEvent(input$remover, {

    nova_tabela <- tabela_atual() |>
      dplyr::slice(-input$linha_remover)

    tabela_atual(nova_tabela)

    # salvar_bd()

  })


  output$tabela <- renderTable(
    tabela_atual() |>
      tibble::rownames_to_column()
  )

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
