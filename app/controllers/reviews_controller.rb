class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    return redirect_to @review.book, notice: I18n.t('review.thanks_message') if @review.save

    redirect_to @review.book, alert: I18n.t('review.incorrect')
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :user_id, :title, :description, :rating)
  end
end
