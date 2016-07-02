class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_one :identities, dependent: :destroy
  has_many :messages
  has_many :chatrooms, through: :messages

  validates :username, presence: true

  TEMP_EMAIL_PREFIX = 'change@me'.freeze
  TEMP_EMAIL_REGEX = /\Achange@me/

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email if auth.info.email.present?
      user = User.where(email: email).first if email

      if user.nil?
        user = create_user_from_auth(auth)
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  private

  def self.create_user_from_auth(auth)
    user = User.new(
      name: auth.extra.raw_info.name,
      username: auth.info.nickname || auth.extra.raw_info.name,
      email: auth.info.email,
      image: auth.info.image,
      password: Devise.friendly_token[0, 20]
    )
    user.save!
    user
  end
end
