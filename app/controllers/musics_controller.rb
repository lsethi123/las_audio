class MusicsController < ApplicationController
    # GET /musics
    # GET /musics.json
    #require 'taglib'
    require "audioinfo"
    def index
        @musics = Music.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @musics }
        end
    end

    # GET /musics/1
    # GET /musics/1.json
    def show
        @music = Music.find(params[:id])
        @tag_data_hash=tag_info("public#{@music.audio.to_s}")

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @music }
        end
    end

    # GET /musics/new
    # GET /musics/new.json
    def new
        @music = Music.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @music }
        end
    end

    # GET /musics/1/edit
    def edit
        #@music = Music.find(params[:id])
    end

    # POST /musics
    # POST /musics.json
    def create
        if !params["music"].nil?
            @music = Music.new(params[:music])
            @music.name=params["music"]["audio"].original_filename
            @music.size=params["music"]["audio"].size
            @music.content_type=params["music"]["audio"].content_type
        else
            raise "Please Choose file to upload"
        end
        respond_to do |format|
            if @music.save
                format.html { redirect_to @music, notice: 'Music was successfully created.' }
                format.json { render json: @music, status: :created, location: @music }
            else
                format.html { render action: "new" }
                format.json { render json: @music.errors, status: :unprocessable_entity }
            end
        end
    end

  # PUT /musics/1
  # PUT /musics/1.json
  def update
    #@music = Music.find(params[:id])
  end

    # DELETE /musics/1
    # DELETE /musics/1.json
    def destroy
        @music = Music.find(params[:id])
        @music.destroy
        respond_to do |format|
            format.html { redirect_to musics_url }
            format.json { head :no_content }
        end
    end
    ### function is used to show the tag details
    def tag_info(file_path)
        tag_hash={}
        AudioInfo.open(file_path) do |info|
            tag_hash[:artist]=info.artist
            tag_hash[:album]=info.album
            tag_hash[:title]=info.title
            tag_hash[:tracknum]=info.tracknum
            tag_hash[:bitrate]=info.bitrate
            tag_hash[:length]=info.length
            if info.info.class==Mp3Info
                tag_hash[:comments]=info.info.tag1.comments
                tag_hash[:samplerate]=info.info.samplerate
                tag_hash[:year]=info.info.tag2.TYER
            elsif info.info.class==MP4Info
                tag_hash[:genere]=info.info.GNRE
                tag_hash[:samplerate]=info.info.FREQUENCY
                tag_hash[:comment]=info.info.CMT
            end
        end
        return tag_hash
    end
end