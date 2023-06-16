class ProductsController < ApplicationController

  # GET all (/products)
  def index
    @products = Product.all
  end

  # GET specific (/product/:id)
  def show
    @product = Product.find(params[:id])
  end

end
