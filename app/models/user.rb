class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, on: :create
  has_many :restaurants
  has_many :orders
  before_save :ensure_authentication_token
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  after_create :send_welcome_email


 def send_welcome_email
    if User.last.restaurant_owner == false
    UserMailer.welcome(self).deliver_now
    else
    UserMailer.welcome_partner(self).deliver_now
    end
 end


  def full_address
    "#{street}, #{postal_code} #{locality}"
  end

  def full_address_changed?
    street_changed? || postal_code_changed? || locality_changed?
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.token = auth.credentials.token
      user.restaurant_owner = false
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end


#   def ensure_authentication_token
#     if authentication_token.blank?
#       self.authentication_token = generate_authentication_token
#     end
#   end

# private

#   def generate_authentication_token
#     loop do
#       token = Devise.friendly_token
#       break token unless User.where(authentication_token: token).first
#     end
#   end





end
