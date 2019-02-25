# The SHiny app reacts when a name is selected. It subsets the CRAN-wide 
# tidygraph to produce a graph of the shortest path between person A and B.
# This is slow.

# How big would a tibble be if it was one row per author, with a column for
# author name; a column containing a tidygraph object from them to HW; and a
# column with the distance? The Shiny app could then simply select the
# appropriate author-to-HW tidygraph to display. Like this:
#
# author | tidygraph | hadley_number

library(kevinbacran)
library(dplyr)
library(purrr)
library(cranly)
library(tidyr)

# Prepare combos tidygraph
combo_graph<- kb_combos()

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


# Small test set
auth_test <- filter(auth, author %in% c("Jenny Bryan", "Joanna Zhao", "Yihui Xie", "Joe Cheng")) %>% 
  mutate(biggraph = list(combo_graph))

# To each row create a tidygraph object using the author name
test <- auth_test %>% 
  mutate(minigraph = map2(biggraph, author_name, ~kb_pair(tidy_graph = .x, name_a = .y)))


# Full set ----------------------------------------------------------------

hw_graphs <- auth %>%
  mutate(
    cran_graph = list(combo_graph),
    minigraph = map2(cran_graph, author_name, ~kb_pair(tidy_graph = .x, name_a = .y))
  )
