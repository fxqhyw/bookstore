class ReviewDecorator < Draper::Decorator
  delegate_all

  def avatar_letter
    object.user.email[0].capitalize
  end

  def create_date
    object.created_at.strftime('%Y/%m/%d')
  end
end
