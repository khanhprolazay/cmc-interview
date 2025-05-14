class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :iam_id
      t.string :name
      t.string :email
      t.timestamps
    end

    add_index :users, :iam_id
  end
end
