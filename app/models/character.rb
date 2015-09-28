class Character < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_name, use: [:slugged, :finders]

  validates :name, :description, presence: true
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 50000 }

  belongs_to :show

  private
    def should_generate_new_friendly_id?
      name_changed? || super
    end 

  def slug_name
    [
      :name,
      [self.show.slug, :name],
      [self.show.slug, :name, :show_id]
    ]
  end
end
