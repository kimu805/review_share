class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @api_id = params[:work_id]
    @review = Review.new(review_params)
    if @review.save
      redirect_to work_path(@api_id), notice: "レビューの保存に成功しました。"
    else
      redirect_to work_path(@api_id), alert: "レビューの投稿に失敗しました。"
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment, :spoiler).merge(user_id: current_user.id, api_id: @api_id)
  end
end