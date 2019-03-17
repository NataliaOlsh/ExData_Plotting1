#####
# This scipt:
# 1. Reads Data Set from file
# 2. Subsets two dates
# 3. Coerces Date and Time to POSIXct class
# 3. Prints the plot
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
plot(hpcsm$dttm, hpcsm$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering",
     bg = "white");
lines(hpcsm$dttm, hpcsm$Sub_metering_1, type = "l", col = "black");
lines(hpcsm$dttm, hpcsm$Sub_metering_2, type = "l", col = "red");
lines(hpcsm$dttm, hpcsm$Sub_metering_3, type = "l", col = "blue");
legend("topright",
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));

dev.copy(png, "plot3.png");
dev.off();
