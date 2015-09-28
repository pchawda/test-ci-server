require 'rails_helper'

RSpec.describe Character, type: :model do
  subject{build(:character)}

  describe "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:description).is_at_most(50000) }
  end
  it { should belong_to(:show) }

  describe "friedly_id name" do
    it "it should generate slug" do
      name = 'test title'
      journal = create(:character, name: name)
      expect(journal.slug).to eq name.gsub(' ', '-')
    end

    it "it should generate new slug" do
      journal = create(:character, name: 'test name' )
      new_name = "hello test"
      journal.name = new_name
      journal.save
      expect(journal.slug).to eq new_name.gsub(' ', '-')
    end
  end

end
