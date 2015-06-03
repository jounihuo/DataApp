#Load shiny and dataset
library(shiny)
data(LakeHuron)

#Create the UI, include bootstrap.css for theme
shinyUI(fluidPage(theme = "bootstrap.css",
  headerPanel("Water level visualization"),
  sidebarPanel(
    h3('Analysis options'),
    #Use documentation
    p('With these controls you can set the plotting parameters on the water level plot. Plot shows annual measurements, in feet, of Lake Huron 1875-1972. To toggle the plot featues, select mean or linear fit. To estimate water level in the past or in the future, set the desired year.'),
    #Create buttons and check boxes
    radioButtons("button","Water level in",
                       c("feet" = "0",
                         "meters" = "1")),
    checkboxGroupInput("lines","Add lines for",
                 c("Mean" = "0",
                   "Linear fit" = "1")),
    numericInput('year', 'What year would you like to estimate',1970,min=0,max=3000,step=1),
    strong("Linear estimate of the water level for the given year is:"),
    #Get the output from the server.R
    textOutput("linyear")
  ),
  mainPanel(
    #Conditional plotting base on the radio buttons.
    h3('Lake Huron water level'),
    conditionalPanel(
      condition = "input.button == '0'",
      plotOutput('levelPlotFeet')  # or whatever input/output you want
    ),
    conditionalPanel(
      condition = "input.button == '1'",
      plotOutput('levelPlotMeters')  # or whatever input/output you want
    )
    )
))