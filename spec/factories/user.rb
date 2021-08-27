FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    password { Faker::Internet.password }
    password_confirmation(&:password)
  end
end
