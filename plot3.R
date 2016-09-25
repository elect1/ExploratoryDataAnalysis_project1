## Exploratory Data Analysis
## Course Project 1 -- "Individual households electric power consumption data"
## Script name: plot3.R

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

## Plot 3
## ------

plot.new()

png( filename="plot3.png", width = 480, height = 480 )

with( TwoDayConsumption, plot( DateTime, Sub_metering_1,
                               xlab = "",
                               ylab = "Energy sub metering",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_1, col="black" ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_2, col="red"   ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_3, col="blue"  ) )
legend( "topright", lty = c(1,1,1), col = c("black","red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ) )

dev.off()

