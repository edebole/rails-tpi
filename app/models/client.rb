class Client < ApplicationRecord
  belongs_to :vat_condition
  has_many :contact_phone
  has_many :reservations
  has_many :sells

  validates :cuil_cuit, 
      format: { with: /\b(20|23|24|27|30|33|34)(\D)?[0-9]{8}(\D)?[0-9]/ , message: "must contain valid cuit|cuil" },
      presence: true, 
      uniqueness: { case_sensitive: false }, 
      length: {is: 11}

  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: true, 
    presence: true 

  validates :name,
    format: { with: /\A[a-zA-Z.']+(?:\s[a-zA-Z.']+)*\s?\z/, message: "must contain only letters"}, presence: true

  # validate :have_contact?

  # def have_contact?
  #   if self.contact_phone.blank?
  #     errors.add(:phone, ", the client must have at least one phone number")
  #   end
  # end

end
