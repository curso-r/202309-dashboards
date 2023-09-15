library(shiny)

# Família de funções *Input()

ui <- fluidPage(
  selectInput(
    inputId = "letras",
    label = "Escolha uma letra",
    choices = c("A", "B", "C")
  ),
  selectInput(
    inputId = "col_mtcars",
    label = "Selecione uma variável",
    choices = names(mtcars)
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

