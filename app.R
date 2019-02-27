#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# GLOBAL ------------------------------------------------------------------


library(shiny)
library(kevinbacran)
library(shinyhelper)
library(magrittr)
hw_graphs <-readRDS("www/hw_graphs_no_error.RDS")


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
        label = "Select a CRAN author and press Go",
        choices = unique(hw_graphs$author_name),
        multiple = FALSE,
        selected = "Aaron Christ") %>% 
        helper(
          type = "inline",
          title = "Note on data",
          content = c(
            "The data in the app reflect a snapshot of CRAN from 26 February 2018.<br>",
            "{kevinbacran} relies on some other packages for heavy lifting.<br>",
            "Data fetched via <code>CRAN_package_db()</code> from {tools}.<br>",
            "Data cleaning via <code>clean_CRAN_db()</code> from {cranly}.<br>",
            "Graphs created, manipulated and plotted via {tidygraph} and {ggraph}.<br>",
            "Authors are excluded where {tidygraph} could not assess the shortest path."
          ),
          size = "s"),
      actionButton("go", "Go"),
      hr(),
      HTML("It's like <a href='https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon'>
           the Six Degrees of Kevin Bacon</a>. Except it's for CRAN packages.
           And <a href='http://hadley.nz/'>Hadley Wickham</a> is Kevin Bacon."),
      p(),
      HTML("The {kevinbacran} package calculates the separation of any two
           authors on the CRAN package network graph. This app implements
           functions from the package to fetch networks of the shortest path from
           each author to Hadley Wickham."),
      p(),
      HTML("Why not:
           <ul>
           <li>toot me <a href='https://www.twitter.com/mattdray/'>@mattdray</a></li>
           <li>read more in this <a href='https://rostrum.blog2019/02/27/hadley-number/'>blogpost</a></li>
           <li>try <a href='https://www.matt-dray.github.io/kevinbacran/'>{kevinbacran}</a></li>
           <li>get the source on <a href='https://www.github.com/matt-dray/hadley-number/'>GitHub</a></li>
           </ul>")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      h4(textOutput("cranDistance")),
      plotOutput("cranPlot")  
    )
    
  )
)


# SERVER ------------------------------------------------------------------


server <- function(input, output, session) {
  
  observe_helpers()
  
  author_select <- eventReactive(input$go, {
    
    input$authorA
    
  })
  
  output$cranDistance <- renderText({
    
    aut_name <- author_select()
    separation <- hw_graphs$hadley_separation[hw_graphs$author_name == aut_name]
    
    return(paste0("Hadley Number for ", aut_name, ": ", separation))
    
  })
  
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

