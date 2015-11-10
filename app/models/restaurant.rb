class Restaurant < ActiveRecord::Base
  belongs_to :user

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/


  validates :name, presence: true
  validates :name, uniqueness: true
  validates :category, presence: true
  validates :address, presence: true

  validates :address, uniqueness: true
  validates :locality, presence: true
  validates :postal_code, presence: true

  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :iban, presence: true
  validates :picture, presence: true


end
