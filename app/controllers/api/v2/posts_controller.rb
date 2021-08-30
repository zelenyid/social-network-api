class API::V2::PostsController < API::V2::ApplicationController
  def index
    render json: Post.all
  end

  def show
    render json: PostProcessing::Shower.show!(params[:id])
  end

  def create
    render json: PostProcessing::Creator.create!(post_params, current_user)
  end

  def update
    render json: PostProcessing::Updater.update!(params[:id], post_params)
  end

  def destroy
    render json: PostProcessing::Destroyer.destroy!(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
