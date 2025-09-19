class ProductsController < ApplicationController
  before_action :set_shop, only: [:index, :new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, except: [:index, :show]

  def index
    if @shop
      @products = @shop.products.page(params[:page])
    else
      @products = Product.joins(:shop).merge(Shop.approved).page(params[:page])
    end
  end

  def show
    authorize @product
  end

  def new
    @product = @shop.products.build
    authorize @product
  end

  def create
    @product = @shop.products.build(product_params)
    authorize @product
    if @product.save
      redirect_to shop_product_path(@shop, @product), notice: "Product created."
    else
      render :new
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product.shop ? shop_product_path(@product.shop, @product) : product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    authorize @product
    shop = @product.shop
    @product.destroy
    redirect_to shop_path(shop), notice: "Product removed."
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id]) if params[:shop_id]
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, images: [])
  end
end
