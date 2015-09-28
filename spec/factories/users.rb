FactoryGirl.define do
  factory :user do
    first_name{Faker::Name.first_name}
    last_name{Faker::Name.last_name}
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'changeme'
    password_confirmation 'changeme'
  end

  factory :admin, parent: :user do
    role 'admin'
  end

end
