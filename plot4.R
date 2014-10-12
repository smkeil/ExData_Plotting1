        ## This assignment uses data from the UC Irvine Machine Lerning Repository
        ## http://archive.ics.uci.edu/ml/ . For this exercise, a copy of the
        ## 'Electric power consumption' data is downloaded from Coursera's web
        ## site if it is not already present in the current working directory.
if (!file.exists("household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "household_power_consumption.zip")
}

library(dplyr)

        ## File can be unzipped and read in all at once with unz() since the
        ## zip file currently contains a single zipped file. If the contents of
        ## the zip file change or increase to more than 1 file, the following
        ## code for pulling in the zipped data will likely need updating.
data_complete <- tbl_df(read.table(unz("household_power_consumption.zip",
                                       "household_power_consumption.txt"),
                                        header = TRUE,
                                        sep = ";",
                                        as.is = TRUE,
                                        na.strings = "?"))

        ## Reduce dataset to observations on 2007-02-01 & 2007-02-02 only. Note
        ## datafile observations have date format of DD/MM/YYYY.
data_subset <- filter(data_complete, as.Date(Date, "%d/%m/%Y") == "2007-02-01" |
                                     as.Date(Date, "%d/%m/%Y") == "2007-02-02")

        ## strptime() on new DateTime column allows for x-axis data organized by
        ## day of week.
data_subset$DateTime <- strptime(paste(data_subset$Date, data_subset$Time,
                                sep = ","), format="%d/%m/%Y,%H:%M:%S")

        ## Open device and create destination file 'plot4.png' in working
        ## directory.
png(file = "plot4.png", width = 480, height = 480)

        ## Destination png file will have 4 plots, two by two.
par(mfrow = c(2,2))

        ## Create plot and send to file, not to screen.
with(data_subset, {
                ## Plot 1 of 4
        plot(data_subset$DateTime, data_subset$Global_active_power, type = "l",
             xlab = "", ylab = "Global Active Power")

                ## Plot 2 of 4
        plot(data_subset$DateTime, data_subset$Voltage, type = "l",
             xlab = "datetime", ylab = "Voltage")

                ## Plot 3 of 4
        plot(data_subset$DateTime, data_subset$Sub_metering_1,
             type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
        lines(data_subset$DateTime, data_subset$Sub_metering_2, col = "red")
        lines(data_subset$DateTime, data_subset$Sub_metering_3, col = "blue")
        legend("topright", lwd = "1", bty = "n", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

                ## Plot 4 of 4
        plot(data_subset$DateTime, data_subset$Global_reactive_power, type = "l",
             xlab = "datetime", ylab = "Global_reactive_power")
})

        ## Close the file device. Manually open 'plot4.png' to verify output.
dev.off()
