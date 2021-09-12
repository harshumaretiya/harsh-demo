# frozen_string_literal: true

class Api::V1::MerchantsController < Api::V1::AuthenticatedController
  before_action :set_merchant, only: %i[ show edit update destroy ]

  # GET  /api/v1/merchants
  def index
    begin
      merchants = @current_user.
                merchants.
                order('created_at DESC').
                paginate(page: params[:page], per_page: 10) 
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(MerchantSerializer.new(merchants).serializable_hash[:data].map {|merchant| merchant[:attributes]},MetaGenerator.new.generate!(merchants))
  end

  def import
    begin
      file = params[:file].read
      data = JSON.parse(file)
      current_user.merchants.import! data, on_duplicate_key_update: [:id]
      merchant_list = @current_user.merchants.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(MerchantSerializer.new(merchant_list).serializable_hash[:data].map {|merchant| merchant[:attributes]},MetaGenerator.new.generate!(merchant_list))    
  end

  #POST /api/v1/merchants
  def create
    begin
      merchant = @current_user.merchants.create!(merchant_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(MerchantSerializer.new(merchant).serializable_hash[:data][:attributes])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchant_params
      params.require(:merchant).permit(:users, :first_name, :last_name, :company_name, :file)
    end
end
