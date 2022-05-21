require 'rails_helper'
RSpec.describe Comment, type: :model do
  describe 'Validations For the Comment model' do
    before(:each) do
      @user = User.new(name: 'XXX', photo: 'XXX', bio: 'Developer from Macedonia')
      @post = Post.new(user: @user, title: 'XXX', text: 'XXX')
      @comment = Comment.new(text: 'First comment', user_id: @user.id, post_id: @post.id)
    end

    it 'Should check if comment title is given' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'Should check if user is a integer or not' do
      @comment.user_id = 'string'
      expect(@comment).to_not be_valid
    end

    it 'Should check if post is a integer or not' do
      @comment.post_id = 'string'
      expect(@comment).to_not be_valid
    end
  end
end
