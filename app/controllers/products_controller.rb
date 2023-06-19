class ProductsController < ApplicationController

  # GET all (/products)
  def index
    @products = Product.all
  end

  # GET specific (/product/:id)
  def show
    @product = Product.find(params[:id])
  end

  def reduce_from_basket
    @product = Product.find(params[:id])

    return if session[:basket].nil?

    if session[:basket][@product.id.to_s] == 1
      session[:basket].delete(@product.id.to_s)
    else
      session[:basket][@product.id.to_s] -= 1
    end

    if @product.update(available_amount: @product.available_amount+1)
      redirect_to basket_index_path, status: :see_other, success: "Product reduced from basket!"
    else
      redirect_to basket_index_path, status: :see_other, notice: "Failed to remove product from basket."
    end
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
      if session[:basket][@product.id.to_s].present?
        session[:basket][@product.id.to_s] += 1
      else
        session[:basket][@product.id.to_s] = 1
      end

      if @product.update(available_amount: @product.available_amount-1)
        redirect_to products_path, status: :see_other, success: "Product added to basket!"
      else
        redirect_to products_path, status: :see_other, notice: "Failed to add product to basket."
      end
    end

  end

end
