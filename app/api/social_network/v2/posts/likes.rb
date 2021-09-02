class SocialNetwork::V2::Posts::Likes < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  helpers do
    def already_liked?
      Like.exists?(user_id: current_user.id, post_id: params[:post_id])
    end

    def check_post!
      @post = Post.find_by(id: params[:post_id])
      not_found if @post.blank?
    end
  end

  namespace 'posts/:post_id' do
    resource :likes do
      before do
        authenticate!
        check_post!
      end

      # POST /api/v2/posts/:post_id/likes
      desc 'Create a like for the post'
      params do
        requires :post_id, type: Integer, desc: 'Post ID'
      end
      post do
        if already_liked?
          { status: 'You can\'t like more than once' }
        else
          @post.likes.find_or_create_by(user_id: current_user.id)
          { status: 'Like created' }
        end
      end

      # DELETE /api/v2/posts/:post_id/likes/:id
      desc 'Unlike post'
      params do
        requires :id, type: Integer, desc: 'Comment ID'
        requires :post_id, type: Integer, desc: 'Post ID'
      end
      delete ':id' do
        if already_liked?
          like = @post.likes.find_by(id: params[:id])
          not_found if like.blank?

          like.destroy
          { status: 'Like destroyed' }
        else
          { status: 'Cannot unlike' }
        end
      end
    end
  end
end
