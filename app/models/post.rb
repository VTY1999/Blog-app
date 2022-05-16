class Post < ApplicationRecord
  after_save :posts_count
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def posts_count
    user.update!(:posts_counter)
  end

  private :posts_count
end
