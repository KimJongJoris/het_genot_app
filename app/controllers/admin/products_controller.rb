class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, status: :see_other, success: "Product successfully created."
    else
      render :new, status: :unprocessable_entity, notice: "Failed to create Product."
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path, status: :see_other, success: "Product successfully updated."
    else
      render :edit, status: :unprocessable_entity, notice: "Failed to update Product."
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :available_amount)
  end

end
