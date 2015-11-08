## EXPLORATORY DATA ANALYSIS - PROJECT 1
## Plot1 construction script

## Loading packages
library(lubridate)

## Reading the downloaded data from the "data" sub-directory into a data frame
print("Reading in the downloaded data from the data sub-directory...")
hhpowcon <- read.table(file = "./data/household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.strings = "?", 
                       stringsAsFactors = FALSE)
print("Done !")
cat("\n")

## Converting Sub_metering columns to integer
print("Converting Sub_metering columns to integer...")
hhpowcon$Sub_metering_1 <- as.integer(hhpowcon$Sub_metering_1)
hhpowcon$Sub_metering_2 <- as.integer(hhpowcon$Sub_metering_2)
hhpowcon$Sub_metering_3 <- as.integer(hhpowcon$Sub_metering_3)
print("Done !")
cat("\n")

## Converting date and time variables and merging them into a new column
print("Dealing with date and time variables and merging them into a new column...")
hhpowcon$dateTime <- dmy_hms(paste(hhpowcon$Date, hhpowcon$Time))
hhpowcon <- hhpowcon[, c(10, 1:9)]
hhpowcon <- hhpowcon[, -(2:3)]
print("Done !")
cat("\n")

## selecting the relevant time range in the data set (2007-02-01 and 2007-02-02)
print("Selecting the relevant time range in the data set (2007-02-01 and 2007-02-02)...")
hhpowcon1 <- hhpowcon[as.Date(hhpowcon$dateTime) == "2007-02-01", ]
hhpowcon2 <- hhpowcon[as.Date(hhpowcon$dateTime) == "2007-02-02", ]
hhpowcon12 <- rbind(hhpowcon1, hhpowcon2)
rm(hhpowcon1, hhpowcon2)
print("Done !")
cat("\n")

## Constructing Plot 2
print("Constructing Plot 2 and writing it to plot2.png file")
my_locale <- Sys.setlocale("LC_TIME") ## preserving the existing locale
Sys.setlocale("LC_TIME", "en_GB.UTF-8") ## changing locale to English
png(filename = "plot2.png", width = 480, height = 480)
par(mfcol = c(1, 1), mar = c(5, 5, 4, 2))
plot(hhpowcon12$dateTime, hhpowcon12$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(hhpowcon12$dateTime, hhpowcon12$Global_active_power)
dev.off()
Sys.setlocale("LC_TIME", my_locale) ## restoring original locale
print("Done, bye !")
cat("\n")
