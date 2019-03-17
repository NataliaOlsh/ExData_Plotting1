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
plot(hpcsm$dttm, hpcsm$Global_active_power,
     type = "n",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)", 
     bg = "white");
lines(hpcsm$dttm, hpcsm$Global_active_power, type = "l");

dev.copy(png, "plot2.png"); 
dev.off();
