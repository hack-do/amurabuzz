source 'https://rubygems.org'

# CORE
gem 'rails', '~> 4.2.0'
gem 'rails-observers'
gem 'mysql2', '0.3.18'
gem 'puma'
# gem 'thin'
gem 'public_activity'
# gem 'capistrano' # , '< 3'

# Authentication & Authorization
gem 'devise'
gem 'devise-i18n'
gem 'devise-async'
gem 'omniauth-facebook'
gem 'friendly_id', '~> 5.0.0'

# STREAMING
gem 'redis'
gem 'private_pub'
gem 'tubesock'
gem 'link_thumbnailer'

gem 'open_uri_redirections'

gem 'typus', github: 'typus/typus'
gem 'autoprefixer-rails'

gem 'daemons'
gem 'delayed_job_active_record'
gem 'invoker'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'paperclip','~>4.2'
gem 'date_validator'
gem 'cancancan', '~> 1.10'
gem 'stackprof'
gem 'ahoy_matey'
gem 'activeuuid', '>= 0.5.0'
gem 'elasticsearch'
gem 'annotate'

# ASSETS
gem 'less-rails'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

# gem 'polymer-rails'
# gem 'polymer-core-rails'
gem 'twemoji'
gem 'font-awesome-rails'

group :development do
	gem 'rubycritic', :require => false
	gem 'traceroute'
	gem 'bullet'
	gem 'rack-mini-profiler'
	gem 'flamegraph' # add '?pp=flamegraph' to any URL to get the flamegraph

	gem 'brakeman', :require => false
	gem 'railroady'
	# gem 'quiet_assets'
	gem 'pry-rails'
	gem 'guard-cucumber'
	gem 'guard-rspec'
	gem 'zeus'
	gem 'guard-zeus'
end

group :test do
 	# gem 'deadweight', :require => 'deadweight/hijack/rails' # check for unused CSS
	# gem 'colored'
	gem 'cucumber'
	gem 'faker'
	gem 'capybara'
	gem 'launchy'
	gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'codeclimate-test-reporter', require: nil
end

group :development, :test do
	gem 'database_cleaner'
	gem 'awesome_print'
	gem 'colorize'
	gem 'web-console', '~> 2.0'
	gem 'byebug'
	gem 'spring'
end

group :doc do
  gem 'sdoc', require: false
end
