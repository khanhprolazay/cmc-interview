module Handler
  module Creator
    class BulkImportHandler < Base
      def handle(file)
        assets_data = validate(file)
        created_assets = []
        begin
          ActiveRecord::Base.transaction do
            assets_data.each do |asset_data|
              asset_params = ActionController::Parameters.new(asset_data).permit(:title, :description, :file_url, :price)

              asset = current_user.assets.new(asset_params)

              if asset.save
                created_assets << asset
              else
                raise ActiveRecord::Rollback
              end
            end
          end
        rescue ActiveRecord::Rollback
          raise Error::CommonError::TransactionError
        end
      end

      def validate(file)
        if file.nil?
          raise Error::CommonError::InvalidParamsError
        end

        begin
          file_content = file.read
          JSON.parse(file_content)
        rescue JSON::ParserError
          raise Error::CommonError::BadRequest
        end
      end
    end
  end
end
