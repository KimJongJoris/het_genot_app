class Contact < ApplicationRecord
  validates :email, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :contacted_at, presence: true
end
