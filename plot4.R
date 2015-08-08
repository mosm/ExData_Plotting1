# load data using ';' separator and identifying Date and Time as character
# classes, all other columns as numeric
power <- read.table("household_power_consumption.txt", header=TRUE, 
                    sep=";", na.strings="?", colClasses=
                      c("character", "character", rep("numeric", 7)), 
                    stringsAsFactors=FALSE)

# selecting all rows where date = 1/2/2007 or 2/2/2007 
subpower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007", ]

# Creating a DateTime data.frame that combines Date and Time,
# yielding a POSIXct datetime column
DateTime <- data.frame(strptime(paste(subpower$Date, 
                                      subpower$Time, sep=" "), 
                                format="%d/%m/%Y %H:%M:%S"))
# Adding a column name to the data.frame
colnames(DateTime) <- c("DateTime")

# Merging the newly created dataframe with the original subpower data.frame
subpower <- cbind(DateTime, subpower)

#Setting up png device
png(filename="plot4.png", width=480, height=480)

#Set-up 2x2 plot matrix
par(mfrow=c(2,2))

#Plot1
#setting up plot with DateTime on x-axis and Global Active Power on y-axis
#setting x-label to empty and setting appropriate y-label
plot(subpower$DateTime, subpower$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

#Plot2
#setting up plot with DateTime on x-axis and Voltage on y-axis
#setting x-label and y-label appropriately
plot(subpower$DateTime, subpower$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

#Plot 3
#setting up plot with the appropriate scales
#Setting type to n to suppress plots
plot(subpower$DateTime, subpower$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")

#adding lines for sub_metering1 in black
lines(subpower$DateTime, subpower$Sub_metering_1, type="l", col="black")

#adding lines for sub_metering2 in red
lines(subpower$DateTime, subpower$Sub_metering_2, type="l", col="red")

#adding lines for sub_metering3 in blue
lines(subpower$DateTime, subpower$Sub_metering_3, type="l", col="blue")

#adding legend topright, indicating lines through lty
#with appropriate colors and legend texts
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot4
#setting up plot with DateTime on x-axis and Global reactive power on y-axis
#setting x-label and y-label appropriately
plot(subpower$DateTime, subpower$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")


#Closing device, following this step the PNG file is available in the 
#working directory
dev.off()
