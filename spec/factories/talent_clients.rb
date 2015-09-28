FactoryGirl.define do
  factory :talent_client do
    first_name{Faker::Name.first_name}
    last_name{Faker::Name.last_name}
    bio{Faker::Lorem.paragraph}
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'valid.jpg')) }
    gender :male
    association :user
  end

  factory :talent_client_with_invalid_file, class: :TalentClient, parent: :talent_client do
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'invalid.txt')) }
  end

  factory :talent_client_with_high_size_file, class: :TalentClient, parent: :talent_client do
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', '6mb.jpg')) }
  end

end
