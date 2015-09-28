require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should define_enum_for(:role).with([:user, :admin]) }
  it { should validate_length_of(:first_name).is_at_most(50) }
  it { should validate_length_of(:last_name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should have_many(:talent_clients).dependent(:destroy) }
  it { should have_many(:shows).dependent(:destroy) }

  describe "user role" do
    it "default will be user" do
      user = create(:user)
      expect(user.user?).to eq true
    end

    it "will be admin" do
      user = create(:admin)
      expect(user.admin?).to eq true
    end
  end

  describe "validation" do
    it "first_name length" do
      user = build(:user)
      user.first_name = (0...51).map { ('a'..'z').to_a[rand(26)] }.join
      expect(user.valid?).to eq false
      expect(user.errors.full_messages).to eq ["First name is too long (maximum is 50 characters)"]
    end

    it "last_name length" do
      user = build(:user)
      user.last_name = (0...51).map { ('a'..'z').to_a[rand(26)] }.join
      expect(user.valid?).to eq false
      expect(user.errors.full_messages).to eq ["Last name is too long (maximum is 50 characters)"]
    end
  end

  it "full name" do
    first_name = "test"
    last_name = "user"
    user = create(:user, first_name: first_name, last_name: last_name)
    expect(user.full_name).to eq (first_name + ' ' + last_name)
  end

end
