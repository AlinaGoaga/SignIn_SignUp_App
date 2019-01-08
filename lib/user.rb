require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, unique: true, messages: {
    is_unique: 'Sorry, that email address is taken'
  }
  property :password, BCryptHash

  def self.authenticate(email, password)
    user = first(email: email)
    return nil unless user
    user if user.password == password
  end
end
