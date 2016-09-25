## Exploratory Data Analysis
## Course Project 1 -- "Individual households electric power consumption data"
## Script name: plot2.R

datadir  <- "Electric_Power_Consumption_data"        ## where data file resides
datafile <- "household_power_consumption.txt"        ## name of data file
datafile <- paste( datadir, "/", datafile, sep="" )  ## full path/file name

## Read data in
## ------------

## CVS read-in of 2075260 x 9 data frame:
consumption <- read.csv( datafile, sep = ";", na.strings ="?" )

## convert from factor to Date:
consumption$Date <- as.Date( consumption$Date, "%d/%m/%Y" )  

## Use subset of data, based on dates 2007-02-01 and 2007-02-02:
TwoDayConsumption <- subset( consumption, 
                             Date >= "2007-02-01" & Date <= "2007-02-02" )

## Create POSixlt vector DateTime and add it to TwoDayConsumption data:
DateTime <- paste( TwoDayConsumption$Date, TwoDayConsumption$Time )
DateTime <- strptime( DateTime, format="%Y-%m-%d %H:%M:%S" )
TwoDayConsumption$DateTime <- DateTime

## Plot 2
## ------

plot.new()

png( filename="plot2.png", width = 480, height = 480 )

with( TwoDayConsumption, plot( DateTime, Global_active_power,
                               xlab = "",
                               ylab = "Global Active Power (kilowatts)",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Global_active_power ) )

dev.off()

