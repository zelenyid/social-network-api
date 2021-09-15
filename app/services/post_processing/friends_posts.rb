class PostProcessing::FriendsPosts
  ORDER_TYPES = %w[time likes comments].freeze

  class << self
    def call(user, post_order = :time)
      new(user, post_order).run
    end
  end

  def initialize(user, post_order)
    @user       = user
    @post_order = post_order
  end

  def run
    friends = user.friends.includes(:posts)

    case post_order
    when :likes
      order_by_likes(friends)
    when :comments
      order_by_comments(friends)
    else
      order_by_time(friends)
    end
  end

  private

  def order_by_likes(friends)
    friends.map(&:posts).flatten.sort_by { |post| -post.likes.count }
  end

  def order_by_comments(friends)
    friends.map(&:posts).flatten.sort_by { |post| -post.comments.count }
  end

  def order_by_time(friends)
    friends.order('posts.created_at DESC').map(&:posts).flatten
  end

  attr_reader :user, :post_order
end
