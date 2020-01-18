class VideosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :update, :edit, :create, :destroy]
  before_action :set_video, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :user_matches, only: [:edit, :update, :destroy]
  require 'streamio-ffmpeg'

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
    @channel_top = User.includes(:videos).references(:videos).where('videos.id IS NOT NUll').order("RANDOM()").limit(1).first()
    @top_picks = Video.includes(:user).order("RANDOM()").limit(10)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    history = History.new
    history.user = current_user if user_signed_in?
    history.video = @video
    history.save
    @suggestions = Video.includes(:user).where.not(id: params[:id]).order("RANDOM()").limit(10)
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.user = current_user

    respond_to do |format|
      if @video.save
        if @video.clip.attached? && !@video.thumbnail.attached?
          @video.clip.open do |file|
            movie = FFMPEG::Movie.new(file.path)
            thumb_time = (movie.duration / 2).round
            thumb = movie.screenshot("./storage/thumbnails/#{@video.clip.key}_thumb.png", {quality: 3, seek_time: thumb_time, resolution: '600x450'}, preserve_aspect_ratio: :width)
            @video.thumbnail.attach(io: File.open(thumb.path), filename: "#{@video.clip.key}_thumb.png", content_type: "image/png")
          end
        end
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote 
    return @video.unliked_by current_user if (current_user.voted_as_when_voted_for @video) == true 
    @video.liked_by current_user
  end  
  
  def downvote
    return @video.undisliked_by current_user if (current_user.voted_as_when_voted_for @video) == false 
    @video.disliked_by current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :clip, :thumbnail, :search)
    end

    def user_matches
      redirect_to videos_url, notice: "You don't have the permission to view this page." if @video.user != current_user
    end
end
