# Plot 3 - Energy sub meterings by time

# Download and unzip file if it's not exists
source("prepare_file.R")

library(data.table)

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

output.file = file.path('figure', 'plot3.png')
png(output.file, width=480, height=480)

plot(dat$Sub_metering_1 ~ dates, type="n", xlab=NA, ylab="Energy sub metering")
lines(dat$Sub_metering_1 ~ dates, type="l", col="black")
lines(dat$Sub_metering_2 ~ dates, type="l", col="red")
lines(dat$Sub_metering_3 ~ dates, type="l", col="blue")

legend("topright", 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col=c("black", "red", "blue"), 
        lwd=1, 
        lty=c(1,1,1))

dev.off()

