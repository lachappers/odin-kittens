# require 'flickr'
class KittensController < ApplicationController

  before_action :require_login, only: :show


  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Great! Your kitten has been created!"
      redirect_to @kitten
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      # @kitten.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kittens }
      format.json { render :json => @kittens }
    end
    @photos = flickr_setup
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kitten }
      format.json { render :json => @kitten }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      redirect_to @kitten
    else
      flash.now[:error] = @kitten.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    redirect_to root_path, status: :see_other
  end

  require 'flickr'

  def flickr_setup

  
    # flickr = Flickr.new
    flickr = Flickr.new(ENV['flickr_key'], ENV['flickr_secret']) 
    @photos = []
     if params[:flickr_user_id]
        begin
          @photos = flickr.people.getPublicPhotos(user_id: params[:flickr_user_id])
        rescue Flickr::FailedResponse
          flash[:alert] = 'User not found'
          @photos = flickr.photos.search(tags: 'kitten', per_page: 10)
          
        end
      else
        @photos = flickr.photos.search( tags: 'kitten', per_page: 10)
    end
  end


  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      head :bad_request

      # redirect_to kittens_path
    end
  end

  def logged_in?
    # true
    false
  end
end
