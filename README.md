# {kevinbacran} test: what's your Hadley Number?

This app is in development. In particular, the speed, graphics, error reporting and presentation need updating.

## TL;DR

An app to demonstrate the [Six Degrees of Kevin Bacon](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon). But it's for CRAN authors. And [Hadley Wickham](http://hadley.nz/) is Kevin Bacon.

## What?

This is a Shiny app to demonstrate [the tiny {kevinbacran} package](https://matt-dray.github.io/kevinbacran/) for examining the shortest paths between any two authors from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/).

The app fixes one of those authors as [Hadley Wickham](http://hadley.nz/) given that he is named as author on a number of packages (particularly in [the tidyverse suite](https://www.tidyverse.org/)) and due to his high visibility in the R community.

## Where?

The app is live at https://mattdray.shinyapps.io/hadley-number/

This is hosted for free with [shinyapps.io](http://www.shinyapps.io/), so will stop working when a certain threshold for hours of use has been met.

## Kudos

The app and the functions in it rely on the packages [{shiny}](https://shiny.rstudio.com/), [{cranly}](https://github.com/ikosmidis/cranly), [{tidygraph}](https://github.com/thomasp85/tidygraph), [{ggraph}](https://github.com/thomasp85/ggraph), [{dplyr}](https://dplyr.tidyverse.org/) and [{purrr}](https://purrr.tidyverse.org/).