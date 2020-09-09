FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user1@test.com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    admin { false }
  end

  factory :admin_user, class: User do
    name { "admin1" }
    email { "admin1@test.com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    admin { true }
  end
end
