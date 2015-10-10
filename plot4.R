# download file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip the file and store it in your working directory

# load the data
household <- read.table("./household_power_consumption.txt", header = TRUE, sep=";")

#format date/time
household$DateTime <- paste(household$Date, household$Time, sep=" ")
household$DateTime <- strptime(household$DateTime, format="%d/%m/%Y %H:%M:%S")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")

#subset the data
household <- subset(household, Date == '2007-02-01' | Date == '2007-02-02')

#set language to english for the weekdays
Sys.setlocale("LC_TIME", "English")

# format attributes
household$Global_active_power <- as.numeric(as.character(household$Global_active_power))
household$Sub_metering_1 <- as.numeric(as.character(household$Sub_metering_1))
household$Sub_metering_2 <- as.numeric(as.character(household$Sub_metering_2))
household$Voltage <- as.numeric(as.character(household$Voltage))
household$Global_reactive_power <- as.numeric(as.character(household$Global_reactive_power))

#create the png file
png(filename="plot4.png", width=480,height=480,units="px")
par(mfrow=c(2,2))
        
#1st plot
plot(household$DateTime, household$Global_active_power, type='l', ylab="Global Active Power", xlab="")

#2nd plot
plot(household$DateTime, household$Voltage, type='l', ylab="Voltage", xlab="datetime", yaxt='n')
axis(side=2, at = seq(234, 246, by = 4), tick=TRUE)

#3rd plot
plot(household$DateTime, household$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="")
lines(household$DateTime, household$Sub_metering_2, col="red")
lines(household$DateTime, household$Sub_metering_3, col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"), bty="n", cex=0.9)
        
#4th plot
plot(household$DateTime, household$Global_reactive_power, type='l', ylab="Global_reactive_power", xlab="datetime")
axis(side=2, at = seq(234, 246, by = 4), tick=TRUE)

dev.off()

# clear cache
rm(household)

