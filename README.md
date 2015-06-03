# DataApp

This R code is a Shiny App that shows plotting and simple linear estimates on the Lake Huron water level dataset.  
App uses a bootstrap.css file from the www-folder for the theme of the app. The CSS-file can be downloaded from https://bootswatch.com/cerulean/. 

By cliking radio buttons you can set the units to feet or meters. 

By clicking the check boxes, you can show the mean and/or the linear fit on the plot.   
The running app can be used at: https://jhuopana.shinyapps.io/WaterLevelApp/


# ui.R
ui.R contains the user interface code for the app. Radio buttons and check boxes are defined for the sidepanel and the conditional plotting for the plot. Theme is retried from the bootstrap file in the www-folder.

# server.R
server.R provides the calculation based on the user input. Base on the user input a conditional structure provides the desired output for the ui.R. Simple linear fit is made for the data and that fit is used to estimate the water level in a given year.

## Note
This work has been done for the Developing Data Products course at Coursera and should not be consider anyting else than a example exercise.
