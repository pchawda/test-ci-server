FactoryGirl.define do
  factory :show do
    title{Faker::Lorem.sentence}
    by{Faker::Name.name}
    music_by{Faker::Name.name}
    stage{Faker::Name.name}
    association :user
  end

end
