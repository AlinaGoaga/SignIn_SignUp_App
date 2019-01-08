require 'user'

RSpec.describe 'User' do
  let (:user) { User.create(email: 'test@test.com', password: 'secret123') }

  describe '#authenticate' do
    it 'returns nil if the user doesnt exist' do
      expect(User.authenticate('bla@test.com', 'secret124')).to eq nil
    end
    it 'returns nil if the user exists but the password is incorrect' do
      expect(User.authenticate('test@test.com', 'secret124')).to eq nil
    end
  end
end
