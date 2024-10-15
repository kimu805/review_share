class WorksController < ApplicationController
  before_action :set_work, only: [:edit, :update, :show, :destroy]

  def index
    tmdb_service = TmdbService.new

    @popular_movies = tmdb_service.fetch_popular_movies
    @now_playing_movies = tmdb_service.fetch_now_playing_movies
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def show
  end

  private

  def set_work
    @work = Work.find(params[:id])
  end
end
