HTTP REQUEST WORKS 
YEAHHHH BOIIIIIIII



but what am I suppsoed to do with this info lol

So i have the times of the envents but not the times I'm free
plus being that its a range
it makes it very difficult 

I thought about keeping track of each minute of the day (24hrs *60min) 1440minutes in a day possibly by having an array with a length of 1440 filled with  just 1s and 0s with each item of the array representing each minute and the value of each item determines if that time is free or busy (0 meaning free and 1 being busy)
but that sounds very inefficent, so lets try something else. 


All I really want to do is find the next available time slot for an event so I could just have the program check the time after every scheduled event to see if the new event could fit into the time after one event without bleeding into the other 

take for example this scenario 

you put nothing on your calendar before 8:00 am
one with a starting time of 8:00 and ending time of 9:00 am
one with a starting time of 10:00 and ending time of 11:00 am

to place an event with a duration of one hour as

the starting time of this new event has to be greater than the first events end time (9am or after)
but before the ending time of this new event has to be less than the time  of the upcoming event (before)

and thats how I think the next available time could be found 

but to do that, youd need an ordered list of events (they have to be sorted otherwise you cant compare two events in the same way done above)

I got the list of events from the request
which I made a shorter array of hashes with each hash having information for one event, which didnt come in order 
to put them in order I took away the name because name was uneccessary jiust the time times that are important

take each event start time and 




take away 
write what your planning or thinking 
and keep track of it


rememeber 