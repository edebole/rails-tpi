class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password, :token, :token_created_at
end
