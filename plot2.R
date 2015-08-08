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
cbind(DateTime, subpower)

#Setting up png device
png(filename="plot2.png", width=480, height=480)

#setting up plot with DateTime on x-axis and Global Active Power on y-axis
#setting x-label to empty and setting appropriate y-label
plot(subpower2$DateTime, subpower2$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

#Closing device, following this step the PNG file is available in the 
#working directory
dev.off()
