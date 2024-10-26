class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to work_path
  end
end
