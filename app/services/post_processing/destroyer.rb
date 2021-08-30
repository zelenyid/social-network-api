class PostProcessing::Destroyer
  attr_reader :post_id

  class << self
    def destroy!(post_id)
      new(post_id).destroy!
    end
  end

  def initialize(post_id)
    @post_id = post_id
  end

  def destroy!
    post = Post.find_by(id: @post_id)

    if post
      post.destroy
      { status: 'Succesfully destroyed' }
    else
      { error: 'Not found' }
    end
  end
end
