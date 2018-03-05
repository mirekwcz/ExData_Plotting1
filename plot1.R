plot1<- function()
{
    ## Function description: 
    ## 1. read data from household_power_consumption.txt file
    ## 2. extract (subset) data for a period of 2 days: 2007-02-01 and 2007-02-02
    ## 3. generate a histogram of global active power in kilowatts
    ## ----------------
    ## The data file household_power_consumption.txt must be present in the working directory 
       
    ## read data into memory
    imported_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
    ## change class of columns to appropriate classes
    imported_data$Date <- as.Date(imported_data$Date, format="%d/%m/%Y")
    imported_data$Time <- format(imported_data$Time, format="%H:%M:%S")
    imported_data$Global_active_power <- as.numeric(imported_data$Global_active_power)
    imported_data$Global_reactive_power <- as.numeric(imported_data$Global_reactive_power)
    imported_data$Voltage <- as.numeric(imported_data$Voltage)
    imported_data$Global_intensity <- as.numeric(imported_data$Global_intensity)
    imported_data$Sub_metering_1 <- as.numeric(imported_data$Sub_metering_1)
    imported_data$Sub_metering_2 <- as.numeric(imported_data$Sub_metering_2)
    imported_data$Sub_metering_3 <- as.numeric(imported_data$Sub_metering_3)
    ## extract data for period between: 2007-02-01 -- 2007-02-02
    subset_data <- subset(imported_data, Date == "2007-02-01" | Date =="2007-02-02")
    ## plot histogram of global active power for 'subset_data' 
    png("plot1.png", width=480, height=480)
    hist(subset_data$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power [kilowatts]", ylab="Frequency")
    dev.off()
}
