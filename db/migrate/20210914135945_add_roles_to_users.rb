class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :user_role, :boolean, default: true
  end
end
