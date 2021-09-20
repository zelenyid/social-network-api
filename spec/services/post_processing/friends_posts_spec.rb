require 'rails_helper'

RSpec.describe PostProcessing::FriendsPosts do
  let(:user) { create(:user) }
  let(:friend_a) { create(:user) }
  let(:friend_b) { create(:user) }
  let(:friend_c) { create(:user) }
  let!(:friend_a_posts) { create_list(:post, 3, user: friend_a) }
  let!(:friend_b_posts) { create_list(:post, 3, user: friend_b) }
  let!(:friend_c_posts) { create_list(:post, 3, user: friend_c) }

  let(:friends_posts) { [friend_a_posts, friend_b_posts, friend_c_posts].reduce([], :concat) }

  before do
    create(:friendship, user_sender: user, user_receiver: friend_a)
    create(:friendship, user_sender: user, user_receiver: friend_b)
    create(:friendship, user_sender: user, user_receiver: friend_c)
  end

  context 'when we sort by time' do
    let(:friends_posts_by_time) { friends_posts.sort_by(&:created_at).reverse! }

    it 'returns all friend\'s posts by time order' do
      posts = described_class.call(user)

      expect(posts).to eq(friends_posts_by_time)
    end
  end

  context 'when we sort by likes' do
    let(:friends_posts_by_likes) { friends_posts.sort_by { |post| -post.likes.count } }

    before do
      create_list(:like, 4, post: friend_a_posts[0])
      create_list(:like, 3, post: friend_b_posts[1])
      create_list(:like, 6, post: friend_c_posts[2])
      create_list(:like, 3, post: friend_c_posts[1])
    end

    it 'returns all friend\'s posts by likes order' do
      posts = described_class.call(user, :likes)

      expect(posts).to eq(friends_posts_by_likes)
    end
  end

  context 'when we sort by comments' do
    let(:friends_posts_by_comments) { friends_posts.sort_by { |post| -post.comments.count } }

    before do
      create_list(:comment, 4, post: friend_a_posts[1])
      create_list(:comment, 3, post: friend_b_posts[2])
      create_list(:comment, 6, post: friend_c_posts[0])
      create_list(:comment, 3, post: friend_c_posts[1])
    end

    it 'returns all friend\'s posts by comments order' do
      posts = described_class.call(user, :comments)

      expect(posts).to eq(friends_posts_by_comments)
    end
  end
end
