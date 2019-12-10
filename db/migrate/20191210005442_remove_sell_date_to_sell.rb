class RemoveSellDateToSell < ActiveRecord::Migration[6.0]
  def change
    remove_columns :sells, :sell_date 
  end
end
