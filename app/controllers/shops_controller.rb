class ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @shops = Shop.approved.page(params[:page])
  end

  def show
    authorize @shop
    # show only if approved or current owner/admin
    if !@shop.approved? && !(current_user && (current_user.admin? || current_user == @shop.user))
      redirect_to shops_path, alert: "Shop not available"
    end
    @products = @shop.products.page(params[:page])
  end

  def new
    @shop = current_user.shops.build
    authorize @shop
  end

  def create
    @shop = current_user.shops.build(shop_params)
    authorize @shop
    if @shop.save
      redirect_to @shop, notice: "Shop created and awaiting admin approval."
    else
      render :new
    end
  end

  def edit
    authorize @shop
  end

  def update
    authorize @shop
    if @shop.update(shop_params)
      redirect_to @shop, notice: "Shop updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @shop
    @shop.destroy
    redirect_to shops_path, notice: "Shop deleted."
  end

  private

  def set_shop
    @shop = Shop.find_by(id: params[:id]) || Shop.find_by!(slug: params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :description, :logo)
  end
end
