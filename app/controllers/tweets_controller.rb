class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
<<<<<<< HEAD
 #before_action :check_login,only: [:new,:create,:index]

 def check_login
  puts"\n\n\n------------Check Login------------\n\n\n"
  if !current_user

    redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
  end 
 end
  # GET /tweets
  # GET /tweets.json
=======
 # before_action :check_login,only: [:new,:create,:index]

 # def check_login
 #  puts"\n\n\n------------Check Login------------\n\n\n"
 #  if !current_user

 #    redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
 #  end 
 # end
 
 
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e
  def index
    puts "\n\nINDEX action\n\n"

   u = []
   u << current_user.id 

<<<<<<< HEAD
   current_user.following.each do |x| 
       u << x.id
   end

   @users = User.where(:id => u)
   @tweets = Tweet.where(:user_id => u).paginate(:per_page => 10,:page => params[:page])

    puts "\n\n\n\nTimeline Tweets\n#{@tweets.inspect}\n\n\n\n\n\n"



   
    #@tweets = @tweets.order("created_at ASC")

=======
   u << current_user.following_ids
   u.compact!

   @tweets = Tweet.where(:user_id => u).paginate(:per_page => 10,:page => params[:page])

    puts "\n\n\n\nTimeline Tweets\n#{@tweets.inspect}\n\n\n\n\n\n"
    #@tweets = @tweets.order("created_at ASC")
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    puts "\n\nSHOW action\n\n"
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new

  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
     puts "\n\nCREATE action\n\n"
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        @msg = "Successfull"
        current_user.tweets << @tweet
        current_user.save
        format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
        format.json { render action: 'index', status: :created, location: @tweet }
        format.js
      else
        @msg = "Unsuccessfull"
        format.html { render action: 'new' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
