class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :restaurants
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
