## EDA Project 1
## Plotting exploratory graphs
## Graph 1

## Read file
## file must be stored in the working directory, else change path to file
data<-read.table("household_power_consumption.txt", sep=";", header=T)

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

## Deal with NAs and convert variables to appropriate class
## Only converted variables needed for this plot
## There are no "?"-values in this variable, but to be complete, I recoded the absent NAs nonetheless ;-)
data[data$Global_active_power=="?"]<-NA
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))

## Plot 1
## Open PNG file device
png(filename="plot1.png", width=480, height=480) ## 480 is default value anyways, but still setting them just in case
## Plots frequency of global active power levels
## Histogram
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
## Putting in the main title with the title function as suggested on lecture slides overlays the default title with the new title
## therefore used the main parameter in the hist function
## Close PNG file
dev.off()
