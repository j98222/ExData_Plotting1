readData = function (filename){
    conn = file(filename)
    result = grep("^(2/2/2007|2/1/2007)", readLines(conn), value = TRUE)
    close(conn)
    result
}


title = read.table("household_power_consumption.txt",header= FALSE,nrows=1,sep=";")
v = as.matrix(title)[1,]
temp = readData("household_power_consumption.txt")
d = read.table(text=temp,sep=";",na="?")
names(d)=v
d$Global_active_power = as.numeric(d$Global_active_power)
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(d$Global_active_power,col="red",main="Global Active Power",xlab = "Global Active Power(kilowatts)")
dev.off()