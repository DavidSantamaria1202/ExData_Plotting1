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

#Create graph 3
png("plot3.png",480,480,"px")

plot(y = powerCons$Sub_metering_1,x = powerCons$Date_Time, type="n", xlab = "",ylab="Energy sub metering")
points(y = powerCons$Sub_metering_1,x = powerCons$Date_Time, type = "l")
points(y = powerCons$Sub_metering_2,x = powerCons$Date_Time, type = "l", col = "red")
points(y = powerCons$Sub_metering_3,x = powerCons$Date_Time, type = "l", col="blue")

vnames <- names(powerCons)[grep(pattern = "^Sub_",x = names(powerCons))]
legend("topright",lty=1,col=c("black","red","blue"),legend=vnames,xpd=TRUE)


dev.off()

file.remove("powerConsumption.zip")