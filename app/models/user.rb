class User < ApplicationRecord
    has_many :assets, foreign_key: :creator_id, dependent: :destroy
    has_many :purchases, class_name: "AssetPurchase", foreign_key: :customer_id, dependent: :destroy
    has_many :purchased_assets, through: :purchases, source: :asset

    validates :iam_id, :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
end
