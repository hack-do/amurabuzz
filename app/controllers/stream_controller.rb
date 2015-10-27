class StreamController < ApplicationController
  include ActionController::Live

  def index
  	# @redis = Redis.new
  	# @redis.publish "sse", "#{rand(100)}"
  end

  def init
    puts "response : #{response}"
    begin
	    response.headers['Content-Type'] = 'text/event-stream'
	  	@redis = Redis.new

	    @redis.subscribe "sse" do |on|
        puts "Subscribe to Redis channel"
        on.message do |channel, message|
  	      response.stream.write "data:#{message}\n\n"
		      puts "message sent -> #{message}"
	      end
      end
	  ensure
	    response.stream.close
	  end
	end

end
