class WorksController < ApplicationController
  before_action :set_tmdb_service

  def index
    @popular_movies = @tmdb_service.fetch_popular_movies
    @now_playing_movies = @tmdb_service.fetch_now_playing_movies
  end

  def search
    query = params[:query]
    if query.present?
      @movies = @tmdb_service.fetch_search_results(query).order("release_date DESC")
    else
      @movies = []
    end
  end

  def show
    @work = @tmdb_service.fetch_movie_detail(params[:id])
  end

  private

  def set_tmdb_service
    @tmdb_service = TmdbService.new
  end
end