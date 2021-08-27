class API::V2::PostsController < API::V2::ApplicationController
  def index
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find_by(id: params[:id])

    render json: post
  end

  def create
    render json: PostProcessing::Creator.call(post_params)
  end

  def update
    post = Post.find_by(id: params[:id])

    post.update(post_params)

    render json: post
  end

  def destroy
    post = Post.find_by(id: params[:id])

    if post
      post.destroy
      render json: { status: 'Succesfully destroyed' }
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
