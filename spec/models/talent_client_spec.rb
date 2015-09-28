require 'rails_helper'

RSpec.describe TalentClient, type: :model do
  subject{build(:talent_client)}
  it { should belong_to(:user) }
  it { should have_many(:talent_client_talents).dependent(:destroy) }
  it { should have_many(:talents).through(:talent_client_talents) }
  describe "validation" do
    it { should validate_presence_of(:bio) }
    it { should validate_presence_of(:user_id) }
    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_most(50) }
    it { should validate_length_of(:bio).is_at_most(50000) }
    it { should validate_length_of(:quote).is_at_most(255)  }
    it { should validate_length_of(:quoter).is_at_most(255) }
    it { should validate_length_of(:quote).is_at_least(5) }
    it { should validate_length_of(:quoter).is_at_least(2) }
    it { should validate_presence_of(:gender) }

    it "first name presence" do
      talent_client = build(:talent_client)
      talent_client.first_name = ''
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "first name presence" do
      talent_client = build(:talent_client)
      talent_client.last_name = ''
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it "profile_image presence of" do
      talent_client = build(:talent_client, profile_image: '')
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Profile image can't be blank"]
    end

    it "profile_image invalid file" do
      talent_client = build(:talent_client_with_invalid_file)
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Profile image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", "Profile image can't be blank"]
    end

    it "profile_image wrong file size" do
      talent_client = build(:talent_client_with_high_size_file)
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Image should be less than 5MB"]
    end

    it "validates_presence_of :quote, if: 'quoter.present?'" do
      talent_client = build(:talent_client, quoter: 'test')
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Quote can't be blank"]
    end

    it "validates_presence_of :quoter, if: 'quote.present?'" do
      talent_client = build(:talent_client, quote: 'test user')
      expect(talent_client.valid?).to eq false
      expect(talent_client.errors.full_messages).to eq ["Quoter can't be blank"]
    end
  end

  it { should define_enum_for(:gender).with([:male, :female]) }

  describe "friedly_id slug_full_name" do
    it "it should generate slug" do
      first_name = 'test'
      last_name = 'last'
      talent_client = create(:talent_client, first_name: first_name, last_name: last_name)
      expect(talent_client.slug).to eq (first_name + "-" + last_name)
    end

    it "it should generate slug with user_id when its duplicate" do
      first_name = 'test'
      last_name = 'last'
      create(:talent_client, first_name: first_name, last_name: last_name)
      talent_client = create(:talent_client, first_name: first_name, last_name: last_name)
      expect(talent_client.slug).to eq [first_name, last_name, talent_client.user_id].join('-')
    end

    it "should update slug when update first_name or last_name" do
      talent_client = create(:talent_client, first_name: 'first_name', last_name: 'last_name')
      talent_client.first_name = 'new'
      talent_client.save
      expect(talent_client.reload.slug).to eq 'new-last-name'
    end
  end

  it "should delete when user delete" do
    user = create(:user)
    talent_clients = create_list(:talent_client, 5, user: user)
    talent_client = create(:talent_client)
    user.destroy
    expect(TalentClient.count).to eq 1
    expect(TalentClient.first.id).to eq talent_client.id
  end

  it "full name" do
    talent_client = create(:talent_client, first_name: 'test', last_name: 'user')
    expect(talent_client.full_name).to eq 'Test user'
  end

  describe "scopes" do
    it "recent talent_client" do
      user = create(:user)
      talent_client1 = create(:talent_client, user: user)
      talent_client2 = create(:talent_client, user: user)
      talent_client3 = create(:talent_client, user: user)
      talent_client4 = create(:talent_client, user: user)
      talent_client5 = create(:talent_client, user: user)
      expect(user.talent_clients.recent.map(&:id)).to eq [talent_client5.id, talent_client4.id, talent_client3.id, talent_client2.id, talent_client1.id]
    end
  end
end
