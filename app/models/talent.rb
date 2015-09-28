class Talent < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 25 }, :allow_blank => true
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :talent_client_talents, dependent: :destroy
  has_many :talent_clients, through: :talent_client_talents
end
