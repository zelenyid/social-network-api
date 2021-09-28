class SocialNetwork::V2::Profiles < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  resources :profiles do
    before { authenticate! }

    # GET /api/v2/profiles/:id
    desc 'Return the user'
    params do
      requires :id, type: Integer, desc: 'User ID'
    end
    get ':id' do
      user = User.find_by(id: params[:id])
      not_found if user.blank?

      ProfilePolicy.new(current_user, user).show?

      present user, with: Entities::ProfileEntity
    end
  end
end
