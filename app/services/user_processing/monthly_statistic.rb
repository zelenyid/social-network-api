class UserProcessing::MonthlyStatistic
  class << self
    def call(user)
      new(user).run
    end
  end

  def initialize(user)
    @user = user
  end

  def run
    {
      friendship_requests: friendship_requests_count,
      posts: posts_count,
      comments: comments_count,
      likes: likes_count
    }
  end

  private

  attr_reader :user

  def friendship_requests_count
    user.received_invitations.where('created_at >= ?', 1.month.ago).count
  end

  def posts_count
    user.posts.where('created_at >= ?', 1.month.ago).count
  end

  def comments_count
    user.posts.includes(:comments).sum { |post| post.comments.where('created_at >= ?', 1.month.ago).count }
  end

  def likes_count
    user.posts.includes(:likes).sum { |post| post.likes.where('created_at >= ?', 1.month.ago).count }
  end
end
