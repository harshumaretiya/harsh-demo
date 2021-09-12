class MerchantsController < ApplicationController
  before_action :set_merchant, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /merchants or /merchants.json
  def index
    @merchants = Merchant.all
  end

  def import
    file = params[:file].read
    data = JSON.parse(file)
    current_user.merchants.import! data, on_duplicate_key_update: [:id]
    redirect_back(fallback_location: root_path, notice: "Merchants details imported from JSON file.")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchant_params
      params.require(:merchant).permit(:users, :first_name, :last_name, :company_name)
    end
end
