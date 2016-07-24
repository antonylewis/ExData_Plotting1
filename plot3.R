# Coursera exploratory-data-analysis Assignment 1
# This generates plot3.png

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fname <- "elect.zip"

if (!file.exists("./household_power_consumption.txt")) {
    download.file(URL, destfile=fname, method='curl')
    unzip(fname)
    file.remove(fname)
}

library(data.table)
dt <- fread("household_power_consumption.txt", na.strings='?')
dt$Date <- as.Date(dt$Date, format='%d/%m/%Y')
dt2 <- subset(dt, Date == '2007-02-01' | Date == '2007-02-02')
dt2$DateTime <- as.POSIXct(strptime(paste(dt2$Date, dt2$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))

png('plot3.png', width=480, height=480)
par(bg='transparent')
par(mfrow=c(1,1))
plot(dt2$Sub_metering_1 ~ dt2$DateTime,
	type='l',
	col='black',
	ylab='Energy sub metering',
	xlab='')
lines(dt2$Sub_metering_2 ~ dt2$DateTime, col='red')
lines(dt2$Sub_metering_3 ~ dt2$DateTime, col='blue')
legend("topright",
	lty=1,
	col=c('black', 'red', 'blue'),
	legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()