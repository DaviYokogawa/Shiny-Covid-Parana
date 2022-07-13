setwd("visualizacao-de-dados/")

library(tidyverse)
library(geobr)

covid_parana <- read_csv2("../informe_epidemiologico_11_12_2021_obitos_casos_municipio.csv") %>%
  select(-c("RS", "MACRO"))
regioes <- openxlsx::read.xlsx("data/macromesomicropr.xlsx", sheet = 1)

covid_parana <- covid_parana %>%
  rename(
    `Óbitos` = Obitos,
    `Em Investigação` = Em_investigacao
  ) %>%
  left_join(regioes %>% select(-municipio), by = c("IBGE" = "code_muni"))

municipios <- read_municipality(code_muni = "PR", year = 2010)
micro <- read_micro_region(code_micro = "PR", year = 2010)
meso <- read_meso_region(code_meso = "PR", year = 2010) %>%
  rename(meso = name_meso)


meso <- meso %>%
  mutate(meso = case_when(
    meso == "Sudoeste Paranaense" ~ "Sudoeste",
    meso == "Sudeste Paranaense" ~ "Sudeste",
    meso == "Oeste Paranaense" ~ "Oeste",
    meso == "Norte Pioneiro Paranaense" ~ "Norte Pioneiro",
    meso == "Norte Central Paranaense" ~ "Norte Central",
    meso == "Noroeste Paranaense" ~ "Noroeste",
    meso == "Centro Oriental Paranaense" ~ "Centro-Oriental",
    meso == "Centro Ocidental Paranaense" ~ "Centro-Ocidental",
    meso == "Centro-Sul Paranaense" ~ "Centro-Sul",
    TRUE ~ meso
  ))

covid_parana <- covid_parana %>%
  mutate(
    `Taxa de Óbitos\n por Casos` = Óbitos / Casos,
    `Taxa de Recuperados\n por Casos` = Recuperados / Casos
  ) %>%
  left_join(municipios %>%
    select(code_muni, geom_municipio = geom), by = c("IBGE" = "code_muni")) %>%
  left_join(micro %>% select(name_micro, geom_micro = geom),
    by = c("micro" = "name_micro")
  ) %>%
  left_join(meso %>% select(meso, geom_meso = geom))

covid_parana <- covid_parana %>%
  mutate(
    Municipio = fct_reorder(factor(Municipio), Casos),
    micro = fct_reorder(factor(micro), Casos),
    meso = fct_reorder(factor(meso), Casos)
  )

saveRDS(covid_parana, "shiny/data/covid-parana.rds")
