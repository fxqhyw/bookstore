class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review.book, notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to @review.book, notice: 'Incorrect review format!'
    end
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :title, :description, :rating)
  end
end
