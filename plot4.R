# Base Plotting system
library(data.table)
library(lubridate)
# Setting the working directory (change this if needs)
setwd('E:/Coursera/Exploratory Data Analysis/Course Project 1/')

#Reading Data from the current directory, if doesn't exits, download it!
if (!file.exists("household_power_consumption.txt")) {
  print('Data need to be downloaded')
  
  Url_File<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(Url_File,destfile='Electric_power_consumption.zip')
  unzip('Electric_power_consumption.zip',overwrite=TRUE)
  print('Data has been downloaded')
  HPC <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
  
}else{
  print('Data exists')
  HPC <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
}

#Extracting subdata form 2 days in February 2007
hpc  <- HPC[HPC$Date=='1/2/2007' | HPC$Date=='2/2/2007',]

#Adding conversion of DateTime to the Data
#hpc$DateTime<-paste(hpc$Date, hpc$Time)
hpc$DateTime<- dmy(hpc$Date)+hms(hpc$Time)
hpc$DateTime <-as.POSIXlt(hpc$DateTime)

# open device
png(filename='plot4.png',width=480,height=480,units='px')

# plot data
# make 4 subplots
par(mfrow=c(2,2))

# subplot (1,1)
plot(hpc$DateTime,hpc$Global_active_power,ylab='Global Active Power',xlab='',type='l')

# subplot (1,2)
plot(hpc$DateTime,hpc$Voltage,xlab='datetime',ylab='Voltage',type='l')

# subplot (2,1)
plot(hpc$DateTime,hpc$Sub_metering_1,type='l',col='black',xlab='',ylab='Energy sub metering')
lines(hpc$DateTime,hpc$Sub_metering_2,col='red')
lines(hpc$DateTime,hpc$Sub_metering_3,col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty='solid')


# plot data on bottom right (2,2)
plot(hpc$DateTime,hpc$Global_reactive_power,xlab='datetime',ylab='Global_reactive_power',type='l')


# Turn off device
dev.off()
