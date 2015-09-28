require 'rails_helper'

RSpec.describe Talent, type: :model do

  describe "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(25) }
    it "uniqeness of name" do
      create(:talent, name: 'test')
      talent = build(:talent, name: 'Test')
      expect(talent.valid?).to eq false
      expect(talent.errors.full_messages).to eq ["Name has already been taken"]
    end
  end

  it { should have_many(:talent_client_talents).dependent(:destroy) }
  it { should have_many(:talent_clients).through(:talent_client_talents) }
end
