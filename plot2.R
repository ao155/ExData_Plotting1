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

#create the png file
png(filename="plot2.png", width=480,height=480,units="px")
plot(household$DateTime, household$Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab="", yaxt = 'n')
axis(side=2, at = seq(0, 3000, by = 1000), labels = c(0,2,4,6), tick=TRUE)
dev.off()

#clear cache
rm(household)