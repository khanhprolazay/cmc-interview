class AssetPurchase < ApplicationRecord
  belongs_to :asset
  belongs_to :customer, class_name: "User", foreign_key: :customer_id

  validates :asset_id, :customer_id, presence: true
end
