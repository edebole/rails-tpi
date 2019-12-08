class Client < ApplicationRecord
  belongs_to :vat_condition
  has_many :contact_phone, inverse_of: :client
  has_many :reservations
  has_many :sells

  validates :cuil_cuit, 
      format: { with: /\b(20|23|24|27|30|33|34)(\D)?[0-9]{8}(\D)?[0-9]/ ,
                message: "must contain valid cuit|cuil"},
      presence: true, 
      uniqueness: true, 
      length: {is: 11}

  validates :mail,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    presence: true
    
  validates :name,
    format: { with: /\A[a-zA-Z\s]*\z/, message: "must contain only letters"}
    
end
