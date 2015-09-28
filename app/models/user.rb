class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable


  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  validates :first_name, :last_name, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }

  #Note: do not change the enum values.
  enum role: { user: 0, admin: 1 }

  has_many :talent_clients, dependent: :destroy
  has_many :shows, dependent: :destroy

  def full_name
    first_name + ' ' + last_name
  end
end
