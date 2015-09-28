require 'rails_helper'

RSpec.describe TalentClientTalent, type: :model do
  it { should belong_to(:talent_client) }
  it { should belong_to(:talent) }
end
