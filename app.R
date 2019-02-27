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
hw_graphs <-readRDS("www/hw_graphs_no_error.RDS")


# UI ----------------------------------------------------------------------


# Use a fluid Bootstrap layout
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("{kevinbacran} demo: what's your Hadley Number?"),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      helpText("UNDER DEVELOPMENT"),
      hr(),
      helpText("Type a CRAN author's name and hit Go"),
      selectInput(
        inputId = "authorA",
        label = "Author:", 
        choices = unique(hw_graphs$author_name),
        multiple = FALSE,
        selected = "Aaron Christ"),
      actionButton("go", "Go"),
      hr(),
      helpText("This is a demo of {kevinbacran}, a small package for obtaining a
               tidygraph of CRAN authors and calculating the separation between
               any two. It's based on the Six Degrees of Kevin Bacon and Erdos
               Numbers.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      textOutput("cranDistance"),
      plotOutput("cranPlot")  
    )
    
  )
)


# SERVER ------------------------------------------------------------------


server <- function(input, output, session) {
  
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

