module Handler
  module Customer
    class ListPurchasedAssetsHandler < Base
      def handle
        current_user.purchased_assets
      end
    end
  end
end
