# {kevinbacran} test: what's your Hadley Number?
# Shiny app
# Matt Dray
# Feb 2019

# A Shiny app. You select an author from the CRAN database and are presented
# with the separation (in graph theory terms) between them and Hadley Wickham.
# Akin to the 'Six Degrees of Separation'.

# Read more:
# * App URL: https://mattdray.shinyapps.io/hadley-number/ (subject to removal)
# * Blog post: https://www.rostrum.blog/2019/02/27/hadley-number/
# * {kevinbacran} pkgdown site: https://matt-dray.github.io/kevinbacran/

# GLOBAL ------------------------------------------------------------------


# Packages
library(shiny)
library(kevinbacran)  # CRAN author database manipulation
library(shinyhelper)  # for clickable '?' button to expose more info 
library(magrittr)  # %>%

# Read tibble object saved from graph_author_lookup.R
# One row per author. Columns for (1) author name, (2) a tbl_graph object
# of the shortest-path graph from that author to HW, and (3) the
# separation value. The Shiny app then simply selects the appropriate
# author-to-HW tidygraph to display given an input.
hw_graphs <- readRDS("www/hw_graphs_no_error.RDS")


# UI ----------------------------------------------------------------------


# Use a fluid Bootstrap layout
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("{kevinbacran} demo: what's your Hadley Number?"),
  br(),
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      
      selectInput(
        inputId = "authorA",
        label = "Type CRAN author name and hit Go",
        choices = unique(hw_graphs$author_name),
        multiple = FALSE,
        selected = "Aaron Christ"
      ) %>% 
        
        helper(
          type = "inline",
          title = "Notes on the app",
          content = c(
            "The data in the app reflect a snapshot of CRAN from 26 February
            2018.<br>",
            "Authors are excluded where {tidygraph} could not assess the
            shortest path.<br>",
            "{kevinbacran} depends on {cranly}, {dplyr}, {ggplot2}, {ggraph},
            {purrr}, {tidygraph} and {tidyr}.<br>",
            "See <a href='https://matt-dray.github.io/kevinbacran/'>the
            {kevinbacran} documentation</a> for full citations.<br>",
            "The app was built with
            <a href='https://CRAN.R-project.org/package=shiny'>{shiny}</a> and
            <a href='https://CRAN.R-project.org/package=shinyhelper'>{shinyhelper}</a>"
          ),
          size = "s"
        ),
      
      actionButton("go", "Go"),
      
      hr(),
      
      p(),
      HTML("The <a href='https://matt-dray.github.io/kevinbacran/'>{kevinbacran} 
           package</a> helps calculate the separation of any two authors on the
           <a href='https://cran.r-project.org/'>CRAN</a>-package 
           <a href='https://en.wikipedia.org/wiki/Graph_theory'>network graph</a>."),
      p(),
      HTML("It's like <a href='https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon'>
           the Six Degrees of Kevin Bacon</a>. Except it's for CRAN authors.
           And in this example, <a href='http://hadley.nz/'>Hadley Wickham</a>
           is Kevin Bacon."),
      p(),
      HTML("Why not:
           <ul>
           <li>toot me <a href='https://www.twitter.com/mattdray/'>@mattdray</a></li>
           <li>read about <a href='https://rostrum.blog/2019/02/27/hadley-number/'>the package/app</a></li>
           <li>read about <a href='https://nacnudus.github.io/duncangarmonsway/posts/2019-02-27-with-added-bacran/'>analysis of the network</a></li>
           <li>try <a href='https://matt-dray.github.io/kevinbacran/'>{kevinbacran}</a></li>
           <li>get the app source on <a href='https://github.com/matt-dray/hadley-number/'>GitHub</a></li>
           </ul>"),
      
      hr(),
      
      HTML("<center><img src='https://raw.githubusercontent.com/matt-dray/stickers/master/output/kevinbacran_hex.png' width='100'></center>")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      h4(textOutput("cranDistance")),
      plotOutput("cranPlot")  
    )
    
  )  # end sidebarLayout()
)  # end fluidPage


# SERVER ------------------------------------------------------------------


server <- function(input, output, session) {
  
  observe_helpers()
  
  author_select <- eventReactive(input$go, {
    
    input$authorA
    
  })
  
  # Separation value of selected author and target
  output$cranDistance <- renderText({
    
    aut_name <- author_select()
    separation <- hw_graphs$hadley_separation[hw_graphs$author_name == aut_name]
    
    return(paste0("Hadley Number for ", aut_name, ": ", separation))
    
  })
  
  # Plot of shortest path
  output$cranPlot <- renderPlot({
    
    aut_name <- author_select()
    graph <- hw_graphs$hadley_graph[hw_graphs$author_name == aut_name][[1]]
    
    plot <- kb_plot(pair_graph = graph) 
    
    return(plot)
    
  })
  
}


# RUN APP -----------------------------------------------------------------


# Run the application 
shinyApp(ui = ui, server = server)

