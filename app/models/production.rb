class Production < ActiveRecord::Base
  belongs_to :show
  enum status: [ :open, :closed ]
end
