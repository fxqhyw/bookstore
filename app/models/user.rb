class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:facebook]
  validates_uniqueness_of :uid, unless: proc { provider.nil? }, scope: :provider

  def self.new_with_session(params, session)
    session_fb_data = session['devise.facebook_data']
    super.tap do |user|
      if data = session_fb_data && session_fb_data['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
