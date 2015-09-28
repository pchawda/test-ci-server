class TalentClient < ActiveRecord::Base
  mount_uploader :profile_image, ProfileImageUploader
  extend FriendlyId
  friendly_id :slug_full_name, use: [:slugged, :finders]

  #Note: do not change the enum values.
  enum gender: { male: 0, female: 1 }

  validates :first_name, :last_name, :user_id, :bio, :profile_image, :gender, presence: true
  validates_presence_of :quote, if: 'quoter.present?'
  validates_presence_of :quoter, if: 'quote.present?'
  validate :image_size_validation, :if => "profile_image?"

  validates :first_name, :last_name, length: { maximum: 50 }
  validates :bio, length: { maximum: 50000 }

  validates_length_of :quote, :minimum => 5, :maximum => 255, :allow_blank => true
  validates_length_of :quoter, :minimum => 2, :maximum => 255, :allow_blank => true

  belongs_to :user
  has_many :talent_client_talents, dependent: :destroy
  has_many :talents, through: :talent_client_talents

  scope :recent, ->{ order(created_at: :desc)}

  def full_name
    (first_name + ' ' + last_name).humanize
  end

  def talent_names
    talents.map{|t| t.name.humanize}
  end

  protected

    def image_size_validation
      if profile_image.size > 5.megabytes
        errors.add(:base, "Image should be less than 5MB")
      end
    end

  private
    def should_generate_new_friendly_id?
      (first_name_changed? or last_name_changed?) || super
    end 

  def slug_full_name
    [
      :full_name,
      [:full_name, :user_id]
    ]
  end

end
