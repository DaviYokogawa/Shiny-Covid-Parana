library(tidyverse)
library(shiny)
library(shinyWidgets)
library(bs4Dash)
library(sf)
library(geobr)

covid_parana <- readRDS("data/covid-parana.rds")

taxas <- covid_parana %>%
  group_by(macro) %>%
  summarise(
    `Taxa de Óbitos\n por Casos por Macrorregião` =
      mean(`Taxa de Óbitos\n por Casos`),
    `Taxa de Recuperados\n por Casos por Macrorregião` =
      mean(`Taxa de Recuperados\n por Casos`),
    `Número absoluto de Óbitos por Macrorregião` =
      sum(Óbitos),
    `Número absoluto de Recuperados por Macrorregião` =
      sum(Recuperados)
  ) %>%
  mutate(
    macro_obitos_taxa = fct_reorder(
      factor(macro),
      `Taxa de Óbitos\n por Casos por Macrorregião`
    ),
    macro_recuperados_taxa = fct_reorder(
      factor(macro),
      `Taxa de Recuperados\n por Casos por Macrorregião`
    ),
    macro_obitos_abs = fct_reorder(
      factor(macro),
      `Número absoluto de Óbitos por Macrorregião`
    ),
    macro_recuperados_abs = fct_reorder(
      factor(macro),
      `Número absoluto de Recuperados por Macrorregião`
    )
  )
