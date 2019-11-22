class CreateContactPhones < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_phones do |t|
      t.string :phone
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
