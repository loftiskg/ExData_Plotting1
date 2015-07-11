plot4 <- function()
{
  #checks to see if file exists
  if(!file.exists("household_power_consumption.txt"))
  {
    #if file does not exists calls function to download it
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
  png(filename = "plot4.png")
  par(mfrow = c(2,2))
  #upper left plot
  with(powerData,plot(newDate,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power"))
  
  #upper right plot
  plot(powerData$Voltage~powerData$newDate, type = "l", ylab = "Voltage", xlab = "dateTime")
  
  #bottom left plot
  plot(powerData$Sub_metering_1~powerData$newDate,type = "l", xlab = "", ylab = "Energy sub metering")
  lines(powerData$newDate,powerData$Sub_metering_2, col="red", type = "l")
  lines(powerData$newDate,powerData$Sub_metering_3, col="blue", type = "l")
  legend('topright',legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), lty = c(1,1,1),
         col=c('black','red','blue'), cex = .75,bty = "n")
  
  #bottom right plot
  plot(powerData$Global_reactive_power ~ powerData$newDate, type = "l", xlab = "dateTime", ylab = "Global Reactive Power" )
  dev.off()
}