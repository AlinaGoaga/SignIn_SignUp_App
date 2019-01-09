RSpec.feature 'User Authentication' do
  context 'Sign Up' do
    scenario 'A user can signup' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign up'

      expect(page).to have_content 'Welcome, test@test.com'
    end
    scenario 'A user can not sign up twice with the same email' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign up'
      click_button 'Log out'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign up'
      expect(page).to have_content 'Sorry, that email address is taken'
    end
    scenario 'A user can not use a password that is shorter than 6 characters' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'sec'
      click_button 'Sign up'
      expect(page).to have_content 'Your password needs to have at least 6 characters. Please try again.'
    end
  end

  context 'Sign in/out' do
    let!(:user) { User.create(email: 'test@test.com', password: 'secret123') }

    scenario 'A user can signin' do
      visit '/'
      click_on 'Sign in'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'

      expect(page).to have_content 'Welcome, test@test.com'
    end

    scenario 'A signed in user can log out' do
      visit '/signin'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'
      click_button 'Log out'

      expect(page.current_path).to eq '/'
      expect(page).to have_content 'Sign up'
      expect(page).to have_content 'Sign in'
    end
  end
end
