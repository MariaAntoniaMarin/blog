class Follow < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  belongs_to :user1, :class_name => 'User'
end
