class FriendshipMailer < ApplicationMailer
  default from: 'noreply@social_network.com'

  def friend_request
    @user_sender = params[:sender]
    @user_receiver = params[:receiver]

    mail(to: @user_receiver.email, subject: 'You have one new friend request')
  end
end
