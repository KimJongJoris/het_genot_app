class BasketController < ApplicationController

  before_action :get_basket_data

  def index; end

  def place_order
    order = Order.new(order_date: Time.zone.now, user: current_user)

    @basket_data.each do |object|
      OrdersProduct.create!(order: order, product: object[:product], quantity: object[:quantity])
    end
    order.total_price = @total_price

    if order.save
      session[:basket] = {} # Unset basket
      flash[:success] = "You have successfully placed your order for €#{@total_price.to_f.round(2)}"
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
    @total_price = 0

    unless @basket.blank?
      @basket_data = []
      @basket.each do |product_id, quantity|
        product = Product.find(product_id)
        @basket_data << { product: product, quantity: quantity }
        @total_price += product.price * quantity
      end
    end
  end

end
