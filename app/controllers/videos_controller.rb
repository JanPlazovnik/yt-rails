class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  require 'streamio-ffmpeg'
  # before_action :authenticate_user!

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
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
    
    respond_to do |format|
      if @video.save
        if @video.clip.attached? && !@video.thumbnail.attached?
          @video.clip.open do |file|
            movie = FFMPEG::Movie.new(file.path)
            thumb = movie.screenshot("./storage/thumbnails/#{@video.clip.key}_thumb.png", {quality: 3, seek_time: 5, resolution: '240x120'}, preserve_aspect_ratio: :width)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :clip, :thumbnail)
    end
end
