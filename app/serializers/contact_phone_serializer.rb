class ContactPhoneSerializer < ActiveModel::Serializer
  attributes :id, :phone
  has_one :client
end
