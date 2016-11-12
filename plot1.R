


#There are many possibilities to load in the data
#I surely did not do the most elegant one but it works
#I load in the entire data first
data<- read.csv("household_power_consumption.txt",header=TRUE,sep = ";",dec=".",
na.strings="?")

#I create a new char-vector merging the two date/time cols
#I can safely owerwrite "data$Date" as I'm gonna delete both cols
data$Date <- paste(data$Date," ", data$Time,sep="")
#deleting also data$Time just to make it clean
data<-data[-2]
#and then I convert it to a date format
data$Date<- strptime(data$Date, format = "%d/%m/%Y %H:%M:%S") 

#Now the data will be limited to the two observed days
data<- data[data$Date < as.POSIXct('2007-02-03 0:00') & data$Date >= as.POSIXct('2007-02-01 0:00') ,]



#loading the png-device
png("plot1.png", width=480, height=480)
#displaying the graph - the color looks like orangeredish
#I actually analyzed the RGB value of the plot of the excercise
#with paint and it gave a RGB value of 255,37,0 :)
#else col="orangered" or even col="red" works, too
hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",
main="Global Active Power",col=rgb(255,37,0,max=255))
#device has to be closed
dev.off()


