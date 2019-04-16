
# Week Two: GOOGLE CALENDAR API

### Overview
I spent the first week of my independent study contemplating what language I should learn, but in seeing that all languages are just tools to create something I realized that the focus of the topic for my project should be less about what I was going to use to code and more about what I wanted to make. 
So after hours upon hours upon hours upon hours upon hours upon hours upon hours upon... (you get the idea) I FINALLY CHOSE MY TOPIC FOR MY 9 WEEK INDEPENDENT STUDY:
THE GOOGLE CALENDAR API!
So I spent this week interacting with this API using Ruby, trying to get data from my account to show in my console. 

### What is the Google API
For those who don't know, API is an acronym for Application Programming Interface, which simply put, is like a bridge that allows one application to talk to another one. Its an access point to an app that can access a database.
With the Google Calendar API, you could find and view public calendar events from Google calendar and if you are authorized,  access and modify private calendars and events on those calendars.

### Why the Google API?
I came to terms with this by thinking about what I could make that would be unique and most helpful to me. So being that I was big on productivity, I thought about the tools I already use to utilize my time effectively and how they could be improved to suit my needs better. So I arrived at the Google Calendar API, my most used productivity tool. 
I want to make an auto- scheduler, something that would automatically find time for events on my schedule. Though Google has a feature for this, it is constraining since it only works for one calendar category at a time. The final product that I'm ultimately reaching towards creating is an app that would take in several tasks from my google tasks list and schedule them based off of priority. 
However, before I can go crazy with imagination my goal is to build the smallest thing I can create that fits the requirements of what I want to make:    
To make an app that would take in a task that I want to do for the day, along with how long it would take and find time for it on my schedule amongst all my separate calendars on Google.


### My experiment
At the moment I'm choosing to interact with the Google Calendar API using Ruby, an object-oriented, general-purpose programming language that I have some experience in using already. 
I was excited to know it was a language that could use this API and immediately began using the Ruby example that Google gave me to test out. 

```
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'date'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Fetch the next 10 events for the user
calendar_id = 'primary'
response = service.list_events(calendar_id,
                               max_results: 10,
                               single_events: true,
                               order_by: 'startTime',
                               time_min: DateTime.now.rfc3339)
puts 'Upcoming events:'
puts 'No upcoming events found' if response.items.empty?
response.items.each do |event|
  start = event.start.date || event.start.date_time
  puts "- #{event.summary} (#{start})"
end
```

(Tons of code, I know)

This was the quickstart example that Google provides for ruby. Long story short, it authorizes temporary access to your google account and saves those credentials and temporary access keys to a new file. It then uses those credentials to call methods on an instance of the CalendarService class to get information from your account. In this case, it grabs the first ten events from your primary calendar.
 
However, knowing that I needed the times of all my events, from all my calendars, I started looking into new methods that I could use. I found two that seems very crucial to this project and were pretty self-explanatory. Like the method ‘list calendars’ which lists all the calendars that a user has access to, or the ‘freebusy’ method which lists the times of all the events on the calendars.

I began experimenting by building off what the example already had so that I wouldn't have to repeat the authorization process. So I tried changing the method that would be called on the instance of the CalendarService class but ended up getting an error every time. 


The problem was that there was not much that the example that they really described in their documentation specifically for Ruby. So much experimenting has been a lot of trial and error. For example, the method 'list events' in the documentation has a totally different syntax than what is shown in the quick start example for Ruby.

While the example shows this:
```
service.list_events(calendar_id,
                               max_results: 10,
                               single_events: true,
                               order_by: 'startTime',
                               time_min: DateTime.now.rfc3339)
```

The documentation of the Google website shows this:

```
{
  "kind": "calendar#events",
  "etag": etag,
  "summary": string,
  "description": string,
  "updated": datetime,
  "timeZone": string,
  "accessRole": string,
  "defaultReminders": [
    {
      "method": string,
      "minutes": integer
    }
  ],
  "nextPageToken": string,
  "nextSyncToken": string,
  "items": [
    events Resource
  ]
}
```
it's TOTALLY different syntax and it's been challenging to replicate or even call upon the methods that are seen in the reference. However, I did end up finding all the methods I could use without the documentation, using a ruby method called  '.method' which returns all the methods that can be called on a specific object,  which is a massive step in closing my knowledge gap.

Generally, I haven't gotten far as I wanted to in creating my app. For example: Though I know all the methods I can call, like the free busy method, I'm still struggling to call them correctly, which is a bit discouraging.

The more that I experiment, the more errors I encounter. In some cases, I end up breaking the entire program with syntax issues I don't understand and end up having to go back to previous commits. However, the more I learn what doesn't work, the closer I get to determine what does work. So every time I fail is just one step closer to me figuring it out. 

I'm doing the best I can in ruby, especially since it's a language that I am familiar with that can use the Google API. However, with my biggest struggle being the documentation for it and the lack of examples if no direct progress  is made with Ruby,  I may have to switch to a  different language to interact with the Google API, that would have more clear documentation.






### Takeaways 

1. ALWAYS COMMIT (at least when things are working)
In life, commitment is the key to victory. As said by self-made millionaire and world renown life coach, Tony Robbins: "There is no abiding success without commitment." However, when coding this: "There is no lasting success, without git commits" It is crucial to save your progress the moment you make even the slightest of breakthroughs to make a checkpoint you can go back to in case you break things again.

2. Progress is not always visible
For a while, I thought that as long as my final product is not finished, or even progressing, I'm wasting time. However, failure shouldn't be seen as a waste of time because but instead time that brings you closer to success

