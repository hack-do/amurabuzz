require 'elasticsearch'

class SearchController < ApplicationController
	before_action :check_login

	def index
		client = Elasticsearch::Client.new log: true
		client.transport.reload_connections!
		client.cluster.health
		client.search q: 'test'

    respond_to do |format|
      format.html {}
      format.json { render json: {} }
      format.js {}
    end
	end

	def perform
	end
end


