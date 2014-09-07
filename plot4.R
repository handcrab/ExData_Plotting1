# Plot 4 - Mixed
library(data.table)

file.name = file.path('..', 'household_power_consumption.txt')
dat = fread(file.name, na.strings = c('?'))

# subset for the given dates
included.dates = c("1/2/2007", "2/2/2007")
dat = dat[Date %in% included.dates]

# convert data to numeric types
num.dat = dat[, -c(1,2), with=F]
num.dat = num.dat[, lapply(.SD, as.numeric)]

dat = cbind(dat[, list(Date, Time)], num.dat)
rm(num.dat)

# create datetime column
dates = dat[,paste(Date, Time)]
dates = as.POSIXct(strptime(dates, "%d/%m/%Y %H:%M:%S"))

# create the plot
Sys.setlocale("LC_TIME", "C") # translates weekdays into english

output.file = file.path('figure', 'plot4.png')
png(output.file, width=480, height=480)

# set up the plot grid
par(mfrow=c(2,2))

# 1st plot
plot(dat$Global_active_power ~ dates, xlab=NA, ylab = "Global Active Power", type="l")

# 2nd plot 
plot(dat$Voltage ~ dates, xlab="datetime", type="l")

# 3rd plot
plot(dat$Sub_metering_1 ~ dates, type="n", xlab=NA, ylab = "Energy sub metering")
points(dat$Sub_metering_1 ~ dates, type="l", col="black")
points(dat$Sub_metering_2 ~ dates, type="l", col="red")
points(dat$Sub_metering_3 ~ dates, type="l", col="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, lty=c(1,1,1))

# 4th plot
plot(dat$Global_reactive_power ~ dates, type="l", xlab="datetime")

dev.off()

