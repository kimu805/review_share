class WorksController < ApplicationController
  before_action :set_tmdb_service

  def index
    @popular_movies = tmdb_service.fetch_popular_movies
    @now_playing_movies = tmdb_service.fetch_now_playing_movies
  end

  def show
    movie_id = params[:id]
    @work = tmdb_service.show_movie(movie_id)
  end

  private

  def set_tmdb_service
    tmdb_service = TmdbService.new
  end
end