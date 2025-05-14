module Api
  class AssetsController < ApplicationController
    require_role role: Role::CREATOR, actions: [ :bulk_import ]
    require_role role: Role::CUSTOMER, actions: [ :bulk_purchase, :show, :available, :purchased ]
    skip_before_action :authenticate, only: [ :index ]

    def index
      handler = Handler::Customer::ListAssetsHandler.new(@user)
      @models = handler.handle
      render "assets/list"
    end

    def available
      handler = Handler::Customer::ListAvailableAssetsHandler.new(@user)
      @models = handler.handle
      render "assets/list"
    end

    def purchased
      handler = Handler::Customer::ListPurchasedAssetsHandler.new(@user)
      @models = handler.handle
      render "assets/list"
    end

    def show
      handler = Handler::Customer::GetAssetHandler.new(@user)
      @model = handler.handle(params[:id])
      render "assets/one"
    end

    def bulk_purchase
      request_data = JSON.parse(request.body.read)
      puts(request_data)
      handler = Handler::Customer::BulkPurchaseHandler.new(@user)
      handler.handle(request_data["asset_ids"])
    end

    def bulk_import
      handler = Handler::Creator::BulkImportHandler.new(@user)
      handler.handle(params[:file])
    end
  end
end
