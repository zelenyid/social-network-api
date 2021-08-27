module PostAPI
  class Post < Grape::API
    prefix :api
    version 'v1'
    format :json

    resources :posts do
      # /api/v1/posts
      get do
        { hello: 'world' }
      end

      # /api/v1/posts/:id
      get ':id' do
        { post_id: params[:id] }
      end
    end
  end
end
