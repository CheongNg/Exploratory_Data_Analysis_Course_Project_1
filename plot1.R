#load required library
library(dplyr)
library(varhandle)

#read text file
full_data<-read.table("~/household_power_consumption.txt",header = TRUE,sep = ";")

#scope data
str(full_data)
names(full_data)

#filter and subset data recorded in between 1 Feb and 2 Feb 2007
data_1<-filter(full_data,Date == "1/2/2007")
data_2<-filter(full_data,Date == "2/2/2007")
power_data<-rbind.data.frame(data_1,data_2)

#create new columns for date and weekday
power_data<-mutate(power_data,r_date = as.Date(power_data$Date, format="%d/%m/%Y"))
power_data<-mutate(power_data,weekday = weekdays(r_date))
power_data$Voltage<-unfactor(power_data$Voltage)
power_data$Global_active_power<-unfactor(power_data$Global_active_power)

#housekeeping
rm(full_data,data_1,data_2)
str(power_data)
names(power_data)

#plot histogram
hist(power_data$Global_active_power,freq = 200,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

#create png file
dev.copy(png,file="plot1.png")
dev.off()





