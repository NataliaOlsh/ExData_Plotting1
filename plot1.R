#####
# This scipt:
# 1. Reads Data Set from file
# 2. Subsets two dates
# 3. Prints histgram
# 4. Saves it to png file
####

hpc <- read.csv("household_power_consumption.txt", 
                sep=";", 
                na.strings="?",
                stringsAsFactors=FALSE);

hpcsm<-subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007");

windows();
hist(hpcsm$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)");
dev.copy(png, "plot1.png"); 
dev.off();
