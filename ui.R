navbarPage(
  title = "Dashboard Covid-19 no Paraná",
  id = "navbar",
  position = "static-top",
  inverse = TRUE,
  tabPanel(
    title = "Visualizações",
    fluidRow(
      tags$style(".irs--square .irs-handle {
                          top: 27px;
                          width: 12px;
                          height: 12px;
                          border: 3px solid #4d4d4d;
                          background-color: white;
                          -webkit-transform: rotate(
                            45deg
                          );
                          -ms-transform: rotate(45deg);
                          transform: rotate(
                            45deg
                          );
                          }"),
      column(
        width = 2,
        bs4DashSidebar(
          shiny::selectizeInput(
            inputId = "cidades_ou_micro",
            label = "Selecione o tipo de região: ",
            choices = c(
              "Municípios" = "geom_municipio",
              "Microrregiões" = "geom_micro"
            ),
            options = list(maxItens = 1),
            width = "250px"
          ),
          shiny::selectizeInput(
            inputId = "obitos_recuperados",
            label = "Selecione o tipo de dados: ",
            choices = c("Recuperados", "Óbitos"),
            options = list(maxItens = 1),
            width = "250px"
          )
        )
      ),
      column(
        width = 10,
        bs4DashBody(
          column(width = 6, align = "center", box(fluidRow(
            shiny::plotOutput(outputId = "plot_taxa"),
            shiny::plotOutput(outputId = "plot_taxa_macro")
          ),
          solidHeader = TRUE,
          collapsible = FALSE,
          height = 800,
          width = 12,
          title = ""
          )),
          column(width = 6, align = "center", box(fluidRow(
            shiny::plotOutput(outputId = "plot_absoluto"),
            shiny::plotOutput(outputId = "plot_absoluto_macro")
          ),
          solidHeader = TRUE,
          collapsible = FALSE,
          height = 300,
          width = 12,
          title = ""
          ))
        )
      )
    ),
  )
)
