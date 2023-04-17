class Contact < ApplicationRecord
  validates :email
  validates :phone
  validates :address
  validates :contacted_at
end
