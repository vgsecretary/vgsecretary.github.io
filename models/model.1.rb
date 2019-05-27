require 'net/http' 
require 'json' 
require 'pp' 
require 'dotenv/load' 
require 'time'
# hash-->key "items"-->array-->hash of an event 
calendarIdArray=["k6ttlvfvbtkf3d92thj8avdrf8@group.calendar.google.com", "ir0rg8oqlk3fdgaq9avjlk1r0s@group.calendar.google.com", "3svf33bh0knsbr4ah10hv7u0e8@group.calendar.google.com", "ssecr3p08usmp0n97i048smbts@group.calendar.google.com", "fje5qut9s3t6540tiacnq1rndk@group.calendar.google.com", "s6nm4ucearvdkpivov5vklbt10@group.calendar.google.com", "travism7618@gmail.com", "182a9nderg1oic604k04h3l94o@group.calendar.google.com", "rg5gttj8g2ihj7dt91c1tamcts@group.calendar.google.com", "di52r46hp8iudjgej4ojkijdig@group.calendar.google.com", "cac22quglhar6cv2bi3l3ubmfc@group.calendar.google.com", "kbf1igmpnb72ksb7s6jf5o6bdo@group.calendar.google.com", "hgjmjkb2t8nc9qfccp9j190o4o@group.calendar.google.com", "474l2jpv715e76tel8lpj5isbo@group.calendar.google.com", "bnq88uocrdi56u5so3iv0m474s@group.calendar.google.com", "52ovd62cqg2p6v7uahlecj1vig@group.calendar.google.com", "en.usa#holiday@group.v.calendar.google.com"]

$eventTimes=[]

class Calendar 
    attr_accessor :calendar_id, :url,:eventsHash
    
    
    @@eventTimes=[] 
    @@duration= 3600 #60 minutes
    @@date=Time.now.getlocal('-04:00')#by default this would be todays date
    @@allCalendars=[]
    
    # So theres alot that happens in setting the time min and max.
    # The date from the time now function returns something like this: 2019-05-25 12:35:14 -0400 which is a time object. With that you could add and subtract different times. 
    # So for the time min and max the program takes the time object that was stored initially and subtracts for the time min and adds for the time max, 86400 seconds from it (24 hours). This way the request could get information regarding the day before  and the day after the date that is stored in the class variable of date
    # The result would be the same time stamp as before, just one day behind or ahead for the time min and max respectively. This time object is then convertted into a string and would then look like "2019-05-24 12:35:14 -0400" and "2019-05-24 12:35:14 -0400"
    #In this way, its easy to grab the year, month and day of the day before and the day after, while keeping each in their original format. (you could take )
    @@timeMin="#{"#{@@date-86400}"[0..3]}-#{"#{@@date-86400}"[5..6]}-#{"#{@@date-86400}"[8..9]}T00%3A00%3A00Z" 
     @@timeMax="#{"#{@@date+86400}"[0..3]}-#{"#{@@date+86400}"[5..6]}-#{"#{@@date+86400}"[8..9]}T00%3A00%3A00Z" 
     
    def initialize(calendar_id)
       @calendar_id=calendar_id
       @@allCalendars << self
    end
     
    def self.eventTimes
        @@eventTimes
    end
    
    def self.duration
        @@duration
    end
    
    def self.date
        @@date
    end
    
    def self.setDuration(duration)
        @@duration=duration
    end
    
    
    def self.setDate(year,month,day)
        @@date=Time.new(year, month, day, 0, 0, 0, "-04:00")
        @@timeMin="#{"#{@@date-86400}"[0..3]}-#{"#{@@date-86400}"[5..6]}-#{"#{@@date-86400}"[8..9]}T00%3A00%3A00Z"
        @@timeMax="#{"#{@@date+86400}"[0..3]}-#{"#{@@date+86400}"[5..6]}-#{"#{@@date+86400}"[8..9]}T00%3A00%3A00Z"
    end
    
    def getEventsHash
        @url="https://www.googleapis.com/calendar/v3/calendars/#{@calendar_id}/events?orderBy=startTime&singleEvents=true&timeMax=#{@@timeMax}&timeMin=#{@@timeMin}&timeZone=America%2FNew_York&key=#{ENV["API_KEY"]}" 
        @eventsHash=JSON.parse(Net::HTTP.get(URI(@url)))
    end
    
    def self.getEventsHash
        @@allCalendars.each do |calendar|
            calendar.getEventsHash
        end
    end
    
    def storeEventTimes
        @eventsHash["items"].each do |event_hash|
            if event_hash["start"]["dateTime"].include?(("#{Calendar.date}"[0..9]))  then
                @@eventTimes << "#{event_hash["start"]["dateTime"]}--#{event_hash["end"]["dateTime"]}" 
            elsif event_hash["end"]["dateTime"].include?(("#{Calendar.date}"[0..9]))  then
                @@eventTimes << "#{event_hash["start"]["dateTime"]}--#{event_hash["end"]["dateTime"]}" 
            end
        end
        @@eventTimes=@@eventTimes.sort
    end 
    
    def self.storeEventTimes
        @@allCalendars.each do |calendar|
            calendar.storeEventTimes
        end
    end
end
    
    
    
    Calendar.setDate(2019,5,24)
    school_calendar=Calendar.new("ssecr3p08usmp0n97i048smbts@group.calendar.google.com" )
    sleep_calendar=Calendar.new("rg5gttj8g2ihj7dt91c1tamcts@group.calendar.google.com" )
   
   
    Calendar.getEventsHash
    Calendar.storeEventTimes
    puts Calendar.eventTimes
    

# 2019-05-22T08:10:00-04:00 ttime firnat for reqhest
# calendar_id="ssecr3p08usmp0n97i048smbts@group.calendar.google.com" 





# timeMin="2019-05-22T00%3A00%3A00Z" 
# timeMax="2019-05-23T00%3A00%3A00Z" 




# def findTime(event_times_array,duration_of_intended_event)
#     @event_times_array=event_times_array
#     @duration=duration_of_intended_event
#     @timeFound=false 
#     @i=0
    
#     until (@timeFound==true)||(@i>=(@event_times_array.length))
#         if @event_times_array[i+1]!=nil then 
#             @currentEventEndTime= Time.parse(@event_times_array[i].split("--")[1])
#             @nextEventStartingTime= Time.parse(@event_times_array[i+1].split("--")[0])
#             @timeBetweenEvents=(nextEventStartingTime-currentEventEndTime).to_i/60
#             if timeBetweenEvents>=duration then 
#                 @timeFound=true
#             else
#                 @i+=1
#             end
#         else
#             @i+=1
#         end
#     end
# end
# save when this function is finished!!!!



=begin 
for each event in the original data hash 
names are uneccessary 
only start times and end times 

For future reference 
I want 
morning work times to be 8-12
afteroon work times to be 12-4
and work times night to be 4-8 





Strategy 1adataea
map out each minute of the day into an array of 1440 filled with 1s and 0s 
0==free 
1==false

just take the time of each event mulitply it by 60




Strategy 2
organize the event hash 
look at the end of each event starting at 8am 

the starting time of the created event must by greater than the most recent event and less than the

it cant be created at the most recent end time 




=end