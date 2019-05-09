require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'date'
require 'fileutils'
# freeze makes the file or variable unchangeable
OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR #:: is resolution operator. It allows you to access items in modules, or class-level items in classes. 

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
# puts response = service.(calendar_id,
                              # max_results: 10,
                              # single_events: true,
                              # order_by: 'startTime',
                              # time_min: DateTime.now.rfc3339
                              # )
# service.query_freebusy (
#   "timeMin": DateTime.now.rfc3339,
#   "timeMax": DateTime.now.rfc3339,
#   "items": [
#     {
#       "id": calendar_id
#     }
#   ]
# )    
# puts 'Upcoming events:'
# puts 'No upcoming events found' if response.items.empty?
# response.items.each do |event|
#   start = event.start.date || event.start.date_time
#   puts "- #{event.summary} (#{start})"
# end
# puts service.query_freebusy
# print service.method(:query_freebusy).parameters
# print service.method(:list_events).parameters



require 'net/http'
require 'uri'
require 'json'

access_token=[]
File.open("token.yaml").each do |line|
     access_token << line
end
access_token = access_token[1].split(",")[1].split(':')[1].gsub("\"","")

uri = URI.parse("https://www.googleapis.com/calendar/v3/freeBusy")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Authorization"] = "Bearer []"
request["Accept"] = "application/json"
request.body = JSON.dump({
  "timeMin" => "2019-04-08T00:00:00-00:00",
  "timeMax" => "2019-04-09T00:00:00-00:00",
  "items" => [
    {
      "id" => "ssecr3p08usmp0n97i048smbts@group.calendar.google.com"
    }
  ]
})

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

puts response
# response.body

