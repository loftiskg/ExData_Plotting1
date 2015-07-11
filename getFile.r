getFile <- function(){
  library(data.table)
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method = "curl")
  unzip(temp,"household_power_consumption.txt")
  powerData <- fread("household_power_consumption.txt")
  
  powerData <- powerData[powerData$Date == "2/2/2007"|powerData$Date == "1/2/2007",] 
  powerData$newDate<-with(powerData, as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))
  powerData
}