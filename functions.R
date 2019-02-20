# Functions to help calculate distance between CRAN authors
# Matt Dray
# Feb 2019

# Packages ----------------------------------------------------------------


library(dplyr)
library(purrr)
library(tidygraph)
library(ggraph)
library(tidyr)
library(tibble)  # necessary?
library(cranly)


# Functions ---------------------------------------------------------------


# To think about
# * Ensure to_shortest_path
# * Ensure active(nodes)
# * 'cn_' for 'Cran Number'?

# Argumentless function to get the CRAN combos in tbl_graph form
cn_combo <- function() {
  
  cat("\nFetching CRAN data and tibblifying...\n")
  
  # Get data and arrange into tibble
  # Tidy tibble of each pakage-author combination
  cran_tidy <- tools::CRAN_package_db() %>% 
    clean_CRAN_db() %>%
    as_tibble() %>% 
    select(package, author) %>% 
    unnest()
  
  cat("\nGetting combinations of authors per package...\n")
  
  # Get author combos per package
  # Tibble of V1 (node from) and V2 (node to) combinations per package
  cran_combos <- cran_tidy %>% 
    group_by(package) %>%
    filter(n() > 1) %>%  # ignore solo authors
    split(.$package) %>%
    map(., 2) %>%
    map(~combn(.x, m = 2)) %>%
    map(~t(.x)) %>%
    map(as_tibble) %>%
    bind_rows(.id = "package") %>% 
    select(V1, V2, package)
  
  cat("\nCreating tidy graph object from combinations...\n")
  
  # To tidygraph object
  cran_graph <- as_tbl_graph(cran_combos, directed = FALSE) %>% 
    mutate(number = row_number())
  
  cat("\nDone!\n")
  
  # Spit it out
  return(cran_graph)
  
}

# Get a simplified tbl_graph of two selected authors
# tidy_graph will be the output from cn_combo
# name_from and name_to will be quoted author names (as per cn_combo$name)
cn_pair <- function(tidy_graph, name_a, name_b) {
  
  node_from <- tidy_graph %>% 
    as_tibble() %>% 
    filter(name == name_a) %>% 
    pull(number)
  
  node_to <- tidy_graph %>% 
    as_tibble() %>% 
    filter(name == name_b) %>% 
    pull(number)
  
  # Limit the network to the authors specified in to_name and from_name 
  short_graph <- tidy_graph %>%
    convert(to_shortest_path, from = node_from, to = node_to)
  
  # Spit it out
  return(short_graph)
  
}

# A separate function that takes cn_pair and outputs a numeric distance value
# takes tbl_graph from cn_pair
cn_distance <- function(tidy_graph_pair) {
  
  # Get the number of connections between them
  distance <- tidy_graph_pair %>% 
    activate(edges) %>% 
    as_tibble() %>% 
    summarise(n()) %>%
    pull()
  
  # Spit it out
  return(distance)
  
}

# Opinionated plot for example's sake
cn_plot <- function(pair_graph) {
  
  plot <- pair_graph %>% 
  ggraph(layout = "nicely") +
    geom_edge_fan(
      aes(label = package),
      angle_calc = 'along',
      label_dodge = unit(2.5, 'mm')
    ) + 
    geom_node_point(aes(colour = name)) +
    theme_graph()
  
  return(plot)
  
}



# Try functions -----------------------------------------------------------


test1 <- cn_combo()

name_a <- test1 %>% as_tibble() %>% sample_n(1) %>% pull(name)
name_b <- test1 %>% as_tibble() %>% sample_n(1) %>% pull(name)

test2 <- cn_pair(test1, name_a, name_b)
print(test2)

test3 <- cn_distance(test2)
print(test3)

test4 <- cn_plot(test2)
print(test4)
