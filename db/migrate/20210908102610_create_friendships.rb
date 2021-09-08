class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :user_sender_id, null: false
      t.integer :user_receiver_id, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :friendships, [:user_sender_id, :user_receiver_id], unique: true
  end
end
