class Item < ApplicationRecord
  belongs_to :product
  after_initialize :init

  def init
    self.state ||= 'Disponible'
  end
end
