# Plot 3 Source File

# assumes the existande of ./data/household_power_consumption.zip, which is downloaded from
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
households = read.csv(unz("./data/household_power_consumption.zip",
                          "household_power_consumption.txt"), sep=";", stringsAsFactors=F)

# turn chr's into POSIXlt objects
households$timestamp = strptime(paste(households$Date, households$Time), format="%d/%m/%Y %H:%M:%S")

#convert to numeric
households$Global_active_power = as.numeric(households$Global_active_power)
households$Sub_metering_1 = as.numeric(households$Sub_metering_1)
households$Sub_metering_2 = as.numeric(households$Sub_metering_2)
households$Sub_metering_3 = as.numeric(households$Sub_metering_3)

# filter
start = "2007-02-01 00:00:00"
end = "2007-02-02 23:59:59"
start = strptime(start, format="%Y-%m-%d %H:%M:%S")
end = strptime(end, format="%Y-%m-%d %H:%M:%S")
households_slice = subset(households, timestamp>=start & timestamp<=end)



# and plot
# 480 x 480 are the defaults for hist()
png(file="plot3.png")

plot(households_slice$timestamp, 
     households_slice$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="")
lines(households_slice$timestamp,households_slice$Sub_metering_2, col="red")
lines(households_slice$timestamp,households_slice$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), 
       lwd=c(1,1,1),col=c("black", "red","blue")
       )
dev.off()
