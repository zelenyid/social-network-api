class SocialNetwork::V1::Profiles < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  before { authenticate! }

  resources :profiles do
    # PUT /api/v1/profiles/:id/ban
    desc 'Ban user'
    params do
      requires :profile_id, type: Integer, desc: 'User ID'
    end
    put ':profile_id/ban' do
      user = User.find_by(id: params[:profile_id])
      not_found if user.blank?

      ProfilePolicy.new(current_user, User).ban?

      user.update!(banned: true)

      present user, with: Entities::ProfileEntity
    end

    # PUT /api/v1/profiles/:id/unban
    desc 'Unban user'
    params do
      requires :profile_id, type: Integer, desc: 'User ID'
    end
    put ':profile_id/unban' do
      user = User.find_by(id: params[:profile_id])
      not_found if user.blank?

      ProfilePolicy.new(current_user, User).unban?

      user.update!(banned: false)

      present user, with: Entities::ProfileEntity
    end
  end
end
