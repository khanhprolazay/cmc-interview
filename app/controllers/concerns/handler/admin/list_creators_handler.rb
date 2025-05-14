module Handler
  module Admin
    class ListCreatorsHandler < Base
      def handle
          AssetPurchase
          .joins(asset: :creator)
          .group("users.id")
          .select("users.id AS creator_id, users.name AS creator_name, SUM(assets.price) AS total_earnings")
      end
    end
  end
end
