class CreateVatConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :vat_conditions do |t|
      t.string :code, null:false, unique: true
      t.string :description

      t.timestamps
    end
  end
end
