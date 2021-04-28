class AddUserToArticlesAndComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :user
    add_reference :articles, :user
  end
end
