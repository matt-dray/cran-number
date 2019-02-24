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
cran_tidy <- readRDS("www/cran_tidy.RDS")
cran_graph <- readRDS("www/cran_graph.RDS")


# UI ----------------------------------------------------------------------


# Use a fluid Bootstrap layout
ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("{kevinbacran} demo: what's your 'Hadley Number'?"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      helpText("UNDER DEVELOPMENT"),
      hr(),
      helpText("Type a CRAN author's name, select them and hit 'Go'"),
      selectInput(
        inputId = "authorA",
        label = "Author:", 
        choices = unique(cran_tidy$author),
        multiple = FALSE,
        selected = "Joanna Zhao"),
      actionButton("go", "Go"),
      hr(),
      helpText("Source: Comprehensive R Archive Network (CRAN)")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      textOutput("cranDistance"),
      plotOutput("cranPlot")  
    )
    
  )
)


# SERVER ------------------------------------------------------------------


# Define a server for the Shiny app
server <- function(input, output, session) {
  
  author_select <- eventReactive(input$go, {
    
    input$authorA
    
  })
  
  
  output$cranDistance <- renderText({
    
    pairs <- kb_pair(cran_graph, name_a = author_select())
    
    distance <- kb_distance(pairs)
    
    return(distance)
    
  })
  
  # Fill in the spot we created for a plot
  output$cranPlot <- renderPlot({
    
    pairs <- kb_pair(cran_graph, name_a = author_select())
    
    plot <- kb_plot(pair_graph = pairs)
    
    return(plot)
    
  })
  
}


# RUN APP -----------------------------------------------------------------


# Run the application 
shinyApp(ui = ui, server = server)

