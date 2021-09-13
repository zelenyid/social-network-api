class SocialNetwork::V2::Friendships < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  helpers do
    def check_friend!
      @friend = User.find_by(id: params[:friend_id])
      not_found if @friend.blank?
    end
  end

  resource :friendships do
    before do
      authenticate!
      check_friend!
    end

    # POST /api/v2/friendships/:friend_id
    desc 'Send request of friendship to the user'
    params do
      requires :friend_id, type: Integer, desc: 'User ID'
    end
    post ':friend_id' do
      Friendship.create(user_sender: current_user, user_receiver: @friend, status: :sended)
    rescue ActiveRecord::RecordNotUnique
      { status: 'Friendship already exist' }
    end

    # PUT /api/v2/friendships/:friend_id
    desc 'Accept friendship with the user'
    params do
      requires :friend_id, type: Integer, desc: 'User ID'
    end
    put ':friend_id' do
      pending_invitation = current_user.pending_invitations.where(id: @friend.id)
      friendship = Friendship.sended.where(user_sender: pending_invitation).first

      if friendship.present?
        friendship.update!(status: :accepted)

        friendship
      else
        not_found
      end
    end

    # DELETE /api/v2/friendships/:friend_id
    desc 'Destroy friendship'
    params do
      requires :friend_id, type: Integer, desc: 'User ID'
    end
    delete ':friend_id' do
      friendship = Friendship.where(user_sender: @friend,
                                    user_receiver: current_user).or(Friendship.where(
                                                                      user_sender: current_user, user_receiver: @friend
                                                                    )).first

      if friendship.present?
        friendship.destroy

        { status: 'Friendship destroyed' }
      else
        not_found
      end
    end
  end
end
