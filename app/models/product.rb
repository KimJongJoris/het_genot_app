class Product < ApplicationRecord
  has_many :orders_products
  has_many :orders, through: :orders_products
  validates :name, presence: true
  validates :price, presence: true
  validates :available_amount, presence: true
end
