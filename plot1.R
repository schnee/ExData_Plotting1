# Plot 1 Source File

# assumes the existande of ./data/household_power_consumption.zip, which is downloaded from
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
households = read.csv(unz("./data/household_power_consumption.zip",
                          "household_power_consumption.txt"), sep=";", stringsAsFactors=F)

# turn chr's into POSIXlt objects
households$timestamp = strptime(paste(households$Date, households$Time), format="%d/%m/%Y %H:%M:%S")

#convert to numeric
households$Global_active_power = as.numeric(households$Global_active_power)

# filter
start = "2007-02-01 00:00:00"
end = "2007-02-02 23:59:59"
start = strptime(start, format="%Y-%m-%d %H:%M:%S")
end = strptime(end, format="%Y-%m-%d %H:%M:%S")
households_slice = subset(households, timestamp>=start & timestamp<=end)

# and plot
# 480 x 480 are the defaults for hist()
png(file="plot1.png")
hist(households_slice$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()
