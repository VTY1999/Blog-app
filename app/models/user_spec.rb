require 'rails_helper'

RSpec.describe User, type: :model do
  it 'test that the user is created properly' do
    name = 'Alfred'
    photo = 'https://images.unsplash.com/photo-1642024728966-7492bae9bb60?w=300'
    user = User.new(name:, photo:, bio: 'Hi', posts_counter: 0)
    expect(user).to be_valid
  end

  describe 'User model' do
    before(:each) do
      @user = User.new(name: 'XXXX', photo: 'XXXXXX', bio: 'XXXXX')
    end

    before { @user.save }

    it 'Should check if counter in intrger' do
      @user.posts_counter = 'hello'
      expect(@user).to be_invalid
    end

    it 'Shoud check if name id given' do
      @user.name = nil
      expect(@user).to be_invalid
    end

    it 'Should return 0 for recents posts' do
      expect(@user.latest_three_post.length).to eq 0
    end
  end
end
