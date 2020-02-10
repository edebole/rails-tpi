class VatCondition < ApplicationRecord
  has_many :clients
  validates_presence_of :description
end
