class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  scope :of, -> (user) { where(user_id: user.id) }

  validates :name, presence: true
end
