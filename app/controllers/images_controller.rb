class ImagesController < ApplicationController

  before_action :check_login
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @folders = current_user.images.group_by{|i| i.folder}

    respond_to do |format|
      format.html{}
      format.json {render json: @folders.to_json }
    end
  end

  def create
    @image = current_user.images.build
    @image.folder = params[:folder]
    @image.image_type = params[:image_type]
    @image.tweet_id = params[:tweet_id]
    @image.file = params[:attachment].first

    respond_to do |format|
      if @image.save
        format.json { render :json => @image, status: :created }
      else
        format.json { render :json => {:errors => @image.errors.full_messages} }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.json { render json: @image, status: :updated}
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @image.destroy
        format.html { redirect_to client_images_path, notice: 'Deleted successfully' }
        format.json { head :no_content }
      else
        format.html { redirect_to client_images_path, alert: 'Failed to delete' }
        format.json { head :no_content }
      end
    end
  end

  def get_images
    matcher = {}
    if params[:folder].present?
      if params[:folder] == "Documents"
        matcher["$or"] = [{folder:"Documents"},{folder: nil}]
      else
        matcher[:folder] =  params[:folder]
      end
    end

    if params[:type].present?
      matcher[:content_type] =  Regexp.new(params[:type])
    end
    if params[:term].present?
      matcher[:name] = Regexp.new(params[:term], "i")
    end
    @images = current_user.images.where(matcher)

    respond_to do |format|
      format.html {           }
      format.json {render json: @images.collect{|x| JSON.parse(x.json)}}
    end
  end

  private

  def set_image
    @image = current_user.images.find(params[:id])
  end
end
