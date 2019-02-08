# https://github.com/ikosmidis/cranly

# devtools::install_github("ikosmidis/cranly")
library(cranly)
library(dplyr)
library(tibble)
library(tidyr)
library(tools)

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
