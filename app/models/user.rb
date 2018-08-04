class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_one :cart, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:facebook]
  validates_uniqueness_of :uid, scope: :provider

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
