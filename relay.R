library(dplyr)
library(rvest)
library(stringr)


# Harvest data ------------------------------------------------------------


relay_wiki <- read_html("https://en.wikipedia.org/wiki/Relay_FM")

current <- relay_wiki %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
  html_table() %>%
  filter(
    !Podcast %in% c(
      "Members Only",
      'Paid "Members Only" Shows',
      "B-Sides"
    )
  ) %>%
  mutate(Status = "Current")

retired <- relay_wiki %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>%
  html_table() %>%
  select(-`Number of episodes`) %>%
  mutate(Status = "Retired")

shows <- bind_rows(current, retired)


# Extract Hosts -----------------------------------------------------------


shows %>% slice(2) %>% pull(Hosts) %>% str_split("(?<=[a-z])(?=[A-Z])")
