
### Overview
Last week, I finalized my topic decision for my nine-week independent study, the Google Calendar API, and immediately began trying to create my final product, an auto-scheduler.  I instantly started to run into a plethora of issues, usually regarding a 401 error (401 error or Unauthorized error means that the credentials that were entered were invalid for some reason and you aren't authorized to make that request), which I couldn't come to solve. Just before I was going to seek answers by posting on online forums, it occurred to me that I should do the best I could to understand the Google Calendar API as a whole, to go to the basics! (I wish I could say back to the basics, but in reality, I never went to the basics in the first place, so there's that) So week three was exploring the basic concepts of the Google Calendar API, answering as many fundamental questions as I can.


### Google API
The Google Calendar API is a REST API which stands for 'Representational State Transfer' which is a big term with very complicated concepts that are not entirely necessary to understand to use the Google calendar API (or at least I hope not).  Basically, the Google Calendar API allows data from the google calendar service to be accessed through HTTP calls such as GET and POST.


### Basic concepts of Google calendar to know (What are Events and Calendars?)

Each user has a primary calendar by default which cannot be deleted and as well as other user created calendars that can be shared with other users.  A calendar is a collection of related events, as well as additional metadata for those events.
Quick sidenote: 'metadata' is data/information that provides information about other data (pretty meta? amirite?) in this case, the metadata the calendar provides are the summaries, default time zones, locations and more information regarding the events. Each calendar can also be identified by its unique ID. 

 Events are objects associated with a specific date or time range that are identified by a unique ID (just like a calendar). Events contain data such as its summary, description, location, status, reminders, attachments, a start and end date-time (of course) and more. Each event could be shared individually with multiple users as well.

Based on a users' access which is determined by the permissions that were granted when it was shared with them or automatically given if they own it, a user could read and/or edit the information of an event or calendar. 

#### Authorization 
The same way that a user needs access to read/edit the data on Google calendar, so would my app, which means its requests to receive and change data for events and calendars need to be authorized first. With using the Google calendar API, my app needs to use the OAuth 2.0 protocol to authorize requests as all other authorization protocols are not supported.

 There's a whole 77-page document explaining what Oauth 2.0 is, but for this project OAuth 2.0 will be described merely as a protocol for authorizing requests (for time sake we are avoiding the 77-page document for now).

For web applications like one I plan to make, the authorization process begins by redirecting a browser to a Google URL which indicates the type of access that I am requesting: Read-only access, or access to edit. 
The result is an authorization code, which is then exchanged for a refresh token as well as a short-lived access token which is used to authorize requests for the API.
The refresh token is recommended to be saved within the app for future use as when the access token expires the refresh token could be used to obtain a new one.
Long story short, getting the access token and refresh token is the key to solving my problem, and learning how to use the Oath 2.0 protocol in ruby is my first step.

### Next steps
My next step is to learn specifically how to execute the authorization process for my Ruby app so that I could authorize my requests to the Google API and begin expirementing with my personal Google calendar account data. 

### Takeaways
Expose your brain to EVERYTHING
If you ever come across an unfamiliar topic or term in your study, DO NOT OVERLOOK IT (just as I overlooked the authorization process at the beginning of this study). Instead of hoping that it is not something you need to know, learn what you can about it and grasp (at the very least) a general understanding of it. That way could figure out if it's something you need to understand further while leaving fewer gaps in your knowledge. However...


AVOID RABBIT HOLES or magic teleporting wardrobes... 
(Translation: You don't have to UNDERSTAND everything to its fullest extent)
Ever see Alice in Wonderland? Or the Chronicles of Narnia? Learning on you're own reminds me of those stories. One minute you're exploring something simple, and suddenly you end up in a whole different world surrounded by talking anthropomorphic creatures or to guys with hooves for toes. Sometimes learning could be just like that (not exactly like it, but lemme explain). You could start exploring something that seems pretty straightforward, dig extremely deep into it in an attempt to completely understand it but end up finding yourself in a world of confusion, with more questions than you had before. Now, sometimes it's necessary to do this, other times; digging extremely deep into an unfamiliar concept you run into is a waste of time. So unless necessary, avoid these holes, grab the general idea and move on.
