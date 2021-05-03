class RenameColumnsNameToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :user_id, :follower_id
    rename_column :follows, :user1_id, :followed_id
  end
end
