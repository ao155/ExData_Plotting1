# download file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip the file and store it in your working directory

#load data
household <- read.table("./household_power_consumption.txt", header = TRUE, sep=";")

# format date/time
household$DateTime <- paste(household$Date, household$Time, sep=" ")
household$DateTime <- strptime(household$DateTime, format="%d/%m/%Y %H:%M:%S")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")

#subset the data
household <- subset(household, Date == '2007-02-01' | Date == '2007-02-02')

#set language to english for the weekdays
Sys.setlocale("LC_TIME", "English")

# fomrat attributes
household$Sub_metering_1 <- as.numeric(as.character(household$Sub_metering_1))
household$Sub_metering_2 <- as.numeric(as.character(household$Sub_metering_2))

#create the png file
png(filename="plot3.png", width=480,height=480,units="px")
plot(household$DateTime, household$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="")
lines(household$DateTime, household$Sub_metering_2, col="red")
lines(household$DateTime, household$Sub_metering_3, col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"))
dev.off()

#clear cache
rm(household)
