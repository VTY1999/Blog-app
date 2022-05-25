require 'rails_helper'

RSpec.describe 'Blog app', type: :feature do
  describe 'Post show page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', photo: '', bio: '', posts_counter: 3, created_at: Time.now,
                            confirmed_at: Time.now, email: 'user1@gmail.com', password: '677854')
      @user2 = User.create!(name: 'User2', photo: '', bio: '', created_at: Time.now,
                            confirmed_at: Time.now, email: 'user2@gmail.com', password: '456787')
      @post = @user1.posts.create!(title: 'Sample', text: 'Hello')
      @comment1 = @user1.comments.create!(text: 'comment1', post_id: @post.id)
      @comment2 = @user1.comments.create!(text: 'comment2', post_id: @post.id)
      @comment3 = @user1.comments.create!(text: 'comment3', post_id: @post.id)
      @comment4 = @user2.comments.create!(text: 'comment4', post_id: @post.id)
      @like = @user1.likes.create!(post_id: @post.id)
      visit user_post_path(@user1, @post)
    end

    it 'Should  see the post\'s title' do
      expect(page).to have_content(@post.title)
      expect(page).to have_content('Sample')
    end

    it 'Should  see who wrote the post' do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content('User1')
    end

    it 'Should see how many comments a post has' do
      expect(page).to have_content('Comments: 4')
      expect(@post.comments.length).to eq 4
    end

    it 'Should see how many likes a post has' do
      expect(page).to have_content('Likes: 1')
      expect(@post.likes.length).to eq 1
    end

    it 'Should see some of the post\'s body' do
      expect(page).to have_content(@post.text)
      expect(page).to have_content('Hello')
    end

    it 'Should see the username of each commentor' do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it 'Should see the comment each commentor left' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@user1.comments[1].text)
      expect(page).to have_content('comment3')
    end
  end
end
