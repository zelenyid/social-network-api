# Preview all emails at http://localhost:3000/rails/mailers/friendship
class FriendshipPreview < ActionMailer::Preview
  def friend_request
    FriendshipMailer.with(sender: User.first, receiver: User.second).friend_request
  end
end
