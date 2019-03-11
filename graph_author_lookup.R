# Author lookup for use in Shiny app
# Matt Dray
# Feb 2019

# App URL: https://mattdray.shinyapps.io/hadley-number/ (subject to removal)
# Blog post: https://www.rostrum.blog/2019/02/27/hadley-number/

# Create a tibble with one row per author. Columns for (1) author name, (2) 
# a tbl_graph object of the shortest-path graph from that author to HW, and (3)
# the separation value. The Shiny app then simply selects the appropriate
# author-to-HW tidygraph to display given an input.

# Load packages
library(kevinbacran)
library(dplyr)
library(purrr)
library(cranly)
library(tidyr)

# Use example CRAN graph snapshot dataset that comes with {kecinbacran}
combo_graph <- kevinbacran::cran_graph

# Tibble with one row per package-author combo
pkg_auth <- tools::CRAN_package_db() %>%
  clean_CRAN_db() %>% 
  as_tibble() %>%
  select(package, author) %>%
  unnest()

# Just the author column, just distinct authors
auth <- pkg_auth %>%
  select(author) %>% 
  distinct(author) %>% 
  arrange(author) %>% 
  rename(author_name = author) 




# Test: shortest path listcol tibble and separation  ----------------------


# Get random sample of authors to work with
auth_test <- sample_n(auth, 10)

# To each row create a tidygraph object using the author name
# Uses the test set of authors only
listcol_tibble <- auth_test %>% 
  mutate(
    hadley_graph = map(
      author_name,
      ~kb_pair(tidy_graph = combo_graph, name_a = .x)
    ),
    hadley_separation = unlist(map(hadley_graph, ~kb_distance(.)))
  )

# Warnings:
# In shortest_paths(graph, from = from, to = to, mode = mode, weights = weights,  :
# At structural_properties.c:745 :Couldn't reach some vertices

# Expose an example tbl_graph
# Adjust index value for an author that has hadley_separation >0
listcol_tibble$hadley_graph[1]

# And extract the separation value
listcol_tibble$hadley_separation[1]


# Expand test to full author dataset --------------------------------------


# To each row create a tidygraph object using the author name
# Uses all authors in CRAN database
hw_graphs <- auth %>%
  mutate(
    hadley_graph = map(
      author_name,
      ~kb_pair(tidy_graph = combo_graph, name_a = .x)
    ),
    hadley_separation = unlist(map(hadley_graph, ~kb_distance(.)))
  ) 

# Remove empty graphs
# Those with zero distance were subject to warnings
hw_graphs_no_error <- hw_graphs %>% filter(hadley_separation > 0)

# Save these for later use
saveRDS(hw_graphs, "data/hw_graphs.RDS")
saveRDS(hw_graphs_no_error, "data/hw_graphs_no_error.RDS")  # used in Shiny app


# Test: plot --------------------------------------------------------------


# Test a basic plot
hw_graphs$hadley_graph[hw_graphs$author_name == "Duncan Gormansway"][[1]] %>%
  ggraph(layout = "nicely") +
  geom_edge_fan(
    aes(label = paste0("{", package, "}"), family = "sans"),
    edge_colour = "lightgrey",
    angle_calc = "none",
    #label_dodge = unit(2.5, "mm"),
    label_colour = "lightgrey"
  ) +
  geom_node_point() +
  geom_node_text(aes(label = name), repel = TRUE, family = "sans") +
  theme_graph()
