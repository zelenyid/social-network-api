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
#  index_requests_on_interchangable_receiver_id_and_sender_id
#          (LEAST(user_sender_id, user_receiver_id), GREATEST(user_sender_id, user_receiver_id)) UNIQUE
#  index_requests_on_interchangable_sender_id_and_receiver_id
#          (GREATEST(user_sender_id, user_receiver_id), LEAST(user_sender_id, user_receiver_id)) UNIQUE
#
class Friendship < ApplicationRecord
  belongs_to :user_sender, class_name: 'User'
  belongs_to :user_receiver, class_name: 'User'

  enum status: { sended: 0, rejected: 1, destroyed: 2, accepted: 3 }, _prefix: true

  validates :status, presence: true

  scope :sended, -> { where(status: :sended) }
  scope :accepted, -> { where(status: :accepted) }
end
