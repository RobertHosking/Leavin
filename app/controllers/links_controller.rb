class LinksController < ApplicationController
  #before_action :set_link, only: [:show, :edit, :update, :destroy]
  
  def go
    @link = Link.find_by_in_url!(params[:in_url])
    redirect_to @link.out_url, :status => @link.http_status
  end
  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])
    flash[:url] = 'http://'+request.domain+"/"+@link.in_url
    if @link.out_url.length > 30
      flash[:destination] = @link.out_url[0..30] + "..."
    else
      flash[:destination] = @link.out_url
    end
    redirect_to :back
  end

  # GET /links/new
  def new
    @link = Link.new
    @num = Link.all.count
    
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    if Link.where(out_url: params[:out_url]).empty?
      @link = Link.new(link_params)
      @link.in_url = Link.all.count.to_s(36)
      
      
      #doc = Pismo::Document.new(@link.out_url)
      #@link.title = doc.title
      @link.out_url = "http://#{@link.out_url}" unless @link.out_url=~/^https?:\/\//
  
      respond_to do |format|
        if @link.save
          format.html { redirect_to @link, notice: 'Link was successfully created.' }
          format.json { render :show, status: :created, location: @link }
        else
          format.html { render :new }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
    
    else
      format.html { redirect_to @link, notice: 'Link already exists.' }
      format.json { render :show, status: :created, location: @link }
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:out_url)
    end
end
