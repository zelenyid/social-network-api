class PostProcessing::Creator
  attr_reader :post_params, :user

  class << self
    def create!(post_params, user)
      new(post_params, user).create!
    end
  end

  def initialize(post_params, user)
    @post_params = post_params
    @user = user
  end

  def create!
    @user.posts.create(@post_params)
  end
end
