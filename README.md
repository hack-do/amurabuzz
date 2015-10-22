[![Build Status](https://travis-ci.org/hack-do/amurabuzz.svg?branch=develop)](https://travis-ci.org/hack-do/amurabuzz)
[![Code Climate](https://codeclimate.com/github/hack-do/amurabuzz/badges/gpa.svg)](https://codeclimate.com/github/hack-do/amurabuzz)
[![Test Coverage](https://codeclimate.com/github/hack-do/amurabuzz/badges/coverage.svg)](https://codeclimate.com/github/hack-do/amurabuzz/coverage)
# A demo of Social Networking Application #

### rake about ###
* Ruby version              2.0.0-p481 (i686-linux)
* RubyGems version          2.2.2
* Rack version              1.6.1
* Rails version             4.2.1
* JavaScript Runtime        therubyracer (V8)
* Active Record version     4.0.2
* Action Pack version       4.0.2
* Action Mailer version     4.0.2
* Active Support version    4.0.2
* Database adapter          mysql2


To start server on http://amurabuzz.dev :

(set app root path in invoker.ini,for more information visit: http://invoker.codemancers.com)
```
$ bundle install
$ invoker start invoker.ini
```
OR

to start server  http://localhost:3000 :
```
$ bundle install
$ rake jobs work
$ bundle exec rails server # (doesnt print server logs properly)
$ puma -t 8:32 -w 3 --preload # (better logs)
$ rackup private_pub.ru -s puma -E production


```

### Gems used ###
1. devise  - authentication
2. omniauth  - Facebook SignIn
3. puma - Server for development
4. delayed Job - Asynchronous serverside execution
5. daemons + invoker - URL modifier
6. paperclip - handling image uploads
7. therubyracer - JS parser
8. paranoia - Soft delete resources
9. kaminari - Pagination
10. font-awesome-rails - Glyphicons
11. activerecord-reputation-system - Likes and comments
12. date-validator - Date validation
13. Testing Suite -
    	brakeman
    	rspec-rails
    	factory_girl_rails
    	faker
    	capybara
    	guard-rspec
    	zeus
    	guard-zeus
    	launchy
    	database_cleaner
    	poltergeist
        phantomjs
        selenium-webdriver
