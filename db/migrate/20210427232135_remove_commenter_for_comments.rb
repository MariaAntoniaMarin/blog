class RemoveCommenterForComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :commenter
  end
end
