class AddAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :jsonb
  end
end
