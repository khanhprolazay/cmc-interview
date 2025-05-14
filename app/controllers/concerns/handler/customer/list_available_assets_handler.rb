module Handler
  module Customer
    class ListAvailableAssetsHandler < Base
      def handle
         Asset.left_outer_joins(:purchases)
                  .where.not(creator_id: current_user.id)
                  .where.not(id: current_user.purchased_assets.select(:id))
      end
    end
  end
end
