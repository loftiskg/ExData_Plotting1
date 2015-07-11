plot1 <- function()
{
  #checks to see if power was already created by prog
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
  #opens png device
  png(filename = "plott1.png")
  
  #creates histogram
  hist(as.numeric(powerData$Global_active_power), col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power")
  
  
  closes png device
  #dev.off()
}