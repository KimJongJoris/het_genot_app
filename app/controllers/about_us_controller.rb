class AboutUsController < ApplicationController
  def index
    @orders = Order.all.order(order_date: :asc)
    @orders_products = OrdersProduct.all
  end
end
