class HomeController < ApplicationController	
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def index
  end

  def create
    image = Cloudinary::Uploader.upload(params["video-blob"], :resource_type => :auto)
    if image["secure_url"].present?
      @video = Video.create(avatar: image["secure_url"]) 
      @video = @video.blank? ? false : @video.avatar
      respond_to do |format|
        format.json { render :json => {:video_url => @video, status: true} }
      end
    else
      render :json => false
    end
  end
end
