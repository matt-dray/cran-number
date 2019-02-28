# {kevinbacran} test: what's your Hadley Number?

## TL;DR (gif)

![](https://raw.githubusercontent.com/matt-dray/hadley-number/master/img/hadley-number.gif)

## TL;DR (words)

App: https://mattdray.shinyapps.io/hadley-number/
Blog: https://www.rostrum.blog/2019/02/27/hadley-number/

An app to demonstrate the [Six Degrees of Kevin Bacon](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon). But it's for CRAN packages. And [Hadley Wickham](http://hadley.nz/) is Kevin Bacon.

## What?

This is a simple Shiny app to demonstrate [the tiny {kevinbacran} package](https://matt-dray.github.io/kevinbacran/) for examining the shortest paths between any two authors from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/).

The app fixes one of those authors as [Hadley Wickham](http://hadley.nz/) given that he is named as author on a large number of packages on CRAN, particularly in [the tidyverse suite](https://www.tidyverse.org/)).

## Where?

The app is live at https://mattdray.shinyapps.io/hadley-number/

This is hosted for free with [shinyapps.io](http://www.shinyapps.io/), so will stop working when a certain threshold for hours of use has been met.

## Kudos

The app is built with [{shiny}](http://www.shinyapps.io/) and includes [{shinyhelper}](https://cran.r-project.org/package=shinyhelper ) from [Chris Mason-Thom](https://github.com/cwthom).

The package relies heavily on others, particularly [{cranly}](https://github.com/ikosmidis/cranly) from [Ioannis Kosmidis](http://ikosmidis.com/), [{tidygraph}](https://github.com/thomasp85/tidygraph) and [{ggraph}](https://github.com/thomasp85/ggraph) from [Thomas Lin Pedersen](https://www.data-imaginist.com/), and [{dplyr}](https://dplyr.tidyverse.org/) and [{purrr}](https://purrr.tidyverse.org/) from [Hadley Wickham](http://hadley.nz/), [Lionel Henry](https://twitter.com/_lionelhenry?lang=en), [Romain François](https://twitter.com/romain_francois) and [Kirill Müller](https://twitter.com/krlmlr?lang=en).