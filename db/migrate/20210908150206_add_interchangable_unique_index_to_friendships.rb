class AddInterchangableUniqueIndexToFriendships < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
          connection.execute(%q(
              create unique index index_requests_on_interchangable_sender_id_and_receiver_id on friendships(greatest(user_sender_id,user_receiver_id), least(user_sender_id,user_receiver_id));
              create unique index index_requests_on_interchangable_receiver_id_and_sender_id on friendships(least(user_sender_id,user_receiver_id), greatest(user_sender_id,user_receiver_id));
          ))
      end

      dir.down do
          connection.execute(%q(
              drop index index_requests_on_interchangable_sender_id_and_receiver_id;
              drop index index_requests_on_interchangable_receiver_id_and_sender_id;
          ))
      end    
    end
  end
end
