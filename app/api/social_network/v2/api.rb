class SocialNetwork::V2::API < Grape::API
  version 'v2'
  format :json

  mount SocialNetwork::V2::Posts
  mount SocialNetwork::V2::Posts::Comments
  mount SocialNetwork::V2::Posts::Likes
end
