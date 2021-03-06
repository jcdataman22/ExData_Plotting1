#Set the column classes to numeric using a predefined vecotr variable, and read in the data to a data table assgined to a variable called HPCdata, with the column classes assigned using the predefined variable
columnclasses <- c(Voltage="numeric", Global_active_power="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric",Global_active_power="numeric",Global_reactive_power="numeric")
HPCdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=columnclasses)

#This produces a data table with 2,075,259 observations of 9 variables.

#Create a subset of the data table including only the records from February 1st and 2nd of 2007
HPCdatasubset <- HPCdata[HPCdata$Date %in% c("1/2/2007","2/2/2007") ,]
#This creates a data table with 2,880 observations of 9 variables.

#Viewing a table of the subsetted date column reveals that there are 1440 records for the 1st of February and 1440 records for the 2nd of February.
table(HPCdatasubset$Date)

#Use the as.Date function as suggested in the instructions to format the date column appropriately
as.Date(HPCdatasubset$Date)

#Deleted the records containing NAs
HPCdatasubset <-na.omit(HPCdatasubset)

#Initiate a png device for the plot, with the name of "plot1.png", produce the histogram, and turn the device off
png(file = "plot1.png", width = 480, height = 480)
hist(HPCdatasubset$Global_active_power, col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")
dev.off()