class ClientSerializer < ActiveModel::Serializer
  attributes :id, :cuil_cuit, :email, :name
  has_one :vat_condition
end
