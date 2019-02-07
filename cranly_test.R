# https://github.com/ikosmidis/cranly

# devtools::install_github("ikosmidis/cranly")
library(cranly)

p_db <- tools::CRAN_package_db()
package_db <- clean_CRAN_db(p_db)

attr(package_db, "timestamp")

package_network <- build_network(package_db)

set_author <- "Duncan Garmonsway"

my_packages <- package_by(package_network, set_author)

plot(package_network, package = my_packages[c(2, 3)], title = TRUE, legend = TRUE)

author_network <- build_network(package_db, perspective = "author")

plot(author_network, author = set_author)

PL_dependence_tree <- build_dependence_tree(package_network, my_packages[3])
plot(PL_dependence_tree)
