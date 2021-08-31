class SocialNetwork::V2::Posts < Grape::API
  resources :posts do
    # /api/v2/posts
    get do
      { hello: 'world' }
    end

    # /api/v2/posts/:id
    get ':id' do
      { post_id: params[:id] }
    end
  end
end
