class Sell < ApplicationRecord
  has_many :sell_details
  has_many :items, through: :sell_details
  has_many :products, through: :items
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, required: false

  def self.all_for_user(id_user)
    self.where({user_id: id_user})
  end
end
