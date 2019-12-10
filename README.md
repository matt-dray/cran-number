# {kevinbacran} test: what's your Hadley Number?

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Blog post](https://img.shields.io/badge/rostrum.blog-post-008900?labelColor=000000&logo=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh%2BQQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/2019/02/27/hadley-number/)
<!-- badges: end -->


The app is live here: https://mattdray.shinyapps.io/hadley-number/

![](https://raw.githubusercontent.com/matt-dray/hadley-number/master/img/hadley-number.gif)

# What?

A simple app to demonstrate the [Six Degrees of Kevin Bacon](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon). But it's for CRAN packages. And [Hadley Wickham](http://hadley.nz/) is Kevin Bacon.

The app demonstrates [the tiny {kevinbacran} package](https://matt-dray.github.io/kevinbacran/) for examining the shortest paths between any two authors from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/).

The app fixes one of those authors as [Hadley Wickham](http://hadley.nz/) given that he is named as author on a large number of packages on CRAN, particularly in [the tidyverse suite](https://www.tidyverse.org/)).

# Access

The app is live here: https://mattdray.shinyapps.io/hadley-number/ (hosted for free with [shinyapps.io](http://www.shinyapps.io/) and is throttled at 25 hours of use per month; I may also take it down at any time.)

You can read more about {kevinbacran} and this app in a blogpost: https://www.rostrum.blog/2019/02/27/hadley-number/

# Kudos

The app is built with [{shiny}](http://www.shinyapps.io/) and includes [{shinyhelper}](https://cran.r-project.org/package=shinyhelper ) from [Chris Mason-Thom](https://github.com/cwthom).

Citations for {kevinbacran} can be found in [its pkgdown site](https://matt-dray.github.io/kevinbacran/).
