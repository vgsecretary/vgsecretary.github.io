require 'net/http' 
require 'json' 
require 'pp' 
require 'dotenv/load' 
# hash-->key "items"-->array-->hash of an event 
# School calendar 
calendar_id="ssecr3p08usmp0n97i048smbts@group.calendar.google.com" 
# Sleep calendar 
# calendar_id="ir0rg8oqlk3fdgaq9avjlk1r0s@group.calendar.google.com" 
api_key=ENV["API_KEY"] 

timeMax="2019-05-22T00%3A00%3A00Z" 
timeMin="2019-05-21T00%3A00%3A00Z" 
url="https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events?singleEvents=true&timeMax=#{timeMax}&timeMin=#{timeMin}&timeZone=America%2FNew_York&key=#{api_key}" 


data_hash= JSON.parse(Net::HTTP.get(URI(url)))
daily_event_list=[] 
data_hash["items"].each do |event_hash|
    daily_event_list << {
        "event_name": event_hash["summary"],
        "start_time": event_hash["start"]["dateTime"],
        "end_time": event_hash["end"]["dateTime"] 
    } 
end
puts daily_event_list


