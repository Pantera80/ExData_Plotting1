# Base Plotting system

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

hpc  <- HPC[HPC$Date=='1/2/2007' | HPC$Date=='2/2/2007',]

# open device
png(filename='E:/Coursera/Exploratory Data Analysis/Course Project 1/plot1.png',width=480,height=480,units='px')

# plot data
hist(hpc$Global_active_power,main='Global Active Power',xlab='Global Active Power (kilowatts)',col='red')

# Turn off device
dev.off()
