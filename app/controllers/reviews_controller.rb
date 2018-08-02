class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review.book, notice: I18n.t(review.thanks_message)
    else
      redirect_to @review.book, notice: I18n.t(review.incorrect)
    end
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :title, :description, :rating)
  end
end
