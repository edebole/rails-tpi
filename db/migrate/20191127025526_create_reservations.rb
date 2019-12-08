class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :sell, null: true, foreign_key: true
      t.datetime :reservation_date

      t.timestamps
    end
  end
end
