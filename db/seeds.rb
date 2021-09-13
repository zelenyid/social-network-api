if Rails.env.development?
  users = []

  5.times do |num|
    user = User.find_or_create_by({ email: "test#{num}@test.test" })
    user.name = "Name#{num}"
    user.surname = "Surname#{num}"
    user.password = 'password'
    user.password_confirmation = 'password'
    user.skip_confirmation!
    user.save!

    users << user
  end

  Friendship.find_or_create_by(user_sender: users[0], user_receiver: users[1], status: :accepted)

  5.times do |i|
    users.first.posts.find_or_create_by(content: "Test content #{i}")
  end
end
