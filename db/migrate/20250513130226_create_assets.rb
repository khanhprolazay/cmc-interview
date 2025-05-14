class CreateAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :assets do |t|
      t.string :title
      t.text :description
      t.string :file_url
      t.decimal :price, precision: 10, scale: 2
      t.references :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
