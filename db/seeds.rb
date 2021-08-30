if Rails.env.development?
  user = User.find_or_create_by({ email: 'test@test.test' })
  user.name = 'Name'
  user.surname = 'Surname'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.skip_confirmation!
  user.save!

  5.times do |i|
    user.posts.find_or_create_by(content: "Test content #{i}")
  end
end
