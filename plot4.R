## Download File
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(URL, "powerConsumption.zip")
## Unzip File
unzip(zipfile = "powerConsumption.zip")

## Read the data frame from the unzipped file.
powerCons <- read.table("household_power_consumption.txt",header = TRUE,sep=";",na.strings = "?")

# Assign the correct class to Date and Time columns
powerCons$Date <- as.Date(powerCons$Date,format="%d/%m/%Y")

# Select only Feb 01 and Feb 02 from 2007 data
Feb2007 <- powerCons$Date >= as.Date("2007/02/01",format="%Y/%m/%d") & powerCons$Date <= as.Date("2007/02/02",format="%Y/%m/%d")
powerCons <- powerCons[Feb2007,]

powerCons["Date_Time"] <- paste(as.character(powerCons$Date),powerCons$Time,sep=" ")
powerCons$Date_Time <- strptime(powerCons$Date_Time,format = "%Y-%m-%d %H:%M:%S")

#Create graph 4
png("plot4.png",480,480,"px")
par(mar=c(4,4,1,1),mfrow = c(2,2))

## Subset 1
plot(y = powerCons$Global_active_power,x = powerCons$Date_Time, type="l", xlab = "",ylab="Global Active Power (Kilowatts)")

## Subset 2
plot(y = powerCons$Voltage,x = powerCons$Date_Time, type="l", xlab = "datetime",ylab="Voltage")

## Subset 3
plot(y = powerCons$Sub_metering_1,x = powerCons$Date_Time, type="n", xlab = "",ylab="Energy sub metering")
points(y = powerCons$Sub_metering_1,x = powerCons$Date_Time, type = "l")
points(y = powerCons$Sub_metering_2,x = powerCons$Date_Time, type = "l", col = "red")
points(y = powerCons$Sub_metering_3,x = powerCons$Date_Time, type = "l", col="blue")

vnames <- names(powerCons)[grep(pattern = "^Sub_",x = names(powerCons))]
legend("topright",lty=1,col=c("black","red","blue"),legend=vnames,inset = c(0.01,0.005) ,cex=.7,box.lty = 0)

## Subset 4
with(powerCons,plot(y = Global_reactive_power,x = Date_Time, type="l", xlab = "datetime"))

dev.off()

file.remove("powerConsumption.zip")