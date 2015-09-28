FactoryGirl.define do
  factory :talent do
    sequence(:name) { |n| "talent#{n}" }
  end

end
