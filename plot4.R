# Plot 4
# Subplots for power, voltage and energy

# Load full dataset
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ';', na.strings = "?", stringsAsFactors = FALSE)
## Generate a temporary column, just for clarity, for filtering data set: 
## we only need the days '01/02/2007' and '02/02/2007'
data$Date2 <- as.Date(data$Date, format="%d/%m/%Y")
subdata <- subset(data, subset=(Date2 >= "2007-02-01" & Date2 <= "2007-02-02"))

## Remove data object: free memory and avoid errors
remove(data)

## Generate a new datatime column 
subdata$DateTime <- strptime(paste(subdata$Date, subdata$Time), 
                             format="%d/%m/%Y %H:%M:%S")

## Start the plot device
png(filename="plot4.png", height=480, width=480, bg="transparent")

## Plot the data: please, note that my locale is Spanish not English so
## day literals in the generated image may appear in my language 
## (i.e. jue, vie and sab instead of thu, fri and sat)

## Prepare a 2 by 2 plot layout 
par(mfrow = c(2, 2))

## Top left subplot is the same as Plot 2

plot(subdata$DateTime,
     subdata$Global_active_power,, 
     type="l",
     xlab="",
     ylab="Global Active Power")

## Top right subplot: voltage vs time

plot(subdata$DateTime,
     subdata$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

## Bottom left subplot is the same as Plot 3

## Plot the first sub-meter
plot(subdata$DateTime,
     subdata$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

## Plot the second sub-meter
lines(subdata$DateTime,
      subdata$Sub_metering_2,
      type="l",
      col="red")

## Plot the third sub-meter
lines(subdata$DateTime,
      subdata$Sub_metering_3,
      type="l",
      col="blue")

## Add plot's legend
legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2, bty="n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Bottom right subplot: global reactive power over time

plot(subdata$DateTime,
     subdata$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

## Save the figure and terminate device
dev.off()
