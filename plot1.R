# load data using ';' separator and identifying Date and Time as character
# classes, all other columns as numeric
power <- read.table("household_power_consumption.txt", header=TRUE, 
                    sep=";", na.strings="?", colClasses=
                      c("character", "character", rep("numeric", 7)), 
                    stringsAsFactors=FALSE)

# selecting all rows where date = 1/2/2007 or 2/2/2007 
subpower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007", ]

#Setting up png device
#Set bg to transparent to mimic reference figures provided
png(filename="plot1.png", width=480, height=480, bg="transparent")

#setting up histogram for Global_active_power with color red
#also setting x-label through "xlab" and title through "main"
hist(subpower$Global_active_power, col=2, 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

#Closing device, following this step the PNG file is available in the 
#working directory
dev.off()
