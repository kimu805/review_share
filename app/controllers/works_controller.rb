class WorksController < ApplicationController
  before_action :set_tmdb_service

  def index
    @popular_movies = @tmdb_service.fetch_popular_movies.limit(5)
    @now_playing_movies = @tmdb_service.fetch_now_playing_movies.limit(5)
  end

  def show
    @work = @tmdb_service.fetch_movie_detail(params[:id])
  end

  private

  def set_tmdb_service
    @tmdb_service = TmdbService.new
  end
end