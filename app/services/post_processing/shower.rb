class PostProcessing::Shower
  attr_reader :post_id

  class << self
    def show!(post_id)
      new(post_id).show!
    end
  end

  def initialize(post_id)
    @post_id = post_id
  end

  def show!
    Post.find_by(id: @post_id)
  end
end
