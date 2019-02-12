# The Relayverse
# Matt Dray
# Feb 2019


# Packages ----------------------------------------------------------------


library(dplyr)
library(rvest)
library(stringr)
library(tidyr)
library(purrr)
library(tidygraph)
library(ggraph)
library(visNetwork)


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


shows_clean <- shows %>%
  mutate(
    Hosts = str_remove_all(Hosts, " \\(originally\\)"),
    Hosts = str_split(Hosts, "(?<=[a-z])(?=[A-Z])")
  ) %>% 
  unnest() %>% 
  select(Podcast, Hosts)


# To tidygraph ------------------------------------------------------------


relay_combos <- shows_clean %>% 
  group_by(Podcast) %>%
  filter(n() > 1) %>%
  split(.$Podcast) %>%
  map(., 2) %>%
  map(~combn(.x, m = 2)) %>%
  map(~t(.x)) %>%
  map(as_tibble) %>%
  bind_rows(.id = "Podcast") %>% 
  select(V1, V2, Podcast)

# Convert to tidygraph object

relay_graph <- as_tbl_graph(relay_combos, directed = FALSE)

# Add number of incoming edges as measure of number of shows

relay_pop_graph <- relay_graph %>% 
  mutate(Shows = centrality_degree(mode = 'in')) %>% 
  arrange(desc(Shows))

# Interactive viz ---------------------------------------------------------


# https://datastorm-open.github.io/visNetwork/

relay_combos_id <- mutate(relay_combos, id = row_number())

nodes <- shows_clean %>%
  distinct(Hosts) %>%
  mutate(id = as.character(row_number())) %>% 
  rename(label = Hosts) %>% 
  mutate(title = label)

edges <- left_join(relay_combos, nodes, by = c("V1" = "label")) %>% 
  left_join(nodes, by = c("V2" = "label")) %>% 
  mutate(title = Podcast) %>% 
  select(from = id.x, to = id.y, label = Podcast, title)

visNetwork(
  nodes,
  edges,
  main = "The Relayverse",
  height = "800px", width = "100%"
) %>% 
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)


# Graph viz ---------------------------------------------------------------


ggraph(relay_pop_graph, layout = "graphopt") + 
  geom_edge_fan(  # edges between same nodes are separated
    # aes(label = Podcast),
    # angle_calc = "along",
    # label_dodge = unit(2.5, 'mm')
  ) +
  # geom_node_text(aes(label = name), repel = TRUE) +
  geom_node_point(aes(size = Shows)) +
  theme_graph()


ggraph(relay_pop_graph, "linear", circular = TRUE) + 
  geom_edge_arc() +  # aes(colour = factor(Podcast))
  geom_node_point(aes(size = Shows)) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_graph()
