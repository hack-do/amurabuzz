require 'database_cleaner'

namespace :db do
  desc "Delete all seed data"
  task :unseed => :environment do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean

		puts "All tables truncated successfully !"
  end
end

