class PostProcessing::Updater
  attr_reader :post_id, :post_params

  class << self
    def update!(post_id, post_params)
      new(post_id, post_params).update!
    end
  end

  def initialize(post_id, post_params)
    @post_id = post_id
    @post_params = post_params
  end

  def update!
    post = Post.find_by(id: @post_id)
    post.update(@post_params)

    post
  end
end
