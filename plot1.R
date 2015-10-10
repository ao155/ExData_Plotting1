# download file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip the file and store it in your working directory

#load data
household <- read.table("./household_power_consumption.txt", header = TRUE, sep=";")

# format date/time
household$DateTime <- paste(household$Date, household$Time, sep=" ")
household$DateTime <- strptime(household$DateTime, format="%d/%m/%Y %H:%M:%S")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")

#subset data
household <- subset(household, Date == '2007-02-01' | Date == '2007-02-02')

#format attributes
household$Global_active_power <- as.numeric(as.character(household$Global_active_power))

#create the png file
png(filename="plot1.png", width=480,height=480,units="px")
hist(household$Global_active_power, xlab="Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()

#clear cache
rm(household)
