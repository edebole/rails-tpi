class ContactPhone < ApplicationRecord
  belongs_to :client
  validates :phone,
    format: { with: /\A[0-9]*\z/, message: "must contain valid phone number"},
    length: { minimum: 8 }, presence:true
end
