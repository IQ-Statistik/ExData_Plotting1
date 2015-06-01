## EDA Project 1
## Plotting exploratory graphs
## Graph 2

## I am working outside US or English speaking country, so just to be sure I set the local time to English
## in order to get time labels in English
## Not necessary if RStudio is set to English in general
Sys.setlocale("LC_TIME", "English")

## Read file
## file must be stored in the working directory, else change path to file
## NAs are put to be "?" and colClasses are set to match requirements
data<-read.table("C:/Users/Irene/Documents/R/Coursera/data/household_power_consumption.txt", sep=";", header=T, na.strings="?", 
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

## Plot 2
## Open PNG file device
png(filename="plot2.png", width=480, height=480) ## 480 is default value anyways, but still setting them just in case
## Plots global active power levels over time
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
## Putting in the main title with the title function as suggested on lecture slides overlays the default title with the new title
## in this case default title stays on graph, therefore used the main parameter in the hist function to set it to a void string
## Close PNG file
dev.off()
