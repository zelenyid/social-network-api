class PostProcessing::Creator < PostProcessing::PostProcessing
  attributes :post_params, :user

  def call!
    Success result: user.posts.create(post_params)
  end
end
