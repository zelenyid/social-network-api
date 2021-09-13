class SocialNetwork::V2::Posts::Comments < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  namespace 'posts/:post_id' do
    resource :comments do
      before { authenticate! }

      # GET /api/v2/posts/:post_id/comments
      desc 'Return all comments of the post'
      params do
        requires :post_id, type: Integer, desc: 'Post ID'
      end
      get do
        post = Post.find_by(id: params[:post_id])
        not_found if post.blank?

        present post.comments, with: Entities::CommentEntity
      end

      # POST /api/v2/posts/:post_id/comments
      desc 'Create a comment for the post'
      params do
        requires :post_id, type: Integer, desc: 'Post ID'
        requires :comment, type: Hash, desc: 'Comment data' do
          requires :content, type: String, desc: 'Content of the comment'
        end
      end
      post do
        post = Post.find_by(id: params[:post_id])
        not_found if post.blank?

        comment = post.comments.create!(params[:comment].merge(user: current_user))

        present comment, with: Entities::CommentEntity
      end

      # PUT /api/v2/posts/:post_id/comments/:id
      desc 'Update the comment for the post'
      params do
        requires :id, type: Integer, desc: 'Comment ID'
        requires :post_id, type: Integer, desc: 'Post ID'
        requires :comment, type: Hash, desc: 'Comment data' do
          optional :content, type: String, desc: 'Content of the comment'
        end
      end
      put ':id' do
        post = Post.find_by(id: params[:post_id])
        not_found if post.blank?
        comment = post.comments.find_by(id: params[:id])
        not_found if comment.blank?

        comment.update!(params[:comment])

        present comment, with: Entities::CommentEntity
      end

      # DELETE /api/v2/posts/:post_id/comments/:id
      desc 'Delete the comment'
      params do
        requires :id, type: Integer, desc: 'Comment ID'
        requires :post_id, type: Integer, desc: 'Post ID'
      end
      delete ':id' do
        post = Post.find_by(id: params[:post_id])
        not_found if post.blank?
        comment = post.comments.find_by(id: params[:id])
        not_found if comment.blank?

        comment.destroy
        { status: 'Succesfully destroyed' }
      end
    end
  end
end
