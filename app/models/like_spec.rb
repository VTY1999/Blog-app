require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations For the Like model' do
    before(:each) do
      @user = User.create(name: 'Nuri', photo: 'image_link', bio: 'Developer from Macedonia')
      @post = Post.create(user: @user, title: 'My title', text: 'My text')
      @like = Like.create(user: @user, post_id: @post.id)
    end

    it 'Should check if post id is nil' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end

    it 'Should check if user id is wrong' do
      @like.user_id = false
      expect(@like).to_not be_valid
    end

    it 'Should check if like length is 0' do
      expect(@post.likes.length).to eq 0
    end
  end
end
