class RemoveItemsFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_reference :products, :items, null: false, foreign_key: true
  end
end
