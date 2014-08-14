require 'rails_helper'

RSpec.describe "Things", :type => :request do
  describe "GET /things" do
    it "works! (now write some real specs)" do
      get things_path
      expect(response.status).to be(200)
    end
  end
end
