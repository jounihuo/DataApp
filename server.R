library(shiny)
data(LakeHuron)
x <- as.numeric(time(LakeHuron))
y <- as.numeric(LakeHuron)

xx <- c(x, rev(x))
yy <- c(rep(0, length(x)), rev(y))

shinyServer(
  function(input, output){
    output$levelPlotFeet <- renderPlot({   
      plot(x ,y ,col="darkBlue",type='l',xlab="Year",ylab="Depth in feet",lwd=3,cex.lab=1.5)
      grid(NA, NULL, lwd = 1)
      polygon(xx, yy, col='lightBlue', border=NA)
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
      plot(x ,y*0.3048 ,col="darkBlue",type='l',xlab="Year",ylab="Depth in meters",lwd=3,cex.lab=1.5)
      grid(NA, NULL, lwd = 1)
      polygon(xx, yy*0.3048, col='lightBlue', border=NA)
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
      #if(length(input$button)>0){
      #  paste(as.character(predict(lm(y ~ x), newdata = data.frame(x = input$year))), " feet.")
      #}
      if(input$button=="1"){
        paste(as.character(round(predict(lm(y*0.3048 ~ x), newdata = data.frame(x = input$year)),1)), " meters.")
      }
      else{
        paste(as.character(round(predict(lm(y ~ x), newdata = data.frame(x = input$year)),1)), " feet.")
      }
      })
  }
)