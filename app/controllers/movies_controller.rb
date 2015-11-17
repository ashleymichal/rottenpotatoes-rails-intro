class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :sort_by)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @ratings = Movie.all_ratings
    # debugger
    # @selected_ratings = params[:ratings].nil? ? session[:ratings] || @all_ratings : params[:ratings].keys
    @sort = params[:sort] || session[:sort]
    session[:sort] = @sort
    @movies = Movie.where(rating: @ratings.select { |rating, checked| checked == true }.keys).order(@sort)
  end
  
  def sort
  end
  
  def ratings
    ratings = params[:ratings].keys
    # debugger
    Movie.all_ratings= ratings
    redirect_to movies_path
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
