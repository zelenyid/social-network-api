class SocialNetwork::Base < Grape::API
  format :json
  prefix :api

  rescue_from Pundit::NotAuthorizedError do |_e|
    error! 'Access Denied', 401
  end

  helpers Pundit

  mount SocialNetwork::V1::API => '/'
  mount SocialNetwork::V2::API => '/'
end
