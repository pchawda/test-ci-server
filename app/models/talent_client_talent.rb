class TalentClientTalent < ActiveRecord::Base
  belongs_to :talent_client
  belongs_to :talent
end
