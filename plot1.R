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

        ## Open device and create destination file 'plot1.png' in working
        ## directory.
png(file = "plot1.png", width = 480, height = 480)

        ## Create plot and send to file, not to screen.
with(data_subset, hist(data_subset$Global_active_power,
                       main = paste("Global Active Power"),
                       xlab = "Global Active Power (kilowatts)",
                       col = "red"))

        ## Close the file device. Manually open 'plot1.png' to verify output.
dev.off()
