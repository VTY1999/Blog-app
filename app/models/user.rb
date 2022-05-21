class User < ApplicationRecord
  validates_presence_of :name
  validates :posts_counter, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  has_many :posts, foreign_key: 'user_id', dependent: :destroy
  has_many :comments, foreign_key: 'user_id', dependent: :destroy
  has_many :likes, foreign_key: 'user_id', dependent: :destroy

  def latest_three_post
    posts.order(created_at: :desc).limit(3)
  end
end
