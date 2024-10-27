class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to work_path(params[:api_id]), notice: "レビューの保存に成功しました。"
    else
      redirect_to work_path(params[:api_id]), alert: "レビューの投稿に失敗しました。"
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment, :spoiler)
  end
  def set_work
    @tmdb_service = TmdbService.new
    @work = @tmdb_service.fetch_movie_detail(params[:id])
  end
end
