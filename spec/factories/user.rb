FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    password { 'super_secret' }
    password_confirmation { 'super_secret' }
  end
end
