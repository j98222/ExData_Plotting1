readData = function (filename){
    conn = file(filename)
    result = grep("^(2/2/2007|1/2/2007)", readLines(conn), value = TRUE)
    close(conn)
    result
}

title = read.table("household_power_consumption.txt",header= FALSE,nrows=1,sep=";")
v = as.matrix(title)[1,]
temp = readData("household_power_consumption.txt")
d = read.table(text=temp,sep=";",na="?")

names(d)=v
d$Global_active_power = as.numeric(d$Global_active_power)
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")
d$week <- as.POSIXct(strptime(paste(d$Date, d$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(d,plot(week,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()
