require 'rails_helper'

RSpec.describe 'Blog app', type: :feature do
  describe 'User post index page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', photo: '', bio: 'this is the bio', created_at: Time.now,
                            confirmed_at: Time.now, email: 'user1@gmail.com', password: '000000', id: 1)
      @post = @user1.posts.create!(title: 'Sample', text: 'lolololo')
      @comment1 = @user1.comments.create!(text: 'comment1', post_id: @post.id)
      @comment2 = @user1.comments.create!(text: 'comment2', post_id: @post.id)
      @like = @user1.likes.create!(post_id: @post.id)
      visit user_posts_path(@user1)
    end

    it 'Should see the user\'s profile picture' do
      image = page.has_selector?('img', count: 1)
      expect(image).to be true
    end

    it 'Should see the user\'s username' do
      expect(page).to have_content(@user1.name)
    end

    it 'Should see the number of posts the user has written' do
      posts = page.all(class: 'singlePot')
      expect(posts.length).to be 1
    end

    it 'Should  see a post\'s title' do
      expect(page).to have_content(@post.title)
      expect(page).to have_content('Sample')
    end

    it 'Should see some of the post\'s body' do
      expect(page).to have_content(@post.text)
      expect(page).to have_content('lolololo')
    end

    it 'Should see the first comments on a post' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content('comment2')
    end

    it 'Should see how many comments a post has' do
      expect(page).to have_content('Comments: 2')
      expect(@post.comments.length).to eq 2
    end

    it 'Should see how many likes a post has' do
      expect(page).to have_content('Likes: 1')
      expect(@post.likes.length).to eq 1
    end

    it 'Should redirects to that post\'s show page.' do
      click_link 'Sample'
      expect(page).to have_current_path(user_post_path(@user1, @post))
    end
  end
end
