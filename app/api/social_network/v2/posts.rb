class SocialNetwork::V2::Posts < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  resources :posts do
    before { authenticate! }

    # GET /api/v2/posts
    desc 'Return all posts'
    get do
      authorize Post, :index?

      present Post.all, with: Entities::PostEntity
    end

    # GET /api/v2/posts/:id
    desc 'Return the post'
    params do
      requires :id, type: Integer, desc: 'Post ID'
    end
    get ':id' do
      post = PostProcessing::Shower.show!(params[:id])
      not_found if post.blank?

      authorize post, :show?

      present post, with: Entities::PostEntity
    end

    # POST /api/v2/posts
    desc 'Create a post'
    params do
      requires :post, type: Hash, desc: 'Post data' do
        requires :content, type: String, desc: 'Content of the post'
      end
    end
    post do
      authorize Post, :create?

      post = PostProcessing::Creator.create!(params[:post], current_user)

      present post, with: Entities::PostEntity
    end

    # PUT /api/v2/posts/:id
    desc 'Update the post'
    params do
      requires :id, type: Integer, desc: 'Post ID'
      requires :post, type: Hash, desc: 'Post data' do
        optional :content, type: String, desc: 'Content of the post'
      end
    end
    put ':id' do
      old_post = Post.find_by(id: params[:id])
      not_found if old_post.blank?

      authorize old_post, :update?

      post = PostProcessing::Updater.update!(params[:id], params[:post])

      present post, with: Entities::PostEntity
    end

    # DELETE /api/v2/posts/:id
    desc 'Delete the post'
    params do
      requires :id, type: Integer, desc: 'Post ID'
    end
    delete ':id' do
      post = Post.find_by(id: params[:id])
      authorize post, :destroy? if post

      status = PostProcessing::Destroyer.destroy!(params[:id])

      status.presence || not_found
    end
  end
end
