## EDA Project 1
## Plotting exploratory graphs
## Graph 3

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

## Plot 3
## Open PNG file device
png(filename="plot3.png", width=480, height=480) ## 480 is default value anyways, but still setting them just in case
## Plots all three sub_metering variables over time
## Put Sub_metering_1 in the basic plot, black is default color
plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
## Putting in the main title with the title function as suggested on lecture slides overlays the default title with the new title
## in this case default title stays on graph, therefore used the main parameter in the hist function to set it to a void string
## Put Sub_metering_2 and Sub_metering_3 in additional lines
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, text.width=45000)
## Close PNG file
dev.off()
