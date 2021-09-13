class SocialNetwork::Base < Grape::API
  format :json
  prefix :api

  mount SocialNetwork::V1::API => '/'
  mount SocialNetwork::V2::API => '/'
end
