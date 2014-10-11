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

        ## Open device and create destination file 'plot2.png' in working
        ## directory.
png(file = "plot2.png", width = 480, height = 480)

        ## Create plot and send to file, not to screen.
with(data_subset, plot(data_subset$DateTime, data_subset$Global_active_power,
                       type = "l", ylab = "Global Active Power (kilowatts)"))

        ## Close the file device. Manually open 'plot2.png' to verify output.
dev.off()
