require 'rails_helper'

RSpec.describe UserProcessing::MonthlyStatistic do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:user) { create(:confirmed_user) }

  let(:posts_last_month) do
    create_list(:post, 4, user: user, created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let(:old_posts) do
    create_list(:post, 2, user: user, created_at: Faker::Date.between(from: 5.months.ago, to: 2.months.ago))
  end

  let!(:comments_last_month_a) do
    create_list(:comment, 2, post: posts_last_month.first,
                             created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let!(:comments_last_month_b) do
    create_list(:comment, 3, post: old_posts.first,
                             created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let!(:old_comments) do
    create_list(:comment, 2, post: posts_last_month.first,
                             created_at: Faker::Date.between(from: 5.months.ago, to: 2.months.ago))
  end

  let!(:likes_last_month_a) do
    create_list(:like, 4, post: posts_last_month.second,
                          created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let!(:likes_last_month_b) do
    create_list(:like, 2, post: old_posts.first,
                          created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let!(:old_likes) do
    create_list(:like, 3, post: posts_last_month.first,
                          created_at: Faker::Date.between(from: 5.months.ago, to: 2.months.ago))
  end

  let!(:friendship_last_month) do
    create_list(:friendship, 5, user_receiver: user,
                                created_at: Faker::Date.between(from: 1.month.ago, to: Time.zone.today))
  end
  let!(:old_friendship) do
    create_list(:friendship, 7, user_receiver: user,
                                created_at: Faker::Date.between(from: 5.months.ago, to: 2.months.ago))
  end

  let(:expected_statistic) do
    {
      friendship_requests: 5,
      posts: 4,
      comments: 5,
      likes: 6
    }
  end

  it 'returns statistic for the user' do
    statistic = described_class.call(user)

    expect(statistic).to eq(expected_statistic)
  end
end
