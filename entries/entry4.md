## Overview
Last week I looked at the basics of the Google Calendar API and understanding its basic concepts especially regarding the process of authorizing requests. With that knowledge, I then proceeded to try to create requests of my own and encountered tons of problems


## What I need
Before we talk about what problems I’m facing, I think it's important to keep in mind what I’m trying to do. Being that I'm trying to create an auto scheduler for Google Calendar, as I stated previously, the most important piece of information to do this would be the times in which I am free on my schedule or have no events. With that information, I could look into creating a program to fit in daily tasks within the time that is avaiable. To find this information, however, would require the ‘free busy’ method of the google calencounteredendar API  which analyzes a specified time frame and returns all the times that are free or without events and all the times that are busy or filled with events. 

##  My problem(s)
The main issue is that I fail to make this request, but the reason for this has varied each time. With each strategy, I try a new error is encouterred



### 1. Curl to ruby attempt- 401 error(unauthorized error) 
 One of the coolest things about Google APIs is its extentisve documentation, at least when compared to your average  API. Within the documentation was an example of how to make a direct HTTP request for the ‘free busy’ method. Which works perfectly on their website!


The issue was getting this to work for ruby. I was familiar with making HTTP requests but not so familiar to make one for this project so suddenly. So using their example of making this request for curl, I used a [curl-to-ruby program](https://jhawthorn.github.io/curl-to-ruby/) which looked beautiful!  But didn’t work. It returned my first 401 error. I then realized that within my code in place of the access tokens and refresh tokens we're placeholders that said “Your_token”  that d were replaced with the actual tokens within the example but would need to be replaced when using the requests in your own code. I then tried using the knowledge of the authenticantion prrocess so I could make an authorizized requests by getting the tokens that are recieved within the quick start example. The quickstart example made a separate file with all of its credentials including the tokens. So I accessed them by reading the file, sorting through what was sytax and saving the tokens in an array like this
 ```
 access_token=[]
File.open("token.yaml").each do |line|
     access_token << line
end
access_token = access_token[1].split(",")[1].split(':')[1].gsub("\"","")
```
But even with the right tokens, still my request was unauthirized     


### 2. ‘.methods’ and ‘.query_freebusy’ attempt- Missing parameters error 
By using the method .method I found that you could call the free busy method on the service object within the quick start example which I tried using the same syntax from the list events request that was shown in the quick start example which returned the Time in parameter error which meant that it was not recognizing my parameters. So I tried to search it up online,  but there was very little documentation for it there was however documentation for Ruby on Rails like this 
``` 
client.execute(
  :api_method => service.freebusy.query,
  :body => JSON.dump({
    :timeMin => ,
    :timeMax => ,
    :items => 
  }),
  :headers => {'Content-Type' => 'application/json'})
```

 But because the syntax is not the same I constantly got the time min error. 

Nothing seems to be working I've done this for the past week and I admit it is definitely discouraging so being that I have run out of things to search in order for me to solve this problem that has remained prevalent since week 2. 
Though I have posted my own question on [StackOverflow](https://stackoverflow.com/questions/55895909/google-freebusy-api-method-returning-not-found-error)  

## My next steps 
my next steps is 2 look into other methods that I can use to accomplish this and or learn a different language in order to interact with this API 



## My takeaways
sometimes you don't know everything and is discouraging but still, the whole point of an  independent study is to continuously learn about something that you have really little to no knowledge about already so, in reality, there's going to be a lot more that you don't know that what you do know so don't be discouraged.
Remember failure leads to success, so do not stay discouraged by failure.  As Thomas Jefferson said ‘I did not fail a thousand times. I learned 1000 ways not to make a lightbulb ‘


