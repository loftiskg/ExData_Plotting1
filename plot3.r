plot3 <- function()
{
  
  if(!file.exists("household_power_consumption.txt"))
  {
    source("getFile.r")
    powerData <- getFile()
  }else
  {
    library(data.table)
    #reads in function as data.table
    powerData <- fread("household_power_consumption.txt")
    #subsets data to only the dates 2-2-2007, 2-1-2007 (m/d/yyyy)
    powerData <- powerData[powerData$Date == "2/2/2007"|powerData$Date == "1/2/2007",]
    #makes a new row within the subsetted table that combines the date and time into a single Date
    #for easier graphing of time variables
    powerData$newDate<-with(powerData, as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))
    
  }
  
  png(filename = "plot3.png")
  
  plot(powerData$Sub_metering_1~powerData$newDate,type = "l", xlab = "", ylab = "Energy sub metering")
  lines(powerData$newDate,powerData$Sub_metering_2, col="red", type = "l")
  lines(powerData$newDate,powerData$Sub_metering_3, col="blue", type = "l")
  legend('topright',legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), lty = c(1,1,1),
        col=c('black','red','blue'))
  
  dev.off()
}