module Handler
  module Customer
    class ListAssetsHandler < Base
      def handle
         Asset.all
      end
    end
  end
end
