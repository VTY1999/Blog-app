require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'Should not create post if user not provided' do
    post = Post.new(title: 'this is the title', text: 'this is a new post', comments_counter: 0, likes_counter: 0)
    expect(post).to be_invalid
  end

  it 'Should create a post if user provided' do
    post = Post.new(title: 'this is a title', text: 'this is a new post', comments_counter: 0, likes_counter: 0)
    post.build_user(name: 'Marcelo', photo: '', bio: 'football player', posts_counter: 0)
    expect(post).to be_valid
  end

  it 'Should increse posts_counter' do
    user = User.new(name: 'John', photo: '', bio: '', posts_counter: 0)
    expect(user).to be_valid
    Post.create!(title: 'Post 1ere', text: 'this is my post', comments_counter: 0, likes_counter: 0, user:)
    Post.create!(title: 'Second Post', text: 'this is my post', comments_counter: 0, likes_counter: 0, user:)
    Post.create!(title: 'Third Post', text: 'this is my post', comments_counter: 0, likes_counter: 0, user:)
    Post.create!(title: 'Fourth Post', text: 'this is my post', comments_counter: 0, likes_counter: 0, user:)
    expect(user.posts_counter).to eql(4)
  end

  it 'Should return top 5 comments' do
    post = Post.new(title: 'My Post', text: 'this is a post', comments_counter: 0, likes_counter: 0)
    post.build_user(name: 'Michelle', photo: '', bio: '', posts_counter: 0)
    post.save!
    comment_creator = User.new(name: 'Cynthia', photo: '', bio: '', posts_counter: 0)
    expect(comment_creator).to be_valid
    post.comments.create(text: 'this is a comment1', user: comment_creator)
    comment1 = post.comments.create(text: 'this is a comment1', user: comment_creator)
    comment2 = post.comments.create(text: 'this is a comment2', user: comment_creator)
    comment3 = post.comments.create(text: 'this is a comment3', user: comment_creator)
    comment4 = post.comments.create(text: 'this is a comment4', user: comment_creator)
    comment5 = post.comments.create(text: 'this is a comment5', user: comment_creator)

    recent_comments = post.recent_comments
    expect(recent_comments.length).to eql(5)
    expect(recent_comments).to match_array([comment1, comment2, comment3, comment4, comment5])
  end

  describe 'For the Post model' do
    before(:each) do
      @user = User.new(name: 'XXX', photo: 'XXXX', bio: 'XXXXXX')
      @post = Post.new(user: @user, title: 'XXXX', text: 'XXXXXXX')
    end

    it 'if there is title' do
      @post.title = nil
      expect(@post).to be_invalid
    end

    it 'if likes counter is integer' do
      @post.likes_counter = 'string'
      expect(@post).to be_invalid
    end

    it 'if likes counter greater than or equal to zero' do
      @post.likes_counter = -25
      expect(@post).to be_invalid
    end

    it 'if comments counter greater than or equal to zero.' do
      @post.comments_counter = -2
      expect(@post).to be_invalid
    end

    it 'if comments counter is integer' do
      @post.comments_counter = 0.25
      expect(@post).to be_invalid
    end
  end
end
