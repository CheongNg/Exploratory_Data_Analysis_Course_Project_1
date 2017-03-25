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

#tidy and converting data
power_data<-mutate(power_data,new_time = paste(power_data$Date, power_data$Time))
power_data$new_time<-strptime(power_data$new_time,"%d/%m/%Y %H:%M:%S")
power_data$Global_active_power<-unfactor(power_data$Global_active_power)
power_data$Sub_metering_1<-unfactor(power_data$Sub_metering_1)
power_data$Sub_metering_2<-unfactor(power_data$Sub_metering_2)

#housekeeping
str(power_data)
names(power_data)
rm(full_data,data_1,data_2)

#plot box plot
plot.new()
plot(power_data$new_time,power_data$Sub_metering_1, type = "n", ylab="Energy sub metering",xlab="")
with(power_data,lines(new_time,Sub_metering_1,col="black"))
with(power_data,lines(new_time,Sub_metering_2,col="red"))
with(power_data,lines(new_time,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_m_1","Sub_m_2","Sub_m_3"),cex = .8)

#create png file
dev.copy(png,file="plot3.png")
dev.off()