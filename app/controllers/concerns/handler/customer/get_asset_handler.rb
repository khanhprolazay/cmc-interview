module Handler
  module Customer
    class GetAssetHandler < Base
      def handle(asset_id)
          validate(asset_id)
      end

      def validate(asset_id)
          asset = Asset.find_by(id: asset_id)

          unless current_user.purchased_assets.include?(asset)
              raise Error::CommonError::NotFoundError
          end

          asset
      end
    end
  end
end
