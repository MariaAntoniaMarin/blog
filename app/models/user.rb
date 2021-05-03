class User < ApplicationRecord
  has_secure_password

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follows, foreign_key: "follower_id"

  validates :username, presence: true, uniqueness: true
end
