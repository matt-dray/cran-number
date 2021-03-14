# What's your Hadley Number?

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![](https://img.shields.io/badge/Shiny-shinyapps.io-blue?style=flat&labelColor=white&logo=RStudio&logoColor=blue)](mattdray.shinyapps.io/hadley-number/)
[![Blog post](https://img.shields.io/badge/rostrum.blog-post-008900?labelColor=000000&logo=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh%2BQQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/2019/02/27/hadley-number/)
<!-- badges: end -->

[A simple Shiny app](https://mattdray.shinyapps.io/hadley-number/) to demonstrate the [Six Degrees of Kevin Bacon](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon). But it's for CRAN packages. And [Hadley Wickham](http://hadley.nz/) is Kevin Bacon.

![Choose author from dropdown, flick 'Go', see the coauthor graph with Hadley Wickham](https://raw.githubusercontent.com/matt-dray/hadley-number/master/img/hadley-number.gif)

# What?

The app demonstrates a use of [the {kevinbacran} package](https://matt-dray.github.io/kevinbacran/) for examining the shortest coauthor-paths between any two individuals (or entities) from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/).

The app fixes one of those authors as [Hadley Wickham](http://hadley.nz/) given that he is named as author on a large number of packages on CRAN, particularly in [the tidyverse suite](https://www.tidyverse.org/)).

You can read more about the {kevinbacran} package, which underlies this app, in [the accompanying blog post](https://www.rostrum.blog/2019/02/27/hadley-number/).

# Access

The app is [live on shinyapps.io](: https://mattdray.shinyapps.io/hadley-number/) (so it's throttled at 25 hours of active use per month; I may also take it down at any time).

You can also install the app for local viewing. Run the following from an R session:

``` r
shiny::runGitHub("hadley-number", "matt-dray")
```

It depends on the packages {shiny}, {shinyhelper}, {magrittr} and {kevinbacran}. You can install {kevinbacran} with `remotes::install_github("matt-dray/kevinbacran")`.
