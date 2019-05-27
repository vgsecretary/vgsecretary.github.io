require 'net/http' 
require 'json' 
require 'pp' 
require 'dotenv/load' 
require 'time'
# hash-->key "items"-->array-->hash of an event 
calendarIdArray=["k6ttlvfvbtkf3d92thj8avdrf8@group.calendar.google.com", "ir0rg8oqlk3fdgaq9avjlk1r0s@group.calendar.google.com", "3svf33bh0knsbr4ah10hv7u0e8@group.calendar.google.com", "ssecr3p08usmp0n97i048smbts@group.calendar.google.com", "fje5qut9s3t6540tiacnq1rndk@group.calendar.google.com", "s6nm4ucearvdkpivov5vklbt10@group.calendar.google.com", "travism7618@gmail.com", "182a9nderg1oic604k04h3l94o@group.calendar.google.com", "rg5gttj8g2ihj7dt91c1tamcts@group.calendar.google.com", "di52r46hp8iudjgej4ojkijdig@group.calendar.google.com", "cac22quglhar6cv2bi3l3ubmfc@group.calendar.google.com", "kbf1igmpnb72ksb7s6jf5o6bdo@group.calendar.google.com", "hgjmjkb2t8nc9qfccp9j190o4o@group.calendar.google.com", "474l2jpv715e76tel8lpj5isbo@group.calendar.google.com", "bnq88uocrdi56u5so3iv0m474s@group.calendar.google.com", "52ovd62cqg2p6v7uahlecj1vig@group.calendar.google.com", "en.usa#holiday@group.v.calendar.google.com"]

def eventsHash(calendar_id,timeMin,timeMax)
    @calendar_id=calendar_id
    @timeMin=timeMin
    @timeMax=timeMax
    @url="https://www.googleapis.com/calendar/v3/calendars/#{@calendar_id}/events?singleEvents=true&timeMax=#{@timeMax}&timeMin=#{@timeMin}&timeZone=America%2FNew_York&key=#{ENV["API_KEY"]}" 
    JSON.parse(Net::HTTP.get(URI(@url)))
end
    

def eventTimesArray(hash)
    @eventTimes=[]
    hash["items"].each do |event_hash|
        if event_hash["start"]["dateTime"]!= nil then
            @eventTimes << "#{event_hash["start"]["dateTime"]}--#{event_hash["end"]["dateTime"]}" 
        end 
    end
    @eventTimes.sort
end 

calendar_id="ssecr3p08usmp0n97i048smbts@group.calendar.google.com" 
timeMin="2019-05-22T00%3A00%3A00Z" 
timeMax="2019-05-23T00%3A00%3A00Z" 

schoolEventHash=eventsHash(calendar_id,timeMin,timeMax)

etarr=eventTimesArray(schoolEventHash)



def findTime(event_times_array,duration_of_intended_event)
    @event_times_array=event_times_array
    @duration=duration_of_intended_event
    @timeFound=false 
    @i=0
    
    until (@timeFound==true)||(@i>=(@event_times_array.length))
        if @event_times_array[i+1]!=nil then 
            @currentEventEndTime= Time.parse(@event_times_array[i].split("--")[1])
            @nextEventStartingTime= Time.parse(@event_times_array[i+1].split("--")[0])
            @timeBetweenEvents=(nextEventStartingTime-currentEventEndTime).to_i/60
            if timeBetweenEvents>=duration then 
                @timeFound=true
            else
                @i+=1
            end
        else
            @i+=1
        end
    end
end
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