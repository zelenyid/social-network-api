# == Schema Information
#
# Table name: friendships
#
#  id               :bigint           not null, primary key
#  user_sender_id   :integer          not null
#  user_receiver_id :integer          not null
#  status           :integer          default("sended")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_sender_id_and_user_receiver_id    (user_sender_id,user_receiver_id) UNIQUE
#  index_requests_on_interchangable_receiver_id_and_sender_id  (LEAST(user_sender_id, user_receiver_id), GREATEST(user_sender_id, user_receiver_id)) UNIQUE
#  index_requests_on_interchangable_sender_id_and_receiver_id  (GREATEST(user_sender_id, user_receiver_id), LEAST(user_sender_id, user_receiver_id)) UNIQUE
#
FactoryBot.define do
  factory :friendship do
    association :user_sender, factory: :user
    association :user_receiver, factory: :user

    status { :accepted } # [:sended, :accepted]
  end
end
