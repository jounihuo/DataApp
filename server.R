#Load shiny and the data
library(shiny)
data(LakeHuron)

#Extract the data
x <- as.numeric(time(LakeHuron))
y <- as.numeric(LakeHuron)
#Create polygon for fill plot
xx <- c(x, rev(x))
yy <- c(rep(0, length(x)), rev(y))

#Initialize the server
shinyServer(
  function(input, output){
    output$levelPlotFeet <- renderPlot({   
      #plotting of the water level in feet
      plot(x ,y ,col="darkBlue",type='l',xlab="Year",ylab="Depth in feet",lwd=3,cex.lab=1.5)
      grid(NA, NULL, lwd = 1)
      polygon(xx, yy, col='lightBlue', border=NA)
      #condtional plotting of the mean and fit lines
      if(length(input$lines)==1 && input$lines=="0"){
        abline(h=mean(x), col="darkBlue")
      }
      if(length(input$lines)==1 && input$lines=="1"){
        abline(lm(y ~ x), col="red")
      }
      if(length(input$lines)==2){
        abline(h=mean(LakeHuron), col="darkBlue")
        abline(lm(y ~ x), col="red")
      }
      
    })
    output$levelPlotMeters <- renderPlot({
      #plotting of the water level in meters
      plot(x ,y*0.3048 ,col="darkBlue",type='l',xlab="Year",ylab="Depth in meters",lwd=3,cex.lab=1.5)
      grid(NA, NULL, lwd = 1)
      polygon(xx, yy*0.3048, col='lightBlue', border=NA)
      #condtional plotting of the mean and fit lines
      if(length(input$lines)==1 && input$lines=="0"){
        abline(h=mean(y*0.3048), col="darkBlue")
      }
      if(length(input$lines)==1 && input$lines=="1"){
        abline(lm(y*0.3048 ~ x), col="red")
      }
      if(length(input$lines)==2){
        abline(h=mean(y*0.3048), col="darkBlue")
        abline(lm(y*0.3048 ~ x), col="red")
      }
      

    })
    output$linyear <- renderText({
      #Calculating the linear estimate based on the year in proper units.
      if(input$button=="1"){
        paste(as.character(round(predict(lm(y*0.3048 ~ x), newdata = data.frame(x = input$year)),1)), " meters.")
      }
      else{
        paste(as.character(round(predict(lm(y ~ x), newdata = data.frame(x = input$year)),1)), " feet.")
      }
      })
  }
)