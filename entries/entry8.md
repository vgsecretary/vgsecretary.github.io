# MVP MVP MVP

## Overview 
Last week I made my final attempts at using javascript within an IDE called CS 50, and after that mess did not work, I decided to go back to using Ruby in cloud 9, being I made the most progress in that language already, and since new information came to light. With much help, I learned that the biggest wall in my project when accessing calendar information, authorization,  is not a problem if calendars are public. With this, I successfully created a working HTTP request of a singular calendar for a specific time frame. This week I worked on sorting through that information to create a program to find free time in my schedule for multiple calendars
.


So my goal was to take the events that I get for a specific day and using that to determine when I am busy and when I would be free for that day. From there I would be able to insert an event when at a time in which I am free.

## Strategies
Being that Ruby doesn't have or at least I couldn't find, a feature that would be able to keep track of time in which I am free and time in which I am busy, I thought about mapping out each minute of the day using arrays. This theoretical array would be filled with ones and zeros that sum to a total index length of 1440 (1440 being the number of minutes in a day). 0 would represent a minute that is free and 1 would represent a minute that is busy. With each event that would be added to the schedule, my program would find a range of 0s to fit an event. It would take the hour that event starts, multiply it by 60, add the leftover minutes and use that number for the index, and fill the index that represents that time, as well as every number following it until the index that represents its end time is reached, and change that whole range of 0s to 1s.  However, realizing how much number crunching that would require on my applications part and how that would most likely hinder its run time, I began looking for other strategies.

I instead went the concept of taking all the event times and checking at the end of each scheduled event if a new event of a given size could go right after it, without passing the time of next event. In other words, my plan was to have my program go through each event that already exists on my calendar for a given day, and set the starting time of this new event to the ending time of the most recent event, then add the duration of this intended event, which would be equal to the ending time to this theoretical event, and then compare that ending time to the next events starting time and determine if this new event’s ending time would pass the next scheduled starting time. This way, seemed best, so it was the one I focused on for the remainder of my project. 

A step by step process of this strategy would go as such.

Using the calendar ID (the unique name/identifier for a calendar), as well as the time min and max (or overall range of when this event will occur), use the event method of the google calendar API to get information on all events during this time (the program should also have the capabilities to search through multiple calendars for this information).
For each event, save its starting and end time into an array (they will be bound as a string and separated by ‘--’ for each event) and sort. 
For each event in this array, take the end time (which would be ending of the string for each item), add the duration to that time, and compare it to the next upcoming event in the array. 

Structure
As per usual with almost everything, the hardest part is getting started, and this task was no different. Once I determined my options, as well as which option I would decide to execute, the question came regarding the exact way in which this strategy would be executed. More specifically came the question of how I would choose to organize my code. At first, I began with just creating functions to represent each step. I figured it would be the best way to organize my code because if something breaks I would be able to debug by isolating the problem based off of which function is being called. 
Like so 
```
def eventsHash(calendar_id,timeMin,timeMax)
    @calendar_id=calendar_id
    @timeMin=timeMin
    @timeMax=timeMax
    @url="https://www.googleapis.com/calendar/v3/calendars/#{@calendar_id}/events?singleEvents=true&timeMax=#{@timeMax}&timeMin=#{@timeMin}&timeZone=America%2FNew_York&key=#{ENV["API_KEY"]}" 
    JSON.parse(Net::HTTP.get(URI(@url)))
end
```
However, I found myself reusing the same information/variables throughout some functions. It actually became quite a hassle and quite confusing this way. I spent several hours pondering the most efficient way in which the code could be structured so that the code was as readable as it could be, and structured in such a way that it was simple to isolate each step for debugging. Ultimately I decided to create a Calendar class, using instance variables such as the url to make the API request, the hash it returns and the calendar ID as unique values for each of the  calendars, and I used values that would remain the same among all calendars,  such as the duration of the event or the time max and min as class varaibles 

I also made it so that each of these class vrauvles could be acessed and alterred through class methods
Such as
```ruby 
def self.duration
        @@duration
    End

def self.setDuration(duration)
        @@duration=duration
end
```


With the utilization of classes it became quite easy to incorporate several calendars as well. As a class method could be created to act as the first step for all calendars. 
For example, to get the event hash from a URL for a single calendar requires for the event hash method to be called on that specfic instance 

Event hash method:
```ruby
def getEventsHash
        @url="https://www.googleapis.com/calendar/v3/calendars/#{@calendar_id}/events?orderBy=startTime&singleEvents=true&timeMax=#{@@timeMax}&timeMin=#{@@timeMin}&timeZone=America%2FNew_York&key=#{ENV["CALENDAR_KEY"]}" 
        @eventsHash=JSON.parse(Net::HTTP.get(URI(@url)))
    end
```
Calling it would look like
```ruby
school_calendar=Calendar.new("ssecr3p08usmp0n97i048smbts@group.calendar.google.com" ).getEventsHash
```

But with using classes and class methods a mehtod could be created to call that single method on a whole array of instance classes

```ruby
def self.getEventsHash
        @@allCalendars.each do |calendar|
            calendar.getEventsHash
        end
    end
```
So overall it would look like this 
```
school_calendar=Calendar.new("ssecr3p08usmp0n97i048smbts@group.calendar.google.com" )
sleep_calendar=Calendar.new("rg5gttj8g2ihj7dt91c1tamcts@group.calendar.google.com" )
transport_calendar= Calendar.new("3svf33bh0knsbr4ah10hv7u0e8@group.calendar.google.com")
so_calendar=Calendar.new("s6nm4ucearvdkpivov5vklbt10@group.calendar.google.com")
spiritualGrowth_calendar=Calendar.new("cac22quglhar6cv2bi3l3ubmfc@group.calendar.google.com")
assignments_calendar=Calendar.new("52ovd62cqg2p6v7uahlecj1vig@group.calendar.google.com")


Calendar.getEventsHash

```

# Takeaways:
Think before you act
The code that youre making is code that you’re going to build upon after you make your MVP, so be sure think ahead when strutcturing code. 

Write down every idea that comes to mind throughout the day

