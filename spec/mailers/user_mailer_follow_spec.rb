require "rails_helper"

RSpec.describe FollowMailer, :type => :mailer do
 # pending "add some examples to (or delete) #{__FILE__}"

let(:user) { FactoryGirl.build(:user)}
let(:follower) {FactoryGirl.build(:user)}
let(:mail) { FollowMailer.new_follower(user.email,follower) }
 	
 	it "sends an email" do
    expect { FollowMailer.new_follower(user.email,follower).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

    it 'renders the subject' do
      expect(mail.subject).to eql("New Follower #{follower.user_name}")
    end
 
    it 'renders the receiver email id' do
      expect(mail.to).to eql([follower.email])
    end
 
    it 'renders the sender email id' do
      expect(mail.from).to eql(["amurabuzz@gmail.com"])
    end
end
