class CreateReservationDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :reservation_details do |t|
      t.references :item, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
