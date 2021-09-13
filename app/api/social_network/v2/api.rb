class SocialNetwork::V2::API < Grape::API
  version 'v2'
  format :json

  mount SocialNetwork::V2::Posts
end
