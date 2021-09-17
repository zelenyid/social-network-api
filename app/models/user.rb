# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  surname                :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :jsonb
#  admin                  :boolean          default(FALSE)
#  user_role              :boolean          default(TRUE)
#  banned                 :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include PgSearch::Model
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  validates :email, :name, :surname, presence: true

  mount_uploader :avatar, AvatarUploader

  has_many :sended_invitations, class_name: 'Friendship', foreign_key: 'user_sender_id', inverse_of: :user_sender,
                                dependent: :destroy
  has_many :received_invitations, class_name: 'Friendship', foreign_key: 'user_receiver_id',
                                  inverse_of: :user_receiver, dependent: :destroy

  has_many :conversations, foreign_key: 'sender_id', inverse_of: :sender, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  pg_search_scope :search_by_full_name, against: %i[name surname]

  def for_display
    {
      email: email,
      id: id
    }
  end

  def friends
    friends_i_sent_invitation = sended_invitations.accepted.pluck(:user_receiver_id)
    friends_i_got_invitation = received_invitations.accepted.pluck(:user_sender_id)
    ids = friends_i_sent_invitation + friends_i_got_invitation

    User.where(id: ids)
  end

  def pending_invitations
    User.where(id: received_invitations.sended.pluck(:user_sender_id))
  end

  def friend_with?(user)
    send_friendship = sended_invitations.accepted.where(user_receiver_id: user.id).present?
    receive_friendship = received_invitations.accepted.where(user_sender_id: user.id).present?

    send_friendship || receive_friendship
  end

  def full_name
    "#{name} #{surname}"
  end
end
