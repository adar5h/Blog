class AddUserIdInPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user_id, :int
  end
end
