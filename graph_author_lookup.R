# The Shiny app reacts when a name is selected. It subsets the CRAN-wide 
# tidygraph to produce a graph of the shortest path between person A and B.
# This is relatively slow. Or is it?

# How big would a tibble be if it was one row per author, with a column for
# author name; a column containing a tidygraph object from them to HW; and a
# column with the distance? The Shiny app could then simply select the
# appropriate author-to-HW tidygraph to display. Like this:s
# author (char) | hadley_graph (tbl_graph) | hadley_number (num)

library(kevinbacran)
library(dplyr)
library(purrr)
library(cranly)
library(tidyr)

# Prepare combos tidygraph
combo_graph<- kevinbacran::cran_pkg_graph

# Tibble of package-author combos
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


# Test --------------------------------------------------------------------


# To each row create a tidygraph object using the author name
test <- auth_test %>% 
  mutate(
    hadley_graph = map(author_name, ~kb_pair(tidy_graph = combo_graph, name_a = .x)),
    hadley_separation = unlist(map(hadley_graph, ~kb_distance(.)))
  )

# Expose an example tbl_graph
test$hadley_separation[test$author_name == "Jenny Bryan"]


# Full set ----------------------------------------------------------------


# Get tibble of authors
# with listcol of tbl_graph to Hadley and column of separation values
hw_graphs <- auth %>%
  mutate(
    hadley_graph = map(author_name, ~kb_pair(tidy_graph = combo_graph, name_a = .x)),
    hadley_separation = unlist(map(hadley_graph, ~kb_distance(.)))
  ) 

# Remove empty graphs
hw_graphs_no_error <- hw_graphs %>% filter(hadley_separation > 0)

# Save these
saveRDS(hw_graphs, "data/hw_graphs.RDS")
saveRDS(hw_graphs_no_error, "data/hw_graphs_no_error.RDS")
