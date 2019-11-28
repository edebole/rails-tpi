class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :unique_code, null: false, unique: true
      t.string :description
      t.text :detail
      t.decimal :unit_price, null: false
      t.references :items, null: false, foreign_key: true

      t.timestamps
    end
  end
end
