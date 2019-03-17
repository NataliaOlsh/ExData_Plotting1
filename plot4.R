#####
# This scipt:
# 1. Reads Data Set from file
# 2. Subsets two dates
# 3. Coerces Date and Time to POSIXct class
# 3. Prints 4  plots
# 4. Saves it to png file
####

hpc <- read.csv("household_power_consumption.txt",
                sep=";",
                na.strings="?",
                stringsAsFactors=FALSE);
hpcsm<-subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007");

library(dplyr);
hpcsm<-mutate(hpcsm,
              dttm = as.POSIXct(strptime(paste(hpcsm$Date, hpcsm$Time), '%d/%m/%Y %H:%M:%S')));

windows();
par(mfcol = c(2,2));

# Plot 1-1
plot(hpcsm$dttm, hpcsm$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power",
     bg = "white");
lines(hpcsm$dttm, hpcsm$Global_active_power, type = "l");

# Plot 2-1
plot(hpcsm$dttm, hpcsm$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy Sub Metering", 
     bg = "white");
lines(hpcsm$dttm, hpcsm$Sub_metering_1, type = "l", col = "black");
lines(hpcsm$dttm, hpcsm$Sub_metering_2, type = "l", col = "red");
lines(hpcsm$dttm, hpcsm$Sub_metering_3, type = "l", col = "blue");
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        bty = "n");

# Plot 1-2
plot(hpcsm$dttm, hpcsm$Voltage, type = "n",
     xlab = "datetime", ylab = "Voltage", bg = "white");
lines(hpcsm$dttm, hpcsm$Voltage, type = "l", col = "black");

# Plot 2-2
plot(hpcsm$dttm, hpcsm$Global_reactive_power, type = "n",
     xlab = "datetime", ylab = "Global Reactive Power", bg = "white");
lines(hpcsm$dttm, hpcsm$Global_reactive_power, type = "l", col = "black");

dev.copy(png, "plot4.png");
dev.off();
