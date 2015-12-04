[![Build Status](https://travis-ci.org/hack-do/amurabuzz.svg?branch=develop)](https://travis-ci.org/hack-do/amurabuzz)
[![Code Climate](https://codeclimate.com/github/hack-do/amurabuzz/badges/gpa.svg)](https://codeclimate.com/github/hack-do/amurabuzz)
[![Test Coverage](https://codeclimate.com/github/hack-do/amurabuzz/badges/coverage.svg)](https://codeclimate.com/github/hack-do/amurabuzz/coverage)
## A demo of Social Networking Application

### App Info
* Rails version             - 4.2.5
* Ruby version              - 2.2.2-p95 (x86_64-linux)
* RubyGems version          - 2.4.8
* Rack version              - 1.6.4
* JavaScript Runtime        - therubyracer (V8)
* JavaScript Testing        - phantomJS

```
$ bundle install
$ mailcatcher
$ foreman start
```

To start server on http://amurabuzz.dev :
(set app root path in invoker.ini,for more information visit: http://invoker.codemancers.com)
```
$ invoker start invoker.ini
```


### Gems used

* [devise] - Authentication
* [omniauth] - Facebook SignIn
* [cancancan] - Authorization
* [Puma] - Server
* [Delayed Job] - Asynchronous serverside execution
* [daemons] + [invoker] - start server at custom URL
* [paperclip] - handling image uploads
* [therubyracer] - JS parser
* [paranoia] - Soft delete resources
* [kaminari] - Pagination
* [ahoy] - Tracking
* [date-validator] - Date validation

### Testing Suite
* [brakeman] -
* [rspec-rails] -
* [factory_girl_rails] -
* [faker] -
* [capybara] -
* [guard-rspec] -
* [zeus] -
* [guard-zeus] -
* [launchy] -
* [database_cleaner] -
* [poltergeist] -
* [phantomjs] -
* [selenium-webdriver] -

### Todos

 - Modify Tests
 - Internalization


[devise]: <https://github.com/plataformatec/devise>
[omniauth]: <https://github.com/intridea/omniauth>
[cancancan]: <https://github.com/CanCanCommunity/cancancan>
[Puma]: <https://github.com/puma/puma>
[Delayed Job]: <https://github.com/collectiveidea/delayed_job>
[daemons]: <https://github.com/thuehlinger/daemons>
[invoker]: <https://github.com/code-mancers/invoker>
[paperclip]: <https://github.com/thoughtbot/paperclip>
[therubyracer]: <https://github.com/cowboyd/therubyracer>
[paranoia]: <https://github.com/rubysherpas/paranoia>
[kaminari]: <https://github.com/amatsuda/kaminari>
[ahoy]: <https://github.com/ankane/ahoy>
[date-validator]: <https://github.com/codegram/date_validator>

[brakeman]: <https://github.com/presidentbeef/brakeman>
[rspec-rails]: <https://github.com/rspec/rspec-rails>
[factory_girl_rails]: <https://github.com/thoughtbot/factory_girl_rails>
[faker]: <https://github.com/stympy/faker>
[capybara]: <https://github.com/jnicklas/capybara>
[guard-rspec]: <https://github.com/guard/guard-rspec>
[zeus]: <https://github.com/burke/zeus>
[guard-zeus]: <https://github.com/qnm/guard-zeus>
[launchy]: <https://github.com/copiousfreetime/launchy>
[database_cleaner]: <https://github.com/DatabaseCleaner/database_cleaner>
[poltergeist]: <https://github.com/teampoltergeist/poltergeist>
[phantomjs]: <http://phantomjs.org/>
[selenium-webdriver]: <https://github.com/vertis/selenium-webdriver>