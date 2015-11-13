class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :phone_number, numericality: true, length:{ is: 10 }

  has_many :restaurants
  has_many :orders

  # has_attached_file :picture,
  #   styles: { medium: "300x300>", thumb: "100x100>" }
  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
  # validates_attachment_content_type :picture,
  #   content_type: /\Aimage\/.*\z/


end
