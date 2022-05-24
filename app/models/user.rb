class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates_presence_of :name, presence: true
  validates :posts_counter, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :email, confirmation: true
  has_many :posts, foreign_key: 'user_id'
  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'

  def latest_three_post
    posts.order(created_at: :desc).limit(3)
  end
end
