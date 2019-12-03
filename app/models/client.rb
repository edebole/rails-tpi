class Client < ApplicationRecord
  belongs_to :vat_condition
  has_many :contact_phone, inverse_of: :client
  has_many :reservations
  has_many :sells
end
