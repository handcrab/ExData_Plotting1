# Plot 2 - Global Active Power by time

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
# dat[,lapply(date_time, convert.date)]


# create the plot
Sys.setlocale("LC_TIME", "C") # translates weekdays into english

output.file = file.path('figure', 'plot2.png')
png(output.file, width=480, height=480) #units='in', res=300

plot(dat$Global_active_power ~ dates, 
      xlab=NA, 
      ylab="Global Active Power (kilowatts)", 
      type="l")

dev.off()

