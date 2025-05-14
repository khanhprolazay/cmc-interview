module Handler
    module Customer
        class BulkPurchaseHandler < Base
            def handle(asset_ids)
                assets = validate(asset_ids)
                if assets.count != asset_ids.count
                    raise Error::CommonError::NotFoundError
                end

                ActiveRecord::Base.transaction do
                    assets.each do |asset|
                        if not current_user.purchased_assets.include?(asset)
                            AssetPurchase.create!(asset: asset, customer: current_user)
                        end
                    end
                end
            end

            def validate(asset_ids)
                if asset_ids.blank? || !asset_ids.is_a?(Array)
                    raise Error::CommonError::BadRequestError
                end

                assets = Asset.where(id: asset_ids)
                if assets.count != asset_ids.count
                    raise Error::CommonError::NotFoundError
                end

                assets
            end
        end
    end
end
