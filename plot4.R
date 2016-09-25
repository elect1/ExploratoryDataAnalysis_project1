## Exploratory Data Analysis
## Course Project 1 -- "Individual households electric power consumption data"
## Script name: plot4.R

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

## Plot 4
## ------

plot.new()

png( filename="plot4.png", width = 480, height = 480 )

par( mfcol = c(2,2), mar = c(5,4,2,1) )  ## set up 2 x 2 subplots drawn columnwise

## upper-left subplot:
with( TwoDayConsumption, plot( DateTime, Global_active_power,
                               xlab = "",
                               ylab = "Global Active Power",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Global_active_power ) )

## lower-left subplot:
with( TwoDayConsumption, plot( DateTime, Sub_metering_1,
                               xlab = "",
                               ylab = "Energy sub metering",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_1, col="black" ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_2, col="red"   ) )
with( TwoDayConsumption, lines( DateTime, Sub_metering_3, col="blue"  ) )
legend( "topright", lty = c(1,1,1), col = c("black","red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),
        box.lty = 0, inset = 0.01 )

## upper-right subplot:
with( TwoDayConsumption, plot( DateTime, Voltage,
                               xlab = "datetime",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Voltage ) )

## lower-right subplot:
with( TwoDayConsumption, plot( DateTime, Global_reactive_power,
                               xlab = "datetime",
                               type = "n" ) )
with( TwoDayConsumption, lines( DateTime, Global_reactive_power ) )

dev.off()



