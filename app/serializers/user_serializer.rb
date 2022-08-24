class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :jti
end
