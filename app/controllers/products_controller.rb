class ProductsController < ApplicationController

  # GET all (/products)
  def index
    @products = Product.all
  end

  # GET specific (/product/:id)
  def show
    @product = Product.find(params[:id])
  end

  def add_to_basket
    @product = Product.find(params[:id])

    # Check available
    # TODO: Maybe just have "Out of stock" instead of "Add to basket" button on front end
    if @product.available_amount <= 0
      redirect_to products_path, status: :see_other, notice: "We're out of stock! Check back later."
    else
      # Get or make basket
      if session[:basket].nil?
        session[:basket] = {}
      end

      # Add to basket
      if session[:basket][@product.id].present?
        session[:basket][@product.id] += 1
      else
        session[:basket][@product.id] = 1
      end

      # TODO: Make basket visible in application layout
      if @product.update(available_amount: @product.available_amount-1)
        redirect_to products_path, status: :see_other, success: "Product added to basket!"
      else
        redirect_to products_path, status: :see_other, notice: "Failed to add product to basket."
      end
    end

  end

end
