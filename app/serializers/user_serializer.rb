class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username
end
