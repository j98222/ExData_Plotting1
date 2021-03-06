## read data from the file and only contain data from Feb first and second 2007
readData = function (filename){
    conn = file(filename)
    result = grep("^(2/2/2007|1/2/2007)", readLines(conn), value = TRUE)
    close(conn)
    result
}
## download and unzip the data file if it is not exist
if (!file.exists("exdata_data_household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata_data_household_power_consumption.zip")
}
if (!file.exists("household_power_consumption.txt")){
    unzip("exdata_data_household_power_consumption.zip")
}
## load the data to the datatable
temp = readData("household_power_consumption.txt")
d = read.table(text=temp,sep=";",na="?")

## read header line and change the default header for datatable
title = read.table("household_power_consumption.txt",header= FALSE,nrows=1,sep=";")
v = as.matrix(title)[1,]
names(d)=v

d$Global_active_power = as.numeric(d$Global_active_power)
## convert data and add new cloumn to handle the date time
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")
d$week <- as.POSIXct(strptime(paste(d$Date, d$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))

## generate the plot
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(d,plot(week,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()
