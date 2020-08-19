#This script will create 4 plots in one png file

#Set the column classes to numeric using a predefined vecotr variable, and read in the data to a data table assgined to a variable called HPCdata, with the column classes assigned using the predefined variable
columnclasses <- c(Voltage="numeric", Global_active_power="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric",Global_active_power="numeric",Global_reactive_power="numeric")
HPCdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=columnclasses)

#Create a subset of the data table including only the records from February 1st and 2nd of 2007
HPCdatasubset <- HPCdata[HPCdata$Date %in% c("1/2/2007","2/2/2007") ,]

#Deleted the records containing NAs
HPCdatasubset <-na.omit(HPCdatasubset) 

#Use the as.Date function as suggested in the instructions to format the date column appropriately
as.Date(HPCdatasubset$Date)

#Use the dplyr library to enable the mutate function to add a new column to the data table
#Use the lubridate library to indicate that the dates are in day-month-year format, and to populate a new column with the day of the week
#Make another version of the data table with a column that combines the date and time
library(dplyr)
library(lubridate)
HPCdatasubset2 = mutate(HPCdatasubset, DayofWeek = wday(dmy(HPCdatasubset$Date), label=TRUE))
HPCdatasubset3 = mutate(HPCdatasubset2, DateandTime = with(HPCdatasubset2, dmy(Date) + hms(Time)))

#Initiate a png device for the plot, with the name of "plot1.png", produce the plot, and turn the device off
png(file = "plot4.png", width = 480, height = 480)

#Use the par function to indicate that the device should dislay two rows and two columns
par(mfrow = c(2,2))

#The plot in the upper left corner is similar to plot 2, but does not have the "(kilowatts)" unit in the y label of the graph
plot(x = HPCdatasubset3$DateandTime, y = HPCdatasubset3$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#The plot in the upper right corner is new.  It is similar to plot 2, but has voltage plotted on the y axis, and includes a datetime label on the x axis
plot(x = HPCdatasubset3$DateandTime, y = HPCdatasubset3$Voltage, type="l", xlab="datetime", ylab="Voltage")

#The plot in the lower left corner is identical to plot 3.
plot(HPCdatasubset3$DateandTime, HPCdatasubset3$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(HPCdatasubset3$DateandTime, HPCdatasubset3$Sub_metering_2,col="red")
lines(HPCdatasubset3$DateandTime, HPCdatasubset3$Sub_metering_3,col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#The plot in the lower right corner is new.  It is similar to plot 2, but has global reactive power plotted on the y axis, and includes a datetime label on the x axis
plot(x = HPCdatasubset3$DateandTime, y = HPCdatasubset3$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()