class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :cuil_cuit
      t.string :email
      t.string :name
      t.references :vat_condition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
