class AboutUsController < ApplicationController
  def index
    @orders = Order.all
    @orders_products = OrdersProduct.all

    @count = 0
    @orders_products.each do |orders_product|
      @count += orders_product.quantity
    end

    @most_popular_product = Product.joins(:orders_products).order('orders_products.quantity').first
  end
end
