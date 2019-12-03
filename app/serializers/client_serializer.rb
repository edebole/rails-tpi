class ClientSerializer < ActiveModel::Serializer
  attributes :id, :cuil_cuit, :email, :name
  has_one :vat_condition
  has_many :contact_phone
  has_many :reservations
  has_many :sells
end
