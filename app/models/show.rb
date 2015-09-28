class Show < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :user
  has_many :characters, dependent: :destroy
  has_many :productions, dependent: :destroy

  validates :title, :by, :music_by, :stage, :user_id, presence: true
  validates :by, :music_by, length: { maximum: 50 }
  validates :title, :stage, length: { maximum: 100 }
  validates :title, uniqueness: { case_sensitive: false }

  private
    def should_generate_new_friendly_id?
      title_changed? || super
    end 
end
