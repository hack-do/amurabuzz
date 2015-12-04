class ImagesController < ApplicationController

  before_action :check_login
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @folders = current_user.pictures.group_by{|i| i.folder}

    respond_to do |format|
      format.html{}
      format.json {render json: @folders.to_json }
    end
  end

  def create
    @picture = current_user.pictures.build
    @picture.folder = params[:folder]
    @picture.image_type = params[:image_type]
    @picture.file = params[:attachment].first

    respond_to do |format|
      if @picture.save
        format.json { render :json => @picture, status: :created }
      else
        format.json { render :json => {:errors => @picture.errors.full_messages} }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.json { render json: @picture, status: :updated}
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @picture.destroy
        format.html { redirect_to client_pictures_path, notice: 'Deleted successfully' }
        format.json { head :no_content }
      else
        format.html { redirect_to client_pictures_path, alert: 'Failed to delete' }
        format.json { head :no_content }
      end
    end
  end

  def get_pictures
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
    @pictures = current_user.pictures.where(matcher)

    respond_to do |format|
      format.html {           }
      format.json {render json: @pictures.collect{|x| JSON.parse(x.json)}}
    end
  end

  private

  def set_picture
    @picture = current_user.pictures.find(params[:id])
  end
end
