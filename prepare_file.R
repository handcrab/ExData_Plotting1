# Download and unzip file if it's not exists
file.url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.name = "household_power_consumption.txt"

if (!file.exists(file.name)) {
    tmp.file = tempfile()
    #file.arhive.name = paste("household_power_consumption.txt", '.zip')
    download.file(file.url, tmp.file, method='curl')
    unzip(tmp.file)
    #file.remove(file.arhive.name)
    unlink(tmp.file)
}

