# {kevinbacran} test: what's your Hadley Number?

This app is in development.

## TL;DR

An app to demonstrate the [Six Degrees of Kevin Bacon](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon). But it's for CRAN packages. And [Hadley Wickham](http://hadley.nz/) is Kevin Bacon.

## What?

This is a Shiny app to demonstrate [the tiny {kevinbacran} package](https://matt-dray.github.io/kevinbacran/) for examining the shortest paths between any two authors from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/).

The app fixes one of those authors as [Hadley Wickham](http://hadley.nz/) given that he is named as author on a number of packages (particularly in [the tidyverse suite](https://www.tidyverse.org/)) and due to his high visibility in the R community.

## Where?

The app is live at https://mattdray.shinyapps.io/hadley-number/

This is hosted for free with [shinyapps.io](http://www.shinyapps.io/), so will stop working when a certain threshold for hours of use has been met.

## Kudos

The package relies heavily on others, particularly [{cranly}](https://github.com/ikosmidis/cranly) from [Ioannis Kosmidis](http://ikosmidis.com/), [{tidygraph}](https://github.com/thomasp85/tidygraph) and [{ggraph}](https://github.com/thomasp85/ggraph) from [Thomas Lin Pedersen](https://www.data-imaginist.com/), and [{dplyr}](https://dplyr.tidyverse.org/) and [{purrr}](https://purrr.tidyverse.org/) from [Hadley Wickham](http://hadley.nz/), [Lionel Henry](https://twitter.com/_lionelhenry?lang=en), [Romain François](https://twitter.com/romain_francois) and [Kirill Müller](https://twitter.com/krlmlr?lang=en). The code for getting author combinations per package is from [William Chase](https://www.williamrchase.com/), in his excellent blogpost ['Finding Combinations in the Tidyverse'](https://www.williamrchase.com/post/finding-combinations-in-the-tidyverse/).
