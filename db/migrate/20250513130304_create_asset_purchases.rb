class CreateAssetPurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :asset_purchases do |t|
      t.references :asset, foreign_key: true
      t.references :customer, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
