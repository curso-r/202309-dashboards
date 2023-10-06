library(shiny)
library(bs4Dash)

ui <- dashboardPage(
  title = "SHINYDASHBOARD",
  skin = "purple",
  header = dashboardHeader(
    title = "shinydashboard"
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Página 1",
        tabName = "pag1",
        icon = icon("user-ninja")
      ),
      menuItem(
        text = "Página 2",
        tabName = "pag2"
      ),
      menuItem(
        text = "Página 3",
        menuSubItem(
          text = "Página 3.1",
          tabName = "pag3_1",
          icon = icon("hat-cowboy")
        ),
        menuSubItem(
          text = "Página 3.2",
          tabName = "pag3_2",
          icon = NULL
        )
      )
    )
  ),
  body = dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        href = "custom2.css"
      )
    ),
    "Qualquer coisa",
    tabItems(
      tabItem(
        tabName = "pag1",
        titlePanel("Página 1"),
        hr(
          style = "border-top: 1px solid black"
        ),
        fluidRow(
          column(
            width = 6,
            selectInput(
              inputId = "teste",
              label = "Selecione",
              choices = letters
            )
          ),
          column(
            width = 6,
            plotOutput("grafico")
          )
        )
      ),
      tabItem(
        tab = "pag2",
        titlePanel("Página 2"),
        hr(),
        "...",
        plotOutput("grafico2")
      )
    ),
    "Mais coisas"
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    plot(1:10)
  })

  output$grafico2 <- renderPlot({
    plot(1:10)
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
