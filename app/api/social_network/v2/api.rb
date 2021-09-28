class SocialNetwork::V2::API < Grape::API
  version 'v2'
  format :json

  mount SocialNetwork::V2::Friendships

  mount SocialNetwork::V2::Conversations
  mount SocialNetwork::V2::Conversations::Messages

  mount SocialNetwork::V2::Profiles

  mount SocialNetwork::V2::Searches::ByFullName

  mount SocialNetwork::V2::Posts
  mount SocialNetwork::V2::Posts::Comments
  mount SocialNetwork::V2::Posts::Likes
end
