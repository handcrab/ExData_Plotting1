# Plot 1 - Global Active Power
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

# create the plot
output.file = file.path('figure', 'plot1.png')
png(output.file, width=480, height=480)
hist(dat$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main ='Global Active Power')
dev.off()

