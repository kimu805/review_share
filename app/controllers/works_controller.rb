class WorksController < ApplicationController
  before_action :set_tmdb_service

  def index
    @popular_movies = @tmdb_service.fetch_popular_movies
    @now_playing_movies = @tmdb_service.fetch_now_playing_movies
  end

  def search
    query = params[:query]
    if query.present?
      @movies = @tmdb_service.fetch_search_results(query).map do |movie|
        credits = @tmdb_service.fetch_credits(movie[:api_id])
        movie.merge(credits)
      end
    else
      @movies = []
    end
  end

  def show
    @api_id = params[:id]
    @work = @tmdb_service.fetch_movie_detail(@api_id)
    @reviews = Review.where(api_id: @api_id)
  end

  private

  def set_tmdb_service
    @tmdb_service = TmdbService.new
  end
end