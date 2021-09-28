class SocialNetwork::V2::Searches::ByFullName < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  namespace :search do
    resource :by_full_name do
      before { authenticate! }

      desc 'Search users'
      params do
        requires :q, type: String, desc: 'Search params'
      end
      get do
        users = User.search_by_full_name(params[:q])

        SearchPolicy.new(current_user, User).by_full_name?

        present users, with: Entities::ProfileEntity
      end
    end
  end
end
