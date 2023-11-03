#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Load your dataset
data <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv")
tuesdata <- tidytuesdayR::tt_load('2020-01-28')

ui_bar_chart <- fluidPage(
  titlePanel("Bar Chart of Top Tree Species by Count"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotOutput("bar_chart")
    )
  )
)

server_bar_chart <- function(input, output) {
  output$bar_chart <- renderPlot({
    tree_species_count <- tuesdata$tree_species %>%
      count(Tree_Species, sort = TRUE) %>%
      head(10) # You can adjust the number of species to display
    
    ggplot(tree_species_count, aes(x = reorder(Tree_Species, n), y = n)) +
      geom_bar(stat = "identity", fill = "green") +
      labs(title = "Bar Chart of Top Tree Species by Count", x = "Tree Species", y = "Count") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

shinyApp(ui_bar_chart, server_bar_chart)
