class WorksController < ApplicationController
  before_action :set_work, only: [:edit, :update, :show, :destroy]

  def index
    tmdb_service = TmdbService.new

    @popular_moview = tmdb_service.fetch_popular_movies
    @now_playing_movies = tmdb_service.fetch_now_playing_movies
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def show
  end

  def import_from_tmdb
    tmdb_service = TmdbService.new
    movie_data = tmdb_service.fetch_movie(params[:tmdb_id])
    if movie_data
      @work = Work.new(movie_data)
      if @work.save
        redirect_to @work, notice: "映画情報が取り込まれました。"
      else
        render :new, alert: "保存に失敗しました。"
      end
    else
      redirect_to works_path, alert: "映画情報の取得に失敗しました。"
    end
  end

  private

  def set_work
    @work = Work.find(params[:id])
  end
end
