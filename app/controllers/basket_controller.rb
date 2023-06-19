class BasketController < ApplicationController

  def index
    @basket = session[:basket]

    unless @basket.blank?
      @basket_data = []
      @basket.each do |product_id, quantity|
        @basket_data << { product: Product.find(product_id), quantity: quantity }
      end
    end
  end

end
