require 'rails_helper'

RSpec.describe 'Blog app', type: :feature do
  describe 'User show page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', photo: '', bio: 'bio', created_at: Time.now,
                            confirmed_at: Time.now, email: 'user1@gmail.com', password: '785944', id: 1)
      @post = @user1.posts.create!(title: 'Sample', text: 'lolololo')
      visit user_path(@user1)
    end

    it 'Should see the user\'s profile picture' do
      images = page.has_selector?('img', count: 1)
      expect(images).to be true
    end

    it 'Should see the username of the user' do
      expect(page).to have_content(@user1.name)
    end

    it "Should see each user's post number" do
      number_posts = page.all('ul li')
      expect(number_posts[2]).to have_content('Post:1')
    end

    it "Should see the user's bio" do
      bio = page.has_selector?('p', text: 'bio')
      expect(bio).to be true
    end

    it 'Should  the user\'s first three posts' do
      posts = page.all(class: 'li--post')
      expect(posts.length).to be < 4
    end

    it 'Should redirects to that post\'s show page.' do
      click_link 'Sample'
      expect(page).to have_current_path(user_post_path(@user1, @post))
    end
  end
end
