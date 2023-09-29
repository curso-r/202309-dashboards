library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", href = "custom.css")
  ),
  tags$h1(
    "App com exemplos de HTML"
  ),
  tags$hr(class = "vermelho"),
  fluidRow(
    column(
      width = 4,
      includeMarkdown(
        here::here("pratica/md/descricao.md")
      )
    ),
    column(
      width = 4,
      includeMarkdown(
        here::here("pratica/md/descricao.md")
      )
    ),
    column(
      width = 4,
      includeMarkdown(
        here::here("pratica/md/descricao.md")
      )
    )
  ),
  tags$hr(id = "hr_verde"),
  tags$img(
    src = "logo.png",
    style = "width: 200px; display: block; margin: auto;"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
