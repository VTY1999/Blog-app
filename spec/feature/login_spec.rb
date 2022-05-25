require 'rails_helper'

RSpec.describe 'Blog app', type: :feature do
  describe 'loging page' do
    it 'Should access the log in page' do
      visit 'users/sign_in'
      expect(page).to have_content('Log in')
    end

    it 'Shoud see the user name, email and pasword field' do
      visit 'users/sign_in'
      expect(page).to have_field('Email', type: 'email')
      expect(page).to have_field('Password', type: 'password')
      expect(page).to have_button('Log in', type: 'submit')
    end

    it 'Raise an error if email or password is not filled' do
      visit 'users/sign_in'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Raise an error if email or password is not filled with the correct data' do
      visit 'users/sign_in'
      fill_in 'Email', with: 'emal@gmail.com'
      fill_in 'Password', with: 'fhdjs'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Should redirect to the root page if email or password is filled with the correct data' do
      user = User.create!(name: 'cole', photo: '', bio: '', posts_counter: 0, created_at: Time.now,
                          confirmed_at: Time.now, email: 'cole@gmail.com', password: '245677')
      visit 'users/sign_in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end
