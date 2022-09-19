# Install Shiny library
library(shiny)
library(ggplot2)
dataset <-iris
head(iris)
iris


# Define user interface object ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Shiny App"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    #Sidebar panel for inputs ----
    sidebarPanel(
      h2("Iris Data Set"),
      
      # Creating radio buttons ----
      radioButtons("p", "Select a column from the Iris data set:",
                   list("Sepal Length"='a', "Sepal Width"='b', "Petal Length"='c', "Petal Width"='d')),
      
      # Creating slide input for bins on the histogram ---
      sliderInput("bins", "Number of bins:", min = 1, max = 20, value = 10)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output histogram:
     plotOutput("distPlot"),
     
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  
  # Referencing output distPlot as output$distPlot
  output$distPlot <- renderPlot({
    
    # Referencing input p as input$p
    if(input$p == 'a'){i<-1}
    if(input$p == 'b'){i<-2}
    if(input$p == 'c'){i<-3}
    if(input$p == 'd'){i<-4}
    x <- iris[,i]
    
    # Referencing input bins as input$bins
    bins <- seq(min(x), max(x), length.out = input$bins +1)
    
    # Creating a histogram as output
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
}

# Call to the shinyApp function, run the app
shinyApp(ui = ui, server = server)