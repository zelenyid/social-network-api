# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Model relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
end
