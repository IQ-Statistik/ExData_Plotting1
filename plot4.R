## EDA Project 1
## Plotting exploratory graphs
## Graph 4

## I am working outside US or English speaking country, so just to be sure I set the local time to English
## in order to get time labels in English
## Not necessary if RStudio is set to English in general
Sys.setlocale("LC_TIME", "English")

## Read file
## file must be stored in the working directory, else change path to file
data<-read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?", 
                 colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## Convert date and time
data$Date<-paste(data$Date,data$Time)
data$datetime<-strptime(data$Date, "%d/%m/%Y %H:%M:%S")

## Specify start and end date/time
x<-strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S")
y<-strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S")

## Reduce data to used subset
## did not drop data that wasn't needed for a specific plot as normally the code for all exploratory graphs
## would probably be put in one file
## Original date & time variable dropped as merged to datetime
data<-subset(data, (datetime>=x)&(datetime<=y), select=c(datetime, Global_active_power:Sub_metering_3))

## Plot 4
## Open PNG file device
png(filename="plot4.png", width=480, height=480) ## 480 is default value anyways, but still setting them just in case
## Set parameters for 2x2 graphs on the same grid
par(mfrow=c(2,2))
## Top left plot is as in plot2
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
## Top right plot is quite similar to plot2, but with a different variable on the y-axis and a title for x-axis
plot(data$datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage", main="")
## Bottom left plot is as in plot 3, but with no box around the legend (and legend more to the left to fit in)
plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, text.width=90000, bty="n")
## Bottom right plot is also quite similar to plot2, but again with a different variable on y and a title for x
plot(data$datetime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", main="")
## Close PNG file
dev.off()
