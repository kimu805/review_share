class WorksController < ApplicationController

  def index
    tmdb_service = TmdbService.new

    @popular_movies = tmdb_service.fetch_popular_movies
    @now_playing_movies = tmdb_service.fetch_now_playing_movies
  end

  def show
    movie_id = params[:id]
    
  end

end
