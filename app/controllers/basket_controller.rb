class BasketController < ApplicationController

  before_action :get_basket_data

  def index; end

  def place_order
    order = Order.new(order_date: Time.zone.now, user: current_user)

    total_price = 0
    @basket_data.each do |object|
      total_price += (object[:product].price * object[:quantity])
      OrdersProduct.create!(order: order, product: object[:product], quantity: object[:quantity])
    end
    order.total_price = total_price

    if order.save
      session[:basket] = {} # Unset basket
      flash[:success] = "You have successfully placed your order for €#{total_price.to_f.round(2)}"
      redirect_to products_path
    else
      flash[:notice] = "Something went wrong!"
      Rails.logger.error order.errors.full_messages
      render :index, status: :unprocessable_entity
    end

  end

  private
  def get_basket_data
    @basket = session[:basket]

    unless @basket.blank?
      @basket_data = []
      @basket.each do |product_id, quantity|
        @basket_data << { product: Product.find(product_id), quantity: quantity }
      end
    end
  end

end
