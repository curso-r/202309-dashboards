library(shiny)
library(ggplot2)

# dados |>
#   dplyr::select(estupro:vit_latrocinio) |>
#   names() |>
#   dput()

ocorrencias <- c(
  "Estupro" = "estupro",
  "estupro_total",
  "estupro_vulneravel",
  "furto_outros",
  "furto_veiculos",
  "hom_culposo_acidente_transito",
  "hom_culposo_outros",
  "hom_doloso",
  "hom_doloso_acidente_transito",
  "hom_tentativa",
  "latrocinio",
  "lesao_corp_culposa_acidente_transito",
  "lesao_corp_culposa_outras",
  "lesao_corp_dolosa",
  "lesao_corp_seg_morte",
  "roubo_banco",
  "roubo_carga",
  "roubo_outros",
  "roubo_total",
  "roubo_veiculo",
  "vit_hom_doloso",
  "vit_hom_doloso_acidente_transito",
  "vit_latrocinio"
)

ui <- fluidPage(
  titlePanel("Dados de criminalidade da SSP"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "ocorrencia",
        label = "Selecione uma ocorrência",
        choices = ocorrencias
      ),
      shinyWidgets::pickerInput(
        inputId = "regiao",
        label = "Selecione uma ou mais regiões",
        choices = c("Carregando..." = ""),
        selected = "",
        multiple = TRUE,
        options = shinyWidgets::pickerOptions(
          actionsBox = TRUE,
          selectAllText = "Selecionar tudo",
          deselectAllText = "Limpar seleção"
        )
      ),
      shinyWidgets::pickerInput(
        inputId = "municipio",
        label = "Selecione uma ou mais municípios",
        multiple = TRUE,
        choices = c("Carregando..." = ""),
        selected = "",
        options = shinyWidgets::pickerOptions(
          actionsBox = TRUE,
          selectAllText = "Selecionar tudo",
          deselectAllText = "Limpar seleção"
        )
      )
    ),
    mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output, session) {

  dados <- readRDS(here::here("dados/ssp.rds")) |>
    dplyr::mutate(
      data = lubridate::make_date(
        year = ano,
        month = mes,
        day = 1
      )
    )

  regioes <- dados |>
    dplyr::pull(regiao_nome) |>
    unique() |>
    sort()

  shinyWidgets::updatePickerInput(
    session = session,
    inputId = "regiao",
    choices = regioes,
    selected = regioes
  )

  observe({
    municipios <- dados |>
      dplyr::filter(regiao_nome %in% input$regiao) |>
      dplyr::pull(municipio_nome) |>
      unique() |>
      sort()
    shinyWidgets::updatePickerInput(
      session = session,
      inputId = "municipio",
      choices = municipios,
      selected = municipios
    )
  })

  output$grafico <- renderPlot({

    validate(need(
      isTruthy(input$municipio),
      message = "Selecione ao menos um município para gerar o gráfico."
    ))

    dados |>
      dplyr::filter(
        municipio_nome %in% input$municipio
      ) |>
      dplyr::group_by(data) |>
      dplyr::summarise(
        media = mean(.data[[input$ocorrencia]], na.rm = TRUE)
      ) |>
      ggplot(aes(x = data, y = media)) +
      geom_line()
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))


