require 'user'

RSpec.describe 'User' do
  describe '#authenticate' do
    it 'returns nil if the user doesnt exist' do
      test_user = User.create(email: 'test@test.com', password: 'secret123')
      expect(User.authenticate('bla@test.com', 'secret124')).to eq nil
    end
    it 'returns nil if the user exists but the password is incorrect' do
      test_user = User.create(email: 'test@test.com', password: 'secret123')
      expect(User.authenticate('test@test.com', 'secret124')).to eq nil
    end
    it 'returns the user if user exists and password is correct' do
      test_user = User.create(email: 'test@test.com', password: 'secret123')
      expect(User.authenticate('test@test.com', 'secret123')).to eq test_user
    end
  end

  describe '#email_validate' do
    it 'raises error if user email already exists' do
      User.create(email: 'test@test.com', password: 'secret123')
      expect(User.create(email: 'test@test.com', password: 'secret123').errors.full_messages.first).to eq 'Sorry, that email address is taken'
    end
  end
end
