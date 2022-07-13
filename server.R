shiny::shinyServer(function(input, output, session) {
  output$plot_taxa <- renderPlot({
    if (input$obitos_recuperados == "Recuperados") {
      gg <- ggplot(data = covid_parana) +
        aes(fill = `Taxa de Recuperados\n por Casos`, geometry = {
          get(input$cidades_ou_micro)
        }) +
        geom_sf(color = NA, size = .15) +
        scale_fill_distiller(palette = "YlGn", direction = 1) +
        labs(title = "Taxa de Recuperados por Casos de Covid-19\n
        por município no estado do Paraná até o dia 11 de Dezembro de 2021.") +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 15)
        )
    } else {
      gg <- ggplot(data = covid_parana) +
        aes(fill = `Taxa de Óbitos\n por Casos`, geometry = {
          get(input$cidades_ou_micro)
        }) +
        geom_sf(color = NA, size = .15) +
        scale_fill_distiller(palette = "Reds", direction = 1) +
        labs(title = "Taxa de Óbitos por Casos de Covid-19\n
        por município no estado do Paraná até o dia 11 de Dezembro de 2021.") +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 15)
        )
    }
    return(gg)
  })
  output$plot_absoluto <- renderPlot({
    if (input$obitos_recuperados == "Recuperados") {
      gg <- ggplot(data = covid_parana) +
        aes(fill = Recuperados, geometry = {
          get(input$cidades_ou_micro)
        }) +
        geom_sf(color = NA, size = .15) +
        scale_fill_distiller(palette = "Greens", direction = 1) +
        labs(title = "Recuperados de Covid-19 em números absolutos por município\n
        no estado do Paraná até o dia 11 de Dezembro de 2021.") +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 15)
        )
    } else {
      gg <- ggplot(data = covid_parana) +
        aes(fill = `Óbitos`, geometry = {
          get(input$cidades_ou_micro)
        }) +
        geom_sf(color = NA, size = .15) +
        scale_fill_distiller(palette = "Reds", direction = 1) +
        labs(title = "Óbitos por Covid-19 em números absolutos por município\n
        no estado do Paraná até o dia 11 de Dezembro de 2021.") +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 15)
        )
    }
    return(gg)
  })
  output$plot_taxa_macro <- renderPlot({
    if (input$obitos_recuperados == "Recuperados") {
      gg <- ggplot(data = taxas) +
        aes(
          x = `Taxa de Recuperados\n por Casos por Macrorregião`,
          y = macro_recuperados_taxa,
          label = paste0(round(`Taxa de Recuperados\n por Casos por Macrorregião` * 100, 2), "%")
        ) +
        geom_col(fill = "#0ba325") +
        geom_text(hjust = -0.5) +
        scale_x_continuous(expand = expansion(mult = c(0, 0.4))) +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.title = element_text(size = 15)
        ) +
        labs(
          x = "Taxa de Recuperados por Casos",
          y = "Macrorregiões"
        )
    } else {
      gg <- ggplot(data = taxas) +
        aes(
          x = `Taxa de Óbitos\n por Casos por Macrorregião`,
          y = macro_obitos_taxa,
          label = paste0(round(`Taxa de Óbitos\n por Casos por Macrorregião` * 100, 2), "%")
        ) +
        geom_col(fill = "#bd3939") +
        geom_text(hjust = -0.5) +
        scale_x_continuous(expand = expansion(mult = c(0, 0.4))) +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.title = element_text(size = 15)
        ) +
        labs(
          x = "Taxa de Óbitos por Casos",
          y = "Macrorregiões"
        )
    }
    return(gg)
  })
  output$plot_absoluto_macro <- renderPlot({
    if (input$obitos_recuperados == "Recuperados") {
      gg <- ggplot(data = taxas) +
        aes(
          x = `Número absoluto de Recuperados por Macrorregião`,
          y = macro_obitos_abs,
          label = `Número absoluto de Recuperados por Macrorregião`
        ) +
        geom_col(fill = "#0ba325") +
        geom_text(hjust = -0.5) +
        scale_x_continuous(expand = expansion(mult = c(0, 0.4))) +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.title = element_text(size = 15)
        ) +
        labs(
          x = "Número absoluto de Recuperados",
          y = "Macrorregiões"
        )
    } else {
      gg <- ggplot(data = taxas) +
        aes(
          x = `Número absoluto de Óbitos por Macrorregião`,
          y = macro_recuperados_abs,
          label = `Número absoluto de Óbitos por Macrorregião`
        ) +
        geom_col(fill = "#bd3939") +
        geom_text(hjust = -0.5) +
        scale_x_continuous(expand = expansion(mult = c(0, 0.4))) +
        theme_minimal() +
        theme(
          panel.grid = element_blank(),
          axis.title = element_text(size = 15)
        ) +
        labs(
          x = "Número absoluto de Óbitos",
          y = "Macrorregiões"
        )
    }
    return(gg)
  })
})
