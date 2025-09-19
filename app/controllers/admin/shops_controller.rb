class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: [:show, :approve]

  def index
    @shops = Shop.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def approve
    @shop.update(approved: true)
    # Optionally notify owner
    redirect_to admin_shops_path, notice: "Shop approved."
  end

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end
end
