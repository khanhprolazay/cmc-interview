class Asset < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :purchases, class_name: "AssetPurchase", foreign_key: :asset_id, dependent: :destroy
  has_many :customers, through: :purchases, source: :customer

  validates :title, :description, :file_url, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def self.total_earnings_for_creator(creator)
    where(creator_id: creator.id).sum(:price)
  end
end
