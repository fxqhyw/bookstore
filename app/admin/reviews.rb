ActiveAdmin.register Review do
  actions :index, :show

  users = proc { User.pluck(:email, :id) }

  scope :all do |reviews|
    reviews.all
  end

  scope :new, default: true do |reviews|
    reviews.where(status: :unprocessed)
  end

  scope :processed do |reviews|
    reviews.where.not(status: :unprocessed)
  end

  filter :user, collection: users
  filter :book
  filter :rating

  index do
    column :title
    column(I18n.t('admin.book')) { |review| review.book.title }
    column(I18n.t('admin.user')) { |review| review.user.email }
    column :status
    column :created_at
    column { |review| link_to I18n.t('admin.show'), admin_review_path(review), method: :get }
  end

  show do
    panel I18n.t('admin.actions') do
      span { link_to I18n.t('admin.approve'), approve_admin_review_path(review), method: :put }
      span { link_to I18n.t('admin.reject'), reject_admin_review_path(review), method: :put }
      span { link_to I18n.t('admin.unprocess'), unprocess_admin_review_path(review), method: :put }
    end
    default_main_content
  end

  member_action :approve, method: :put do
    Review.find(params[:id]).approve!
    redirect_back(fallback_location: admin_reviews_path, notice: I18n.t('admin.approved'))
  end

  member_action :reject, method: :put do
    Review.find(params[:id]).reject!
    redirect_back(fallback_location: admin_reviews_path, notice: I18n.t('admin.rejected'))
  end

  member_action :unprocess, method: :put do
    Review.find(params[:id]).unprocess!
    redirect_back(fallback_location: admin_reviews_path, notice: I18n.t('admin.unprocessed'))
  end
end
