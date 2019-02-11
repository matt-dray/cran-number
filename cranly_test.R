# https://github.com/ikosmidis/cranly

# devtools::install_github("ikosmidis/cranly")
library(cranly)
library(dplyr)
library(tibble)
library(tidyr)
library(tools)
library(tidygraph)
library(purrr)
library(ggraph)


# Prepare data ------------------------------------------------------------


# Database

pkg_db <- CRAN_package_db() %>% 
  clean_CRAN_db() %>%
  as_tibble() 

# Row per package-author

pkg_aut <- pkg_db %>% 
  select(package, author) %>% 
  unnest()

# Top authors

pkg_aut %>% 
  count(author) %>% 
  arrange(desc(n)) %>% 
  top_n(10, n)

# Small sample to test with

pkg_aut_small <- pkg_aut %>%
  filter(package %in% c("dplyr", "readr", "purrr", "lme4"))

# Within each package, get author combos
# https://www.williamrchase.com/post/finding-combinations-in-the-tidyverse/
# How to reattach the package name?

pkg_aut_graph <- pkg_aut_small %>% 
  group_by(package) %>%
  filter(n() > 1) %>%
  split(.$package) %>%
  map(., 2) %>%
  map(~combn(.x, m = 2)) %>%
  map(~t(.x)) %>%
  map_dfr(as_tibble)

# Build tidygraph

pkg_aut_graph <- as_tbl_graph(pkg_aut_graph, directed = FALSE)


# Testing ggraph ----------------------------------------------------------


# Calculate centrality as 'popularity'

graph_pop <- pkg_aut_graph %>% 
  mutate(Popularity = centrality_degree(mode = 'in')) %>% 
  arrange(desc(Popularity))

# Call plot

ggraph(graph_pop, layout = "kk") + 
  geom_edge_link() + 
  geom_node_point(aes(size = Popularity))
